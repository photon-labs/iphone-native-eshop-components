//
//  OrderStatusViewController.m
//  Phresco
//
//  Created by Rojaramani on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderStatusViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BrowseViewController.h"
#import "DataModelEntities.h"
#import "ServiceHandler.h"
#import "SharedObjects.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"
#import "NavigationView.h"
#import "Constants.h"
@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController
@synthesize browseViewController;
@synthesize orderStatusTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"OrderStatusViewController-iPad" bundle:nil];
		
	}
	else
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"OrderStatusViewController" bundle:nil];
        
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
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
    
    [tabbar setSelectedIndex:2 fromSender:nil];
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
    
    [self initializeTextView];
    
}
-(void) loadOtherViews
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 860)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
      
        
               
        UIImageView    *titleHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 151, 768, 60)];
        
        [titleHeader setImage:[UIImage imageNamed:@"product_header.png"]];
        
        [self.view addSubview:titleHeader];
        
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(190,151,570,60)];
        [titleLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"Order Status Screen"];
        [self.view addSubview:titleLabel];
        titleHeader = nil;
        
        UILabel* orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25,230,720,60)];
        [orderLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:28]];
        orderLabel.backgroundColor = [UIColor clearColor];
        [orderLabel setTextColor:[UIColor whiteColor]];
        [orderLabel setText:@"Order Status Message"];
        [self.view addSubview:orderLabel];
        orderLabel = nil;
    }
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
              
               
        UIImageView    *titleHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 320, 30)];
        
        [titleHeader setImage:[UIImage imageNamed:@"product_header.png"]];
        
        [self.view addSubview:titleHeader];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95,80,320,25)];
        [titleLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:14]];
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"Order Status Screen"];
        [self.view addSubview:titleLabel];
        titleHeader = nil;
        
        UILabel* orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,120,320,25)];
        [orderLabel setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:14]];
        orderLabel.backgroundColor = [UIColor clearColor];
        [orderLabel setTextColor:[UIColor whiteColor]];
        [orderLabel setText:@"Order Status Message"];
        [self.view addSubview:orderLabel];
        orderLabel = nil;
    }
	
    
}

-(void)goBack:(id)sender
{
    [self.view removeFromSuperview];
}
- (void)initializeTextView
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        orderStatusTextView =[[UITextView alloc]initWithFrame:CGRectMake(10, 300,740,400)];
        orderStatusTextView.delegate = self;
        orderStatusTextView.editable = NO;
        orderStatusTextView.backgroundColor =[UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0];
        [orderStatusTextView setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:26]];
        [orderStatusTextView.layer setBorderColor:[[UIColor grayColor]CGColor]];
        [orderStatusTextView.layer setBorderWidth:1.0];
        [orderStatusTextView.layer setCornerRadius:8.0f];
        [orderStatusTextView.layer setMasksToBounds:YES];
        orderStatusTextView.textColor = [UIColor whiteColor];
        orderStatusTextView.text = @"Your order is complete!\nyour order number is 007.\nThanks you for shopping at Phresco.While logged in.\nYou may continue shopping or view your order status and order.";
        [self.view addSubview:orderStatusTextView];
    }
    else {
        orderStatusTextView =[[UITextView alloc]initWithFrame:CGRectMake(5, 150,310,150)];
        orderStatusTextView.delegate = self;
        orderStatusTextView.editable = NO;
        orderStatusTextView.backgroundColor =[UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0];
        [orderStatusTextView setFont:[UIFont fontWithName:@"Times New Roman-Regular" size:13]];
        [orderStatusTextView.layer setBorderColor:[[UIColor grayColor]CGColor]];
        [orderStatusTextView.layer setBorderWidth:1.0];
        [orderStatusTextView.layer setCornerRadius:8.0f];
        [orderStatusTextView.layer setMasksToBounds:YES];
        orderStatusTextView.textColor = [UIColor whiteColor];
        orderStatusTextView.text = @"Your order is complete!\nyour order number is 007.\nThanks you for shopping at Phresco.While logged in.\nYou may continue shopping or view your order status and order.";
        [self.view addSubview:orderStatusTextView];
    }
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(void)backButtonAction{
    [self.view removeFromSuperview];
}

@end
