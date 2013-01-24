//
//  LoginViewController.m
//  Phresco
//
//  Created by Rojaramani on 24/10/12.
//
//

#import "LoginViewController.h"
#import "Constants.h"
#import "DataModelEntities.h"
#import "ServiceHandler.h"
#import "SharedObjects.h"
#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "Tabbar.h"
#import "SubmitReviewViewController.h"
#import "BrowseViewController.h"
#import "HomeViewController.h"
#import "ConfigurationReader.h"
#import "NavigationView.h"
#import "LoginView.h"
#import "Constants.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize emailAddress;
@synthesize password;
@synthesize registrationViewController;
@synthesize backButton;
@synthesize closeButton;
@synthesize okButton;
@synthesize registerButton;
@synthesize button_;
@synthesize loginButton;
@synthesize cancelButton;
@synthesize activityIndicator;
@synthesize isLogin;
@synthesize strMsg;
@synthesize userID;
@synthesize userName;
@synthesize successMsg;
@synthesize loginArray;
@synthesize submitReviewViewController;
@synthesize browseViewController;
@synthesize homeViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"LoginViewController-iPad" bundle:nil];
		
	}
	else
    {
        self = [super initWithNibName:@"LoginViewController" bundle:nil];
        
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        tabbar = [[Tabbar alloc] initWithFrame:CGRectMake(0, 935, 768, 99)];
    }
    else {
        
        tabbar = [[Tabbar alloc] initWithFrame:kTabbarRect];
    }
    NSMutableArray *names = [NSMutableArray array];
    
    int startIndex = 0;
    
    int lastIndex = 4;
    
    for(int i = startIndex; i <= lastIndex; i++) {
        [names addObject:[assetsData.featureLayout objectAtIndex:i]];
    }
    
    //create tabbar with given features
    [tabbar initWithInfo:names];
    
    [self.view addSubview:(UIView*)tabbar];
    
    [tabbar setSelectedIndex:0 fromSender:nil];
    NavigationView *navBar=nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        navBar = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    }
    else{
        navBar = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
    }
    navBar.navigationDelegate = self;
    [navBar loadNavbar:YES:NO];
    [self.view addSubview:navBar];

	[self loadOtherViews];
   [self loadRegisterButton];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"login_bg" ofType:@"png"];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:filePath];
    LoginView *loginView =nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        loginView= [[LoginView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, bgImage.size.height + 160)];
    }
    else{
        loginView= [[LoginView alloc] initWithFrame:CGRectMake(0, 40, bgImage.size.width, bgImage.size.height + 30)];
    }
    [loginView createLoginView];
    loginView.loginDelegate=self;
    [self.view addSubview:loginView];

    
}
-(void) loadRegisterButton{
    registerButton = [[UIButton alloc] init];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
    
    [registerButton setFrame:CGRectMake(260, 650, 240, 60)];
    }
    else{
        [registerButton setFrame:CGRectMake(100, 370, 120, 30)];
    }
    [registerButton setBackgroundImage:[UIImage imageNamed:@"register_btn"] forState:UIControlStateNormal];
    
    [registerButton addTarget:self action:@selector(registerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerButton];

}
-(void) loadOtherViews
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 860)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
    }
    else {
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40,SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
    }
	
}

-(void) goBack:(id) sender
{
	[self.view removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (void)serviceCall:(NSString*)email PASSWORD:(NSString*)passwd {
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        serviceHandler.loginId = [NSMutableString stringWithString:email];
        
        serviceHandler.pwd = [NSMutableString stringWithString:passwd];
        
        NSMutableDictionary* loginDict= [[NSMutableDictionary alloc] init];
        
        [loginDict setObject:serviceHandler.loginId  forKey:kloginEmail];
        
        [loginDict setObject:serviceHandler.pwd  forKey:kpassword];
        
        serviceHandler.loginId =[loginDict objectForKey:kloginEmail];
        
        serviceHandler.pwd =[loginDict objectForKey:kpassword];
        
        NSDictionary* dict = [NSDictionary dictionaryWithObject:loginDict forKey:klogin];
              
        ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
        [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
        
             NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
        protocol = [protocol stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
        host = [host stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
        port = [port stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
        context = [context stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kpost,klogin];
        
        NSLog(@"urlString %@",urlString);
        NSData* postData = [NSJSONSerialization dataWithJSONObject:dict
                                                           options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"post data");
        NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
        [request setHTTPBody:postData];
        
        NSURLResponse *urlResponse;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:nil];
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        strMsg = [response objectForKey:@"message"];
        
        successMsg = [response objectForKey:@"successMessage"];
        
        userID = [response objectForKey:@"userId"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // saving an NSString
        [prefs setObject:userID forKey:@"userId"];
        
        userName = [response objectForKey:@"userName"];
        
        [prefs setObject:userName forKey:@"userName"];
        
        index= [userID intValue];
        
        NSLog(@"Else condition");
        if(index == 0 )
        {
            isLogin = NO;
        }
    else
     {
        isLogin =  YES;
        homeViewController.array_ = loginArray;

    }
        //Pop up screen
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [activityIndicator stopAnimating];
        UIView *viewController_ = [[UIView alloc] init];
        UIImageView *myImageView = [[UIImageView alloc] initWithImage :
                                    [UIImage imageNamed :@"popup_bg.png"]];
        viewController_.frame = CGRectMake((SCREENWIDTH-myImageView.frame.size.width)/2, (SCREENHEIGHT-myImageView.frame.size.height)/2, myImageView.frame.size.width,myImageView.frame.size.height);
        
        viewController_.isAccessibilityElement=NO; //Added for Automation testing
        viewController_.accessibilityLabel = @"AlertView";
        
        UILabel *label = [[UILabel alloc] init];
        label.text = successMsg;
        label.frame = CGRectMake(viewController_.frame.size.width/2-45, viewController_.frame.size.height/2-45, 150, 20);
        label.textColor =[UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = YES;
        
        label.accessibilityLabel =@"LoginResult";
        
        label.accessibilityValue = successMsg;
        
        label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:24];
        
        [viewController_ addSubview:myImageView];
        [viewController_ addSubview:label];
        
        if(unitTestCheck == NO) {
            
            [self.view addSubview:viewController_];
        }
        okButton = [[UIButton alloc] init];
        UIImage *okButtonImage=[UIImage imageNamed:@"ok_btn.png"];
        [okButton setFrame:CGRectMake((viewController_.frame.size.width-okButtonImage.size.width)/2, (viewController_.frame.size.height-okButtonImage.size.height)/2,okButtonImage.size.width,okButtonImage.size.height)];
        
        [okButton setBackgroundImage:okButtonImage forState:UIControlStateNormal];
        
        [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        okButton.accessibilityLabel = @"loginOkbutton";
        
        [viewController_ addSubview:okButton];
        [backButton setUserInteractionEnabled:NO];
        [registerButton setUserInteractionEnabled:NO];
        [loginButton setUserInteractionEnabled:NO];
        [cancelButton setUserInteractionEnabled:NO];
        
    }
        else {
            
            [activityIndicator stopAnimating];
            UIView *viewController_ = [[UIView alloc] init];
            UIImageView *myImageView = [[UIImageView alloc] initWithImage :
                                        [UIImage imageNamed :@"popup_bg.png"]];
            viewController_.frame = CGRectMake((SCREENWIDTH-myImageView.frame.size.width)/2, (SCREENHEIGHT-myImageView.frame.size.height)/2, myImageView.frame.size.width,myImageView.frame.size.height);
            
            viewController_.isAccessibilityElement=NO; //Added for Automation testing
            viewController_.accessibilityLabel = @"AlertView";
            
            UILabel *label = [[UILabel alloc] init];
            label.text = successMsg;
            label.frame = CGRectMake(viewController_.frame.size.width/2-45, viewController_.frame.size.height/2-45, 150, 20);
            label.textColor =[UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            
            label.accessibilityLabel =@"LoginResult";
            
            label.accessibilityValue = successMsg;
            
            label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:12];
            
            [viewController_ addSubview:myImageView];
            [viewController_ addSubview:label];
            
            if(unitTestCheck == NO) {
                
                [self.view addSubview:viewController_];
            }
            okButton = [[UIButton alloc] init];
            UIImage *okButtonImage=[UIImage imageNamed:@"ok_btn.png"];
            
            [okButton setFrame:CGRectMake((viewController_.frame.size.width-okButtonImage.size.width)/2, (viewController_.frame.size.height-okButtonImage.size.height)/2, okButtonImage.size.width,okButtonImage.size.height)];
            [okButton setBackgroundImage:okButtonImage forState:UIControlStateNormal];
            
            [okButton setBackgroundImage:[UIImage imageNamed:@"ok_btn.png"] forState:UIControlStateNormal];
            
            [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            okButton.accessibilityLabel = @"loginOkbutton";
            
            [viewController_ addSubview:okButton];
            [backButton setUserInteractionEnabled:NO];
            [registerButton setUserInteractionEnabled:NO];
            [loginButton setUserInteractionEnabled:NO];
            [cancelButton setUserInteractionEnabled:NO];
            
        }
       
    }

///Unit test validation

- (void)loginButtonSelected:(id)sender
{
    if(unitTestCheck == NO) {        
        
    }
    else {
        //[self serviceCall];
    }
}

-(void)loginButtonAction:(NSString*)email PASSWORD:(NSString *)passwd {
    [self showAlerts:email PASSWORD:passwd];
}

-(void)showAlerts:(NSString*) email PASSWORD:(NSString*)passwd {
    
    NSString* str1 = email;
    NSString* str2 = passwd;
    
    if( ([str1 length] == 0) && ([str2 length] > 0) ){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  Email address " delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
        [alert show];
        alert = nil;
    }
    else if( ([str1 length] > 0 ) && ([str2 length]== 0) )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter  password " delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
        [alert show];
        alert = nil;
    }
    
    else  if(([str1 length] == 0 ) && ([str2 length]== 0) ){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Email address and password " delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
        [alert show];
        alert = nil;
    }
    
    else {
        
        [self serviceCall:email PASSWORD:passwd];
    }
}



-(void)testLoginButton:(id)sender userName:(NSString*)user  passWord:(NSString*)pwd {
    
    emailAddress = [[UITextField alloc] init];
    password =[[UITextField alloc] init];
    
    emailAddress.text = user;
    NSLog(@"emailAddress.text :%@", emailAddress.text);
    
    password.text = pwd;
    NSLog(@"password.text :%@", password.text);
    
    unitTestCheck = YES;
    [self loginButtonSelected:nil];
    
    
}
////End of unit test validation
- (void)okButtonSelected:(id)sender
{
    
    [self.view removeFromSuperview];
    [backButton setUserInteractionEnabled:YES];
    [registerButton setUserInteractionEnabled:YES];
    [loginButton setUserInteractionEnabled:YES];
    [cancelButton setUserInteractionEnabled:YES];
    
}

- (void)cancelButtonAction
{
    [self.view removeFromSuperview];
    
}

- (void)registerButtonSelected:(id)sender
{
    
   RegistrationViewController	*tempBrowseViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
   
   self.registrationViewController = tempBrowseViewController;
   
   [self.view addSubview:registrationViewController.view];
   
   tempBrowseViewController = nil;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
}
-(void)backButtonAction{
    [self.view removeFromSuperview];
}



@end
