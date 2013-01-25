//
//  HomeViewController.m
//  Phresco
//
//  Created by Rojaramani on 04/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HomeViewController.h"
#import "ServiceHandler.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "Tabbar.h"
#import "ViewController.h"
#import "Tabbar.h"
#import "BrowseViewController.h"
#import "ResultViewController.h"
#import "SpecialOffersViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "NavigationView.h"
#import "Constants.h"
#import "DashBoardView.h"

@implementation HomeViewController

@synthesize searchTextField;
@synthesize activityIndicator;
@synthesize array_;
@synthesize browseViewController;
@synthesize specialOffersViewController;
@synthesize resultViewController;
@synthesize loginViewController;
@synthesize registrationViewController;
@synthesize dashBoard;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"HomeViewController-iPAd" bundle:nil];
		
	}
	else
    {
        self = [super initWithNibName:@"HomeViewController" bundle:nil];
        
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
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
        navBarHieght = navBar.frame.size.height;
    }
    else{
        navBar = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
        navBarHieght = navBar.frame.size.height;
        
    }
    navBar.navigationDelegate = self;
    [navBar loadNavbar:NO:NO];
    [self.view addSubview:navBar];
	[self loadOtherViews];
	
	[self addSearchBar];
    
    [self addHomePageIcons];
	
}

-(void) loadOtherViews
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 860)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
    }
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
    }
	
}

-(void) addSearchBar
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 81 , 768, 145)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(12, 116 , 670, 65)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        
        searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 130, 620, 50)];
        searchTextField.delegate = self;
        searchTextField.backgroundColor = [UIColor clearColor];
        searchTextField.font = [UIFont systemFontOfSize:17.0];
        searchTextField.textColor = [UIColor blackColor];
        [self.view addSubview:searchTextField];
        
        searchBarHieght =  searchBarView.frame.size.height;
        
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(695, 115, 60, 60)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        btnSearchIcon.accessibilityLabel = @"Searchbutton";
        
    }
    else {
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 , 320, 40)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
        
        [self.view addSubview:searchBarView];
        
        UIImageView *searchText = [[UIImageView alloc] initWithFrame:CGRectMake(8, 44 , 275, 30)];
        
        [searchText setImage:[UIImage imageNamed:@"searchbox.png"]];
        
        [self.view addSubview:searchText];
        
        
        searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 48, 245, 24)];
        searchTextField.delegate = self;
        searchTextField.backgroundColor = [UIColor clearColor];
        searchTextField.textColor = [UIColor blackColor];
        [self.view addSubview:searchTextField];
        
        searchBarHieght =  searchBarView.frame.size.height;
        
        btnSearchIcon = [[UIButton alloc]initWithFrame:CGRectMake(285, 43, 30, 32)];
        [btnSearchIcon setBackgroundImage:[UIImage imageNamed:@"searchbox_icon.png"] forState:UIControlStateNormal];
        [btnSearchIcon addTarget:self action:@selector(searchButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSearchIcon];
        btnSearchIcon.accessibilityLabel = @"Searchbutton";
        
        
    }
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString* str = textField.text;
    
    if([str length] > 0 ){
        
        
        [self searchButtonSelected];
    }
    else
    {
        [textField resignFirstResponder];
        
    }
    
    return YES;
}

#pragma mark searchButtonSelected
- (void)searchButtonSelected
{
    [searchTextField resignFirstResponder];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 150, 50, 40);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    if([searchTextField.text length] > 0)
    {
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        
        service.productName = searchTextField.text;
        
        [service   searchProductsService:self:@selector(finishedProductDetialsService:)];
        
    }
    else
    {
        [activityIndicator stopAnimating];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Search Product" message:@"Enter a product name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}


-(void) finishedProductDetialsService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductModel:data];
    
    if([assetsData.productArray count] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Product not found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        alert = nil;
    }
    else {
        
        ResultViewController	*tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        
        self.resultViewController = tempResultViewController;
        
        [self.view addSubview:tempResultViewController.view];
        
        tempResultViewController =nil;
    }
}

-(void) addHomePageIcons
{
    dashBoard  = [[DashBoardView alloc] init];
    dashBoard.delegate  = self;
    [dashBoard loadComponents];
    UIImageView* bgView = [[UIImageView alloc] init]; //homepage icon background view
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    float width;
    float height;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bgView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icons_bg-72" ofType:@"png"]];
        width  = bgView.image.size.width;
        height = bgView.image.size.height;
        
        dashBoard.frame = CGRectMake(self.view.frame.origin.x + 70, (navBarHieght + searchBarHieght + 40), width ,height);
        
    }
    else {
        bgView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icons_bg" ofType:@"png"]];
        float width  = bgView.image.size.width;
        float height = bgView.image.size.height;
        dashBoard.frame = CGRectMake(self.view.frame.origin.x + 5, (navBarHieght + searchBarHieght +10), width ,height);
    }
    [self.view addSubview:dashBoard];
}


- (void)callViewController:(id)sender
{
	UIButton *button = (UIButton*) sender;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	if([button.titleLabel.text isEqualToString:@"Login"])
	{
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            LoginViewController *tempLoginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController-iPad" bundle:nil];
            self.loginViewController = tempLoginViewController;
            [self.view addSubview:loginViewController.view];
            
            tempLoginViewController = nil;
        }
        else {
            
            LoginViewController *tempLoginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            
            self.loginViewController = tempLoginViewController;
            
            [self.view addSubview:loginViewController.view];
            
            tempLoginViewController = nil;
        }
		
	}
    
    else if([button.titleLabel.text isEqualToString:@"Register"])
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            RegistrationViewController *tempRegistrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController-iPAd" bundle:nil];
            
            self.registrationViewController = tempRegistrationViewController;
            
            [self.view addSubview:registrationViewController.view];
            
            tempRegistrationViewController = nil;
        }
        else {
            
            
            RegistrationViewController *tempRegistrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
            
            self.registrationViewController = tempRegistrationViewController;
            
            [self.view addSubview:registrationViewController.view];
            
            tempRegistrationViewController = nil;
        }
        
    }
	else if([button.titleLabel.text isEqualToString:@"Browse"])
	{
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        [serviceHandler catalogService:self :@selector(finishedCatalogService:)];
        
        serviceHandler = nil;
        
	}
    
    else if([button.titleLabel.text isEqualToString:@"SpecialOffer"])
    {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
        
        [serviceHandler specialProductsService:self :@selector(finishedSpecialProductsService:)];
        
        serviceHandler = nil;
        
    }
	
}

-(void) finishedCatalogService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    [assetsData updateCatalogModel:data];
    [activityIndicator stopAnimating];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController-iPad" bundle:nil];
        self.browseViewController = tempBrowseViewController;
        [self.view addSubview:browseViewController.view];
        tempBrowseViewController = nil;
    }
    else {
        if(loginViewController.isLogin == YES) {
            BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
            self.browseViewController = tempBrowseViewController;
            browseViewController.loginChk  = YES;
            tempBrowseViewController.array_ = array;
            [self.view addSubview:browseViewController.view];
            tempBrowseViewController = nil;
        }
        else {
            BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
            self.browseViewController = tempBrowseViewController;
            [self.view addSubview:browseViewController.view];
            tempBrowseViewController = nil;
        }
    }
}



-(void) finishedSpecialProductsService:(id) data
{
    [activityIndicator stopAnimating];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    [assetsData updateSpecialproductsModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController-iPad" bundle:nil];
        self.specialOffersViewController = tempSpecialOffersViewController;
        [self.view addSubview:specialOffersViewController.view];
        tempSpecialOffersViewController = nil;
    }
    else {
        
        if(loginViewController.isLogin == YES) {
            
            SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
            self.specialOffersViewController = tempSpecialOffersViewController;
            specialOffersViewController.loginChk = YES;
            [self.view addSubview:specialOffersViewController.view];
            
            tempSpecialOffersViewController = nil;
            
        }
        
        else {
            
            
            SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
            
            self.specialOffersViewController = tempSpecialOffersViewController;
            
            [self.view addSubview:specialOffersViewController.view];
            
            tempSpecialOffersViewController =nil;
        }
        
    }
    
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end

