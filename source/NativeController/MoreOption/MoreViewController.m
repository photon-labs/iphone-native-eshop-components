//
//  MoreViewController.m
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreViewController.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "Tabbar.h"
#import <QuartzCore/QuartzCore.h>
#import "NavigationView.h"
#import "Constants.h"
@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize moreView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"MoreViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"MoreViewController" bundle:nil];
        
    }
    
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
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
    
    [tabbar setSelectedIndex:4 fromSender:nil];
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
        
    }
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
    }
    
}

-(void)initializeTextView
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        moreView =[[UIView  alloc]initWithFrame:CGRectMake(40, 200,670,450)];
        UIImage* image  = [UIImage imageNamed:@"iconbg2_screen-72.png"];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setImage:image];
        [moreView addSubview:imageView];
        [self.view addSubview:moreView];     
        
        UIButton* wishlist = [UIButton buttonWithType:UIButtonTypeCustom];
        [wishlist setFrame:CGRectMake(80, 80, 120, 160)];
        [wishlist setImage:[UIImage imageNamed:@"wishlist_icon-72.png"] forState:UIControlStateNormal];
        [wishlist addTarget:self action:@selector(wishListButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:wishlist];
        
        UIButton* coupons = [UIButton buttonWithType:UIButtonTypeCustom];
        [coupons setFrame:CGRectMake(400, 80, 120, 160)];
        [coupons setImage:[UIImage imageNamed:@"coupons_icon-72.png"] forState:UIControlStateNormal];
        [coupons addTarget:self action:@selector(couponsButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:coupons];
    }
    else 
    {
        moreView =[[UIView  alloc]initWithFrame:CGRectMake(5, 120,310,150)];
        UIImage* image  = [UIImage imageNamed:@"iconbg2_screen.png"];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setImage:image];
        [moreView addSubview:imageView];
        [self.view addSubview:moreView];
        
        UIButton* wishlist = [UIButton buttonWithType:UIButtonTypeCustom];
        [wishlist setFrame:CGRectMake(40, 40, 60, 80)];
        [wishlist setImage:[UIImage imageNamed:@"wishlist_icon.png"] forState:UIControlStateNormal];
        [wishlist addTarget:self action:@selector(wishListButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:wishlist];
        
        UIButton* coupons = [UIButton buttonWithType:UIButtonTypeCustom];
        [coupons setFrame:CGRectMake(210, 40, 60, 80)];
        [coupons setImage:[UIImage imageNamed:@"coupons_icon.png"] forState:UIControlStateNormal];
        [coupons addTarget:self action:@selector(couponsButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [moreView addSubview:coupons];
    }
    
}

-(void)couponsButtonSelected:(id)sender
{
    NSLog(@"sdjfksdf");
}


-(void)wishListButtonSelected:(id)sender
{
    NSLog(@"qweqwe");
    
}
-(void)goBack:(id)sender
{
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)backButtonAction{
    [self.view removeFromSuperview];
}

@end
