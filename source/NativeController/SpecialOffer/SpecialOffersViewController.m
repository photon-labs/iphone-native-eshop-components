//
//  SpecialOffersViewController.m
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpecialOffersViewController.h"
#import "ServiceHandler.h"
#import "DataModelEntities.h"
#import "SpecialOfferCustomCell.h"
#import "Constants.h"
#import "SharedObjects.h"
#import "AsyncImageView.h"
#import "ReviewViewController.h"
#import "HomeViewController.h"
#import "AddToBagViewController.h"
#import "BrowseViewController.h"
#import "ProductDetailsViewController.h"
#import "Tabbar.h"


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



@interface SpecialOffersViewController ()

@end

@implementation SpecialOffersViewController
@synthesize specialProductTable;
@synthesize reviewViewController;
@synthesize productNameArray;
@synthesize productImageArray;
@synthesize priceArray;
@synthesize review;
@synthesize addToBagViewController;
@synthesize browseViewController;
@synthesize productDetailsViewController;
@synthesize activityIndicator;
@synthesize loginChk;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"SpecialOffersViewController-iPad" bundle:nil];
		
	}
	else 
    {
        self = [super initWithNibName:@"SpecialOffersViewController" bundle:nil];
        
    }
    return self;
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
    
    [tabbar setSelectedIndex:3 fromSender:nil];
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
        
        bgView = nil;
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80 , SCREENWIDTH, 60)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg-72.png"]];
        
        [self.view addSubview:searchBarView];
        
        searchBarView = nil;
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_highlighted.png"], [UIImage imageNamed:@"mycart_btn_normal.png"], 
                                       nil];
        
        int x  = 8;
        
        int y = 83;
        
        int width = 250;
        
        int height = 55;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setBackgroundImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            x = x + 252;
            if(i==0) {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            if(i==2)
            {
                [button addTarget:self action:@selector(myCartButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            button = nil;
            
        }
    }
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        
        [self.view addSubview:bgView];
        
        bgView = nil;
        
        UIImageView *searchBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 , SCREENWIDTH, 40)];
        
        [searchBarView setImage:[UIImage imageNamed:@"searchblock_bg.png"]];
        
        [self.view addSubview:searchBarView];
        
        searchBarView = nil;
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"browse_btn_normal.png"], [UIImage imageNamed:@"offers_btn_highlighted.png"], [UIImage imageNamed:@"mycart_btn_normal.png"], 
                                       nil];
        
        int x  = 5;
        
        int y = 42;
        
        int width = 100;
        
        int height = 35;
        
        for(int i = 0; i<[buttonArray count]; i++)
        {
            UIButton *button = [[UIButton alloc] init];
            
            [button setFrame:CGRectMake(x, y, width, height)];
            
            [button setBackgroundImage:[buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            
            [self.view addSubview:button];
            
            x = x + 102;
            if(i==0) {
                [button addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            if(i==2)
            {
                [button addTarget:self action:@selector(myCartButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            button = nil;
        
        }
    }
	
	
}
-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.specialProductsArray =[[NSMutableArray alloc] init];
	[self.view removeFromSuperview];
}

-(void) initializeProductResults
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		specialProductTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 151, 768, 785)];
	}
    else {
        
        specialProductTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 81, 320, 330)];
    }
	
	specialProductTable.dataSource = self;
	specialProductTable.delegate = self;
	specialProductTable.backgroundColor = [UIColor colorWithRed:29.0/255.0 green:106.0/255.0 blue:150.0/255.0 alpha:1.0]; 
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
	[self.view addSubview:specialProductTable];
	
    
    if(nil == productNameArray)
    {
        productNameArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
        
        [productNameArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductName]];
        
    }
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductImageUrl]];
    }
    
    if(nil == priceArray)
    {
        priceArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.specialProductsArray count]; i++)
    {
        
        [priceArray addObject:[[assetsData.specialProductsArray objectAtIndex:i] specialProductPrice]];
        
    }
    
}

#pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	AssetsDataEntity *assestsDataOne = [SharedObjects sharedInstance].assetsDataEntity;
    
    return [assestsDataOne.specialProductsArray count];
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductRatingView]];
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
        UIImage* disImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_arrow.png" ofType:@""]];
        [[cell disImage] setFrame:CGRectMake(self.view.frame.size.width - disImage.size.width , iPhoneProductNameHeight, disImage.size.width, disImage.size.height)];//
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
        NSString* string = [NSString stringWithFormat:@"%@",[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductRatingView]];
        
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
    [[cell productName] setText:[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductName]];
    [[cell priceLabel] setText:@"Price :"];
    [[cell productPrice] setText: [NSString stringWithFormat:@"$ %@",[[assestsData.specialProductsArray objectAtIndex:indexPath.row] specialProductPrice]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    ServiceHandler* service = [[ServiceHandler alloc]init];
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    service.strId = [[assetsData.specialProductsArray objectAtIndex:indexPath.row] specialProductId];
    
    [service    productService:self:@selector(finishedProductDetialsService:)];
    
    service = nil;
}

-(void) finishedProductDetialsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductDetailsModel:data];
    
    ProductDetailsViewController	*tempProductDetailsViewController = [[ProductDetailsViewController alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
	
	self.productDetailsViewController = tempProductDetailsViewController;
	
	[self.view addSubview:productDetailsViewController.view];
	
	tempProductDetailsViewController = nil;
}


-(void)reviewButtonSelected :(id)sender
{
    ServiceHandler* service = [[ServiceHandler alloc]init];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    int rowOfButton = [sender tag];
    
    service.strId = [[assetsData.specialProductsArray objectAtIndex:rowOfButton] specialProductId];
    
    index = rowOfButton;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 250, 50, 40);
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    [service productReviewService:self :@selector(finishedProductReviewService:)];
    
    service = nil;
    
}


- (void) finishedProductReviewService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductReviewModel:data];
    
    if(loginChk ==  YES) {
        
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
        
        self.reviewViewController = tempReviewViewController;
        reviewViewController.isSpecialOffer = YES;
        reviewViewController.loginChk = YES;
        reviewViewController.reviewProductId = index;
        [self.view addSubview:reviewViewController.view];
        
        tempReviewViewController = nil;
        
    }
    else 
    {
        ReviewViewController	*tempReviewViewController = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
        
        self.reviewViewController = tempReviewViewController;
        reviewViewController.isSpecialOffer = YES;
        reviewViewController.reviewProductId = index;
        [self.view addSubview:reviewViewController.view];
        tempReviewViewController = nil;
        
    }
    
}

#pragma mark navigation button Actions
- (void) browseButtonSelected:(id)sender 
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.productArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    assetsData.catalogArray = [[NSMutableArray alloc]init];
    assetsData.productReviewArray = [[NSMutableArray alloc] init];
    
    
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    [serviceHandler catalogService:self :@selector(finishedCatalogService:)];
    
    serviceHandler = nil;
    
}

-(void) finishedCatalogService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateCatalogModel:data];
    
    BrowseViewController	*tempBrowseViewController = [[BrowseViewController alloc] initWithNibName:@"BrowseViewController" bundle:nil];
    
    self.browseViewController = tempBrowseViewController;
    
    [self.view addSubview:browseViewController.view];
    
    tempBrowseViewController = nil;
}


- (void) myCartButtonSelected:(id)sender
{
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
	tempResultViewController = nil;
}



-(void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:YES];
    [specialProductTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)backButtonAction{
    [self.view removeFromSuperview];
}


@end

