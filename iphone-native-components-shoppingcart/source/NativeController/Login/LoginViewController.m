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
    
    [self createLoginScreen];
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

-(void) createLoginScreen
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, 768, 400)];
        
        [bgView setImage:[UIImage imageNamed:@"login_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
        UIImageView	*loginHeader = [[UIImageView alloc] initWithFrame:CGRectMake(230, 200, 300, 60)];
        
        [loginHeader setImage:[UIImage imageNamed:@"login_header.png"]];
        
        [self.view addSubview:loginHeader];
        
        loginHeader = nil;
        
        emailAddress = [[UITextField alloc] initWithFrame:CGRectMake(60, 300, 650, 60)];
        
        emailAddress.delegate = self;
        
        emailAddress.tag = kEmailAddress;
        
        emailAddress.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.view addSubview:emailAddress];
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(60, 455, 650, 60)];
        
        password.delegate = self;
        
        password.tag = kPassword;
        
        password.borderStyle = UITextBorderStyleRoundedRect;
        
        [password setSecureTextEntry:YES];
        
        [self.view addSubview:password];
        
        
        int x = 60;
        
        int y = 250;
        
        int width = 250;
        
        int height = 50;
        
        NSMutableArray *labelName = [[NSMutableArray alloc] initWithObjects:@"Email Address", @"Password", nil];
        
        for(int i = 0; i<[labelName count]; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            [label setText:[labelName objectAtIndex:i]];
            
            [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
            
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setTextColor:[UIColor whiteColor]];
            
            [self.view addSubview:label];
            
            y = y + 140;
            
            label = nil;
        }
        
        labelName = nil;
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"login_btn.png"], [UIImage imageNamed:@"cancel_btn.png"],  nil];
        
        int buttonX = 420;
        
        int buttonY = 500;
        
        int buttonWidth = 240;
        
        int buttonHeight = 180;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
            
            [button setImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            if(i == 0) {
                
                [button addTarget:self action:@selector(loginButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if(i == 1) {
                
                [button addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            buttonX = buttonX + 160;
            
            button = nil;
        }
        
        registerButton = [[UIButton alloc] init];
        
        [registerButton setFrame:CGRectMake(300, 700, 240, 60)];
        
        [registerButton setBackgroundImage:[UIImage imageNamed:@"register_btn"] forState:UIControlStateNormal];
        
        [registerButton addTarget:self action:@selector(registerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:registerButton];
    }
    else {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, 320, 240)];
        
        [bgView setImage:[UIImage imageNamed:@"login_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
        
        UIImageView	*loginHeader = [[UIImageView alloc] initWithFrame:CGRectMake(90, 70, 150, 30)];
        
        [loginHeader setImage:[UIImage imageNamed:@"login_header.png"]];
        
        [self.view addSubview:loginHeader];
        
        loginHeader = nil;
        
        strMsg = [[NSMutableString alloc] init];
        successMsg = [[NSMutableString alloc] init];
        userID = [[NSMutableString alloc] init];
        userName = [[NSMutableString alloc] init];
        
        loginArray =[[NSMutableArray alloc] init];
        
        emailAddress = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 270, 30)];
        
        emailAddress.delegate = self;
        
        emailAddress.tag = kEmailAddress;
        
        emailAddress.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.view addSubview:emailAddress];
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(emailAddress.frame.origin.x, emailAddress.frame.origin.y + emailAddress.frame.size.height + 45, emailAddress.frame.size.width, emailAddress.frame.size.height)];
        
        
        password.delegate = self;
        
        password.tag = kPassword;
        
        password.borderStyle = UITextBorderStyleRoundedRect;
        
        [password setSecureTextEntry:YES];
        
        [self.view addSubview:password];
        
        
        int x = emailAddress.frame.origin.x;
        
        int y = emailAddress.frame.origin.y - 35;
        
        int width = 100;
        
        int height = 30;
        
        NSMutableArray *labelName = [[NSMutableArray alloc] initWithObjects:@"Email Address", @"Password", nil];
        
        for(int i = 0; i<[labelName count]; i++)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            [label setText:[labelName objectAtIndex:i]];
            
            [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
            
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setTextColor:[UIColor whiteColor]];
            
            [self.view addSubview:label];
            
            y = y + 80;
            
            label = nil;
        }
        
        labelName = nil;
        
        int buttonY = password.frame.origin.y + 35;
        
        
        loginButton = [[UIButton alloc] init];
        
        [loginButton setFrame:CGRectMake(170, buttonY, 60, 40)];
        
        [loginButton setImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
        
        [loginButton addTarget:self action:@selector(loginButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginButton];
        
        loginButton.accessibilityLabel =@"log";
        
        
        cancelButton = [[UIButton alloc] init];
        
        [cancelButton setFrame:CGRectMake(240, buttonY, 60, 40)];
        
        [cancelButton setImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
        
        [cancelButton addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:cancelButton];
        
        cancelButton.accessibilityLabel = @"logCancel";
        
        registerButton = [[UIButton alloc] init];
        
        [registerButton setFrame:CGRectMake(100, 350, 120, 30)];
        
        [registerButton setBackgroundImage:[UIImage imageNamed:@"register_btn.png"] forState:UIControlStateNormal];
        
        [registerButton addTarget:self action:@selector(registerButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        registerButton.accessibilityLabel =@"logRegister";
        
        [self.view addSubview:registerButton];
                
    }
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (void)serviceCall {
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        serviceHandler.loginId = (NSMutableString*)emailAddress.text;
        
        serviceHandler.pwd = (NSMutableString*)password.text;
        
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
            viewController_.frame = CGRectMake(40, 300, 580, 260);
            
            UILabel *label = [[UILabel alloc] init];
            label.text = successMsg;
            label.frame = CGRectMake(120, 60, 300, 40);
            label.textColor =[UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            
            label.accessibilityLabel =@"LoginResult";
            
            label.accessibilityValue = successMsg;
            
            label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:24];
            UIImageView *myImageView = [[UIImageView alloc] initWithImage :
                                        [UIImage imageNamed :@"popup_bg.png"]];
            [viewController_ addSubview:myImageView];
            [viewController_ addSubview:label];
            [self.view addSubview:viewController_];
            if(unitTestCheck == NO) {
                [self.view addSubview:viewController_];
            }
            okButton = [[UIButton alloc] init];
            
            [okButton setFrame:CGRectMake(240, 160, 100, 60)];
            
            [okButton setBackgroundImage:[UIImage imageNamed:@"ok_btn.png"] forState:UIControlStateNormal];
            
            [okButton addTarget:self action:@selector(okButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [viewController_ addSubview:okButton];
            
            okButton.accessibilityLabel = @"loginOkbutton";
            
        }
        else {
            
            [activityIndicator stopAnimating];
            UIView *viewController_ = [[UIView alloc] init];
            viewController_.frame = CGRectMake(20, 150, 390, 120);
            
            viewController_.isAccessibilityElement=NO; //Added for Automation testing
            viewController_.accessibilityLabel = @"AlertView";
            
            UILabel *label = [[UILabel alloc] init];
            label.text = successMsg;
            label.frame = CGRectMake(80, 30, 150, 20);
            
            label.textColor =[UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            label.adjustsFontSizeToFitWidth = YES;
            
            label.accessibilityLabel =@"LoginResult";
            
            label.accessibilityValue = successMsg;
            
            label.font = [UIFont fontWithName:@"Times New Roman-Regular" size:12];
            UIImageView *myImageView = [[UIImageView alloc] initWithImage :
                                        [UIImage imageNamed :@"popup_bg.png"]];
            [viewController_ addSubview:myImageView];
            [viewController_ addSubview:label];
            
            if(unitTestCheck == NO) {
                
                [self.view addSubview:viewController_];
            }
            okButton = [[UIButton alloc] init];
            
            [okButton setFrame:CGRectMake(120, 80, 50, 30)];
            
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
    
    NSLog(@"login button selected:");
    if(unitTestCheck == NO) {
        
        NSLog(@"login button selected:if condition");
        [self showAlerts];
        
        
    }
    else {
        NSLog(@"login button selected: else condition");
        [self serviceCall];
    }
}

-(void)showAlerts {
    
    
    NSString* str1 =emailAddress.text ;
    
    NSString* str2 =password.text ;
    
    
    NSLog(@"email and pwd :%@ %@", emailAddress.text, password.text);
    
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
        
        [self serviceCall];
        
        
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

- (void)cancelButtonSelected:(id)sender
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
