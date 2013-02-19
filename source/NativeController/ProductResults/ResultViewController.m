//
//  ResultsViewController.m
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultViewCustomCell.h"
#import "ProductDetailsViewController.h"
#import "DataModelEntities.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "ReviewViewController.h"
#import "AddToBagViewController.h"
#import "SpecialOffersViewController.h"
#import "Tabbar.h"
#import "LoginViewController.h"
#import "NavigationView.h"
#import "ProductResultViewCell.h"
#import "Constants.h"



#define iPhoneCategoriesCellHeight 50
#define iPhoneResultCellHeight 120
#define iPadCategoriesCellHeight 110
#define iPadResultCellHeight 230

#define iPhoneCategoryNameWidth 140
#define iPhoneXpos  20
#define iPhoneYpos  5
#define iPhoneProductNameHeight 50
#define iPhoneProductNameWidth 200

#define iPadXpos 50
#define iPadYpos 5
#define iPadcategoryNameWidth 300
#define iPadProductNameHeight 70
#define iPadProductNameWidth 500
#define reviewButtonPadding 20

#define labelPadding  20

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize resultTable;
@synthesize priceArray;
@synthesize productDetailsViewController;
@synthesize reviewViewController;
@synthesize addToBagViewController;
@synthesize specialOffersViewController;
@synthesize activityIndicator;
@synthesize loginViewController;
@synthesize loginChk;
@synthesize array_;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSLog(@"iPad....");
		self = [super initWithNibName:@"ResultsViewController-iPAd" bundle:nil];
		
	}
	else 
    {
        NSLog(@"iPhone....");
        self = [super initWithNibName:@"ResultViewController" bundle:nil];
        
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
    array_ =[[NSMutableArray alloc] init];
    
    NSMutableArray *names = [NSMutableArray array];
    
    
    int startIndex = 0;
    
    int lastIndex = 4;
    
    for(int i = startIndex; i <= lastIndex; i++) {
        [names addObject:[assetsData.featureLayout objectAtIndex:i]];
    }
    
    //create tabbar with given features
    [tabbar initWithInfo:names];
    
    [self.view addSubview:(UIView*)tabbar];
    
    [tabbar setSelectedIndex:1 fromSender:nil];
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
	
	[self initializeProductResults];
}

-(void) loadOtherViews
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 860)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        
        [self.view addSubview:bgView];
        
        bgView =nil;
        
        
         }
    
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
       }
}


-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productArray = [[NSMutableArray alloc]init];
	[self.view removeFromSuperview];
}

-(void) initializeProductResults
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 768, 855)];
	}
    else {
        
        resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, 320, 370)];
    }
	
	resultTable.dataSource = self;
	resultTable.delegate = self;
	resultTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
	[self.view addSubview:resultTable];
	
    
    if(nil == productNameArray)
    {
        productNameArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        
        [productNameArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailName]];
        
    }
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailImageUrl]];
    }
    
    if(nil == priceArray)
    {
        priceArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.productArray count]; i++)
    {
        [priceArray addObject:[[assetsData.productArray objectAtIndex:i] productDetailsPrice]];
        
    }
    
}




#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AssetsDataEntity *assestsDataOne = [SharedObjects sharedInstance].assetsDataEntity;
    
    if([assestsDataOne.productArray count]==0)
    {
        
        UIAlertView *alertProduct = [[UIAlertView alloc] initWithTitle:@"Search Product" message:@"Products not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertProduct show];
        alertProduct =nil;
    }
    else {
        
        return [assestsDataOne.productArray count];
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 180;
    }
    else {
        
        return 120;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductsCell";
    ProductResultViewCell *cell = (ProductResultViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ((cell == nil) ||(cell != nil)) {
        cell = [[ProductResultViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.numberOfLines = 2;
        
        [[cell reviewsButton] addTarget:self
                                 action:@selector(reviewButtonSelected:)
                       forControlEvents:UIControlEventTouchUpInside];
        cell.reviewsButton.accessibilityLabel=@"Review";
        cell.reviewsButton.isAccessibilityElement=YES;
        
    }
    [[cell reviewsButton] setTag:[indexPath row]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImage* imageName = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sony_razor_tv" ofType:@"png"]];
        [[cell productName] setFrame:CGRectMake((imageName.size.width +iPadXpos), 0,iPadProductNameWidth, iPadProductNameHeight)];
        [[cell priceLabel] setFrame:CGRectMake(imageName.size.width + iPadXpos,iPadProductNameHeight ,iPadProductNameHeight, iPadProductNameHeight)];
        
        UIImage* reviewImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"review_btn" ofType:@"png"]];
        [[cell reviewsButton] setFrame:CGRectMake( (iPadXpos + iPadProductNameWidth + labelPadding),iPadProductNameHeight+ labelPadding ,reviewImage.size.width + 10, reviewImage.size.height+ labelPadding)];
        [[cell productPrice] setFrame:CGRectMake(iPadXpos + imageName.size.width + cell.priceLabel.frame.size.width, iPadProductNameHeight, iPadProductNameHeight, iPadProductNameHeight)];
        
        UIImage* disImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_arrow-72" ofType:@"png"]];
        [[cell disImage] setFrame:CGRectMake(self.view.frame.size.width - disImage.size.width , iPadProductNameHeight, disImage.size.width, disImage.size.height)];
        [[cell disImage] setImage:disImage];
        CGRect frame;
        
        frame.size.width=imageName.size.width;
        frame.size.height=imageName.size.width;
        frame.origin.x=10;
        frame.origin.y=iPadYpos;
        
        AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                       initWithFrame:frame] ;
        // TODO: Add Code for getting Coupons Image URL
        NSURL	*url = nil;
        
        if([productImageArray count] > 0 && indexPath.row < [productImageArray count])
        {
            url = [NSURL URLWithString:[productImageArray objectAtIndex:indexPath.row]];
            [tasyncImage loadImageFromURL:url];
            [cell.contentView addSubview:tasyncImage];
            tasyncImage =nil;
        }
        AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
        NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productRatingView]];
        index = indexPath.row;
        
        UIImage* whiteStarImage  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"white_star" ofType:@"png"]];
        float x = imageName.size.width + iPadXpos;
        float  y =  imageName.size.height + cell.priceLabel.frame.size.height;
        float  width = whiteStarImage.size.width;
        float height = whiteStarImage.size.height;
        
        NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(x,y,width,height);
            [ratingsView setImage:whiteStarImage];
            x = x + 25;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesWhiteArray addObject:ratingsView];
        }
        
        float xBlue = imageName.size.width +iPadXpos;
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<[string intValue];i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(xBlue,y,width,height);
            [ratingsView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blue_star" ofType:@"png"]]];
            xBlue = xBlue + 25;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesArray addObject:ratingsView];
        }
        
    }
    else {
        
        UIImage* imageName = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sony_razor_tv" ofType:@"png"]];
        [[cell productName] setFrame:CGRectMake(imageName.size.width +iPhoneXpos,0,iPhoneProductNameWidth, imageName.size.height)];
        [[cell priceLabel] setFrame:CGRectMake(imageName.size.width + iPhoneXpos,iPhoneProductNameHeight ,iPhoneProductNameHeight, iPhoneProductNameHeight)];
        UIImage* reviewImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"review_btn" ofType:@"png"]];
        [[cell reviewsButton] setFrame:CGRectMake(iPhoneProductNameWidth + labelPadding,iPhoneProductNameHeight+ 2*iPhoneYpos+30,reviewImage.size.width, reviewImage.size.height)];
        [[cell productPrice] setFrame:CGRectMake(imageName.size.width + iPhoneXpos + 2*labelPadding, iPhoneProductNameHeight, iPhoneProductNameHeight, iPhoneProductNameHeight)];
        UIImage* disImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_arrow" ofType:@"png"]];
        [[cell disImage] setFrame:CGRectMake(self.view.frame.size.width - disImage.size.width , iPhoneProductNameHeight, disImage.size.width, disImage.size.height)];
        [[cell disImage] setImage:disImage];
        
        
        CGRect frame;
        frame.size.width=imageName.size.width;
        frame.size.height=imageName.size.height;
        frame.origin.x=10;
        frame.origin.y= iPhoneYpos;
        
        AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                       initWithFrame:frame] ;
        // TODO: Add Code for getting Coupons Image URL
        NSURL	*url = nil;
        
        if([productImageArray count] > 0 && indexPath.row < [productImageArray count])
        {
            url = [NSURL URLWithString:[productImageArray objectAtIndex:indexPath.row]];
            [tasyncImage loadImageFromURL:url];
            [cell.contentView addSubview:tasyncImage];
            tasyncImage =nil;
        }
        UIImage* starImage  = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"white_star" ofType:@"png"]];
        float x = imageName.size.width + iPhoneXpos;
        float y =  imageName.size.height + iPhoneXpos;
        float  width = starImage.size.width ;
        float  height = starImage.size.height ;
        
        AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
        NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.productArray objectAtIndex:indexPath.row] productRatingView]];
        
        NSMutableArray *imageFramesWhiteArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<5;i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(x,y,width,height);
            [ratingsView setImage:starImage];
            x = x + 15;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesWhiteArray addObject:ratingsView];
        }
        
        float xBlue =imageName.size.width + iPhoneXpos;
        NSMutableArray *imageFramesArray = [[NSMutableArray alloc]init];
        for(int i = 0; i<[string intValue];i++)
        {
            UIImageView *ratingsView = [[UIImageView alloc]init];
            ratingsView.frame = CGRectMake(xBlue,y,width,height);
            [ratingsView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blue_star" ofType:@"png"]]];
            xBlue = xBlue + 15;
            [ratingsView setTag:i];
            [cell.contentView  addSubview:ratingsView];
            [imageFramesArray addObject:ratingsView];
        }
    }
    AssetsDataEntity *assestsData = [SharedObjects sharedInstance].assetsDataEntity;
    [[cell productName] setText:[[assestsData.productArray objectAtIndex:indexPath.row] productDetailName]];
    [[cell priceLabel] setText:@"Price :"];
    [[cell productPrice] setText: [NSString stringWithFormat:@"$ %@",[[assestsData.productArray objectAtIndex:indexPath.row] productDetailsPrice]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    service.strId = [[assetsData.productArray objectAtIndex:indexPath.row] productDetailId];
    
    index = [indexPath row];
    
    [service    productService:self:@selector(finishedProductDetialsService:)];
    
    service =nil;
}

-(void) finishedProductDetialsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductDetailsModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController-iPAd" bundle:nil];
        
        self.productDetailsViewController = tempProductDetailsViewController;
        
        [self.view addSubview:productDetailsViewController.view];
        
        tempProductDetailsViewController  = nil;
    }
    else {
        
        if(loginChk == YES) {
            
            ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
            
            self.productDetailsViewController = tempProductDetailsViewController;
	        productDetailsViewController.loginChk = YES;
            productDetailsViewController.index = index ;
            [self.view addSubview:productDetailsViewController.view];
            
            tempProductDetailsViewController = nil;
        }
        else {
            
            ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
            
            self.productDetailsViewController = tempProductDetailsViewController;
            [self.view addSubview:productDetailsViewController.view];
            
            tempProductDetailsViewController = nil;
        }
    }
}
-(void) finishedProductReviewService:(id) data
{
    
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController-iPAd" bundle:nil];
        
        self.reviewViewController = tempReviewViewController;
        
        [self.view addSubview:reviewViewController.view];
        
        tempReviewViewController = nil;
    }
    else {
        
        if(loginChk == YES) {
            
            ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
            
            self.reviewViewController = tempReviewViewController;
            reviewViewController.loginChk = YES;
            reviewViewController.reviewProductId = index;
            reviewViewController.array_ = array_;
            [self.view addSubview:reviewViewController.view];
            
            tempReviewViewController = nil;
            
        }
        
        else {
            
            ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
            self.reviewViewController = tempReviewViewController;
            [self.view addSubview:reviewViewController.view];
            tempReviewViewController = nil;
            
        }
    }
}

-(void)reviewButtonSelected :(id)sender
{
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 250, 50, 40);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    ServiceHandler* service = [[ServiceHandler alloc]init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    int rowOfButton = [sender tag];
    
    index= rowOfButton;
    
    service.strId = [[assetsData.productArray objectAtIndex:rowOfButton] productDetailId];
    [service productReviewService:self :@selector(finishedProductReviewService:)];
    
}

-(void)viewWillAppear:(BOOL)animated 
{
    
    [super viewWillAppear:YES];
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
