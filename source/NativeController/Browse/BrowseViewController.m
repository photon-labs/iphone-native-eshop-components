//
//  BrowseViewController.m
//  Phresco
//
//  Created by Rojaramani on 08/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrowseViewController.h"
#import "BrowseViewCustomCell.h"
#import "ResultViewController.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "AsyncImageView.h"
#import "ServiceHandler.h"
#import "AddToBagViewController.h"
#import "ProductDetailsViewController.h"
#import "AddToBagCustomCell.h"
#import "HomeViewController.h"
#import "specialOffersViewController.h"
#import "Tabbar.h"
#import "LoginViewController.h"
#import "Constants.h"
#import "NavigationView.h"
#import "ProductResultViewCell.h"
#import "SearchBarView.h"
#import "ThemeReader.h"


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
#define iPadProductNameHeight 100
#define iPadProductNameWidth 400
#define iPhoneProductCountWidth 40
#define iPhoneProductCountHeight 30
#define iPadProductCountWidth 50
#define iPadProductCountHeight 40

@interface BrowseViewController ()

@end

@implementation BrowseViewController


@synthesize productTable;
@synthesize productImageArray;
@synthesize productNameArray;
@synthesize resultViewController;
@synthesize addToBagViewController;
@synthesize specialOffersViewController;
@synthesize productCountArray;
@synthesize loginViewController;
@synthesize activityIndicator;
@synthesize loginChk;
@synthesize array_;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self = [super initWithNibName:@"BrowseViewController-iPad" bundle:nil];
		
	}
	else
    {
        self = [super initWithNibName:@"BrowseViewController" bundle:nil];
        
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
    
    
    SearchBarView *searchBar = nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        searchBar =[[SearchBarView alloc]initWithFrame:CGRectMake(0,40,SCREENWIDTH,100)];
    }
    else{
        searchBar =[[SearchBarView alloc]initWithFrame:CGRectMake(0,20,SCREENWIDTH,40)];
    }
    searchBar.searchBarDelegate=self;
    [searchBar loadSearchBar];
    [self.view addSubview:searchBar];
    
	[self initializeTableView];
}

-(void) loadOtherViews
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, SCREENWIDTH, 860)];
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg-72.png"]];
        [self.view addSubview:bgView];
        
        UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, 768, 60)];
        [descriptionBlock setImage:[UIImage imageNamed:@"categorylist_top_row.png"]];
        [self.view addSubview:descriptionBlock];
        
        UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(240, 200, 320, 60)];
        [descriptionHeader setImage:[UIImage imageNamed:@"categorylist_header-72.png"]];
        [self.view addSubview:descriptionHeader];
    }
    else {
        
        UIImageView    *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, 375)];
        [bgView setImage:[UIImage imageNamed:@"home_screen_bg.png"]];
        [self.view addSubview:bgView];
        
        UIImageView *descriptionBlock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, 40)];
        [descriptionBlock setImage:[UIImage imageNamed:@"categorylist_top_row.png"]];
        [self.view addSubview:descriptionBlock];
        UIImageView	*descriptionHeader = [[UIImageView alloc] initWithFrame:CGRectMake(90, 80, 150, 30)];
        [descriptionHeader setImage:[UIImage imageNamed:@"categorylist_header.png"]];
        [self.view addSubview:descriptionHeader];
    }
}


#pragma mark searchButtonSelected
- (void)searchButtonSelected:(NSString*)searchTextEdit
{
    [txtBar resignFirstResponder];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.frame = CGRectMake(130, 150, 50, 40);
    
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    if([searchTextEdit length] > 0)
    {
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        service.productName = searchTextEdit;
        [service    searchProductsService:self:@selector(finishedProductDetialsService:)];
        
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Search Product" message:@"Enter a product name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
    }
}

-(void) initializeTableView
{    float redFloatValue=0.0;
    float greenFloatValue=0.0;
    float blueFloatValue=0.0;
    float alphaFloatValue=0.0;
    NSString * red =[self getBackGroundColor:@"red"];
    NSString * green =[self getBackGroundColor:@"green"];
    NSString * blue =[self getBackGroundColor:@"blue"];
    NSString * alpha =[self getBackGroundColor:@"alpha"];
    
    redFloatValue=[red floatValue];
    greenFloatValue =[green floatValue];
    blueFloatValue =[blue floatValue];
    alphaFloatValue = [alpha floatValue];
    
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
		productTable = [[UITableView alloc] initWithFrame:CGRectMake(0,260, 768,550) style:UITableViewStylePlain];
        productTable.dataSource = self;
        productTable.delegate = self;
        productTable.backgroundColor = [UIColor colorWithRed:redFloatValue/255.0 green:greenFloatValue/255.0 blue:blueFloatValue/255.0 alpha:alphaFloatValue];
        [self.view addSubview:productTable];
	}
    else {
        
        productTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, 320, 280) style:UITableViewStylePlain];
        productTable.dataSource = self;
        productTable.delegate = self;
        productTable.backgroundColor = [UIColor colorWithRed:redFloatValue/255.0 green:greenFloatValue/255.0 blue:blueFloatValue/255.0 alpha:alphaFloatValue];
        
        [self.view addSubview:productTable];
    }
	
	
	
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    if(nil == productImageArray)
    {
        productImageArray = [[NSMutableArray alloc] init];
    }
    
    if(nil == productCountArray)
    {
        
        productCountArray = [[NSMutableArray alloc] init];
    }
    
    for(int i = 0;i<[assetsData.catalogArray count]; i++)
    {
        [productImageArray addObject:[[assetsData.catalogArray objectAtIndex:i] productImageUrl]];
        
    }
    
    if(nil == productNameArray)
	{
		productNameArray = [[NSMutableArray alloc] initWithObjects:@"Apparels", @"Computer & Electronics", @"Mobiles", @"TV & Video", nil];
	}
}


#pragma mark navigation button Actions


-(void)specialOfferButtonSelected :(id)sender
{
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.specialProductsArray = [[NSMutableArray alloc]init];
    assetsData.productDetailArray = [[NSMutableArray alloc]init];
    
    ServiceHandler *serviceHandler = [[ServiceHandler alloc] init];
    
    [serviceHandler specialProductsService:self :@selector(finishedSpecialProductsService:)];
    
    //    [serviceHandler release];
    
}


-(void) finishedSpecialProductsService:(id) data
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateSpecialproductsModel:data];
    
    [activityIndicator stopAnimating];
    
    SpecialOffersViewController *tempSpecialOffersViewController = [[SpecialOffersViewController alloc] initWithNibName:@"SpecialOffersViewController" bundle:nil];
    
    self.specialOffersViewController = tempSpecialOffersViewController;
    
    [self.view addSubview:specialOffersViewController.view];
    
}

- (void) myCartButtonSelected:(id)sender
{
    
    
    AddToBagViewController *tempResultViewController = [[AddToBagViewController alloc] initWithNibName:@"AddToBagViewController" bundle:nil];
	
	self.addToBagViewController = tempResultViewController;
    
	[self.view addSubview:addToBagViewController.view];
    
}

#pragma mark tableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    return [assetsData.catalogArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 82;
    }
    else {
        
        return 48;
    }
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"id";
    ProductResultViewCell *cell = (ProductResultViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
    if ((cell == nil) ||(cell != nil)) {
        cell = [[ProductResultViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIImage* imageName = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"computer_icon-72" ofType:@"png"]];
        [[cell productName] setFrame:CGRectMake(imageName.size.width +iPhoneXpos, iPadYpos +iPhoneYpos,iPadcategoryNameWidth, imageName.size.height)];
        
        float nameWidth = iPadXpos + imageName.size.width  + iPadcategoryNameWidth;
        
        [[cell productCountLabel] setFrame:CGRectMake(2*iPadXpos + nameWidth,iPadYpos,iPadProductCountWidth,iPadProductCountHeight)];
        
        float countImageWidth = self.view.frame.size.width - iPadXpos ;
        UIImage* disImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_arrow-72" ofType:@"png"]];
        [[cell disImage] setFrame:CGRectMake(countImageWidth , 2*iPadYpos, disImage.size.width, disImage.size.height)];
        [[cell disImage] setImage:disImage];
        
        CGRect frame;
        frame.size.width=imageName.size.width;
        frame.size.height=imageName.size.height;
        frame.origin.x=10;
        frame.origin.y=7;
        
        AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                       initWithFrame:frame] ;
        // TODO: Add Code for getting Coupons Image URL
        NSURL	*url = nil;
        if([productImageArray count] > 0 && indexPath.row < [productImageArray count])
        {
            url = [NSURL URLWithString:[productImageArray objectAtIndex:indexPath.row]];
            [tasyncImage loadImageFromURL:url];
            [cell.contentView addSubview:tasyncImage];
        }
        tasyncImage = nil;
        
        
    }
    else {
        
        UIImage* imageName = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"computer_icon" ofType:@"png"]];
        [[cell productName] setFrame:CGRectMake(imageName.size.width +iPhoneXpos+10, iPhoneYpos + iPhoneYpos,iPhoneCategoryNameWidth, imageName.size.height)];
        
        float nameWidth = iPhoneXpos + imageName.size.width  + iPhoneCategoryNameWidth;
        
        [[cell productCountLabel] setFrame:CGRectMake(nameWidth + 2*iPhoneXpos  ,iPhoneYpos,iPhoneProductCountWidth,iPhoneProductCountHeight)];
        UIImage* disImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_arrow" ofType:@"png"]];
        float countImageWidth =  iPhoneXpos + nameWidth + 2*imageName.size.width ;
        [[cell disImage] setFrame:CGRectMake(countImageWidth, 2*iPhoneYpos, disImage.size.width, disImage.size.height)];
        [[cell disImage] setImage:disImage];
        CGRect frame;
        frame.size.width=imageName.size.width;
        frame.size.height=imageName.size.height;
        frame.origin.x=10;
        frame.origin.y=7;
        
        AsyncImageView *tasyncImage = [[AsyncImageView alloc]
                                       initWithFrame:frame] ;
        // TODO: Add Code for getting Coupons Image URL
        NSURL	*url = nil;
        if([productImageArray count] > 0 && indexPath.row < [productImageArray count])
        {
            url = [NSURL URLWithString:[productImageArray objectAtIndex:indexPath.row]];
            [tasyncImage loadImageFromURL:url];
            [cell.contentView addSubview:tasyncImage];
        }
        tasyncImage = nil;
    }
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    [[cell productName] setText:[[assetsData.catalogArray objectAtIndex:indexPath.row] productName]];
    [[cell productCountLabel] setText:[NSString stringWithFormat:@"%@",[[assetsData.catalogArray objectAtIndex:indexPath.row] productCount]]];
    [[cell countImage] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"itemscount_bg-72"ofType:@"png"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        service.strId = [[assetsData.catalogArray objectAtIndex:indexPath.row] productId];
        [service    productDetailsService:self:@selector(finishedProductDetialsService:)];
        service = nil;
    }
    else {
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(130, 250, 50, 40);
        [self.view addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        
        ServiceHandler* service = [[ServiceHandler alloc]init];
        AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
        
        service.strId = [[assetsData.catalogArray objectAtIndex:indexPath.row] productId];
        [service    productDetailsService:self:@selector(finishedProductDetialsService:)];
        service = nil;
    }
}


-(void) finishedProductDetialsService:(id) data
{
    [activityIndicator stopAnimating];
    
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    
    [assetsData updateProductModel:data];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultsViewController-iPAd" bundle:nil];
        
        self.resultViewController = tempResultViewController;
        
        [self.view addSubview:resultViewController.view];
        
        tempResultViewController = nil;
    }
    else {
        
        
        if(loginChk == YES) {
            
            ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            
            self.resultViewController = tempResultViewController;
            
            tempResultViewController.loginChk = YES;
            
            resultViewController.array_ = array_;
            
            [self.view addSubview:resultViewController.view];
            
            tempResultViewController = nil;
        }
        
        else {
            
            ResultViewController *tempResultViewController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            
            self.resultViewController = tempResultViewController;
            
            [self.view addSubview:resultViewController.view];
            
            tempResultViewController =nil;
        }
    }
}


-(void) goBack:(id) sender
{
    AssetsDataEntity *assetsData = [SharedObjects sharedInstance].assetsDataEntity;
    assetsData.catalogArray = [[NSMutableArray alloc]init];
	[self.view removeFromSuperview];
}


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

-(void)backButtonAction{
    [self.view removeFromSuperview];
}
-(NSString*)getBackGroundColor:(NSString*)navigationKey{
    if(navigationKey != nil &&[navigationKey length]>0){
        ThemeReader *themeReader =[[ThemeReader alloc]init];
        NSMutableDictionary *navigationDict = nil;
        navigationDict = [themeReader loadDataFromManifestPlist:@"ProductResults"];
        if(nil != navigationDict && [navigationDict count] >0)  //Get data from manifest plist
        {
            NSString* object=[navigationDict objectForKey:navigationKey];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else
            {
                navigationDict = [themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:@"ProductResults"];
                if(nil != navigationDict && [navigationDict count] > 0)
                {
                    NSString *object = [navigationDict objectForKey:navigationKey];
                    if(nil != object && [object length] > 0)
                    {
                        return object;
                    }
                    else
                    {
                        
                    }
                }
                
            }
        }
        else
        {
            NSMutableDictionary *navigationViewDict=[themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:@"ProductResults"];
            if(nil != navigationViewDict && [navigationViewDict count] > 0)
            {
                NSString *object = [navigationViewDict objectForKey:navigationKey];
                if(nil != object && [object length] > 0)
                {
                    return object;
                }
                else
                {
                }
            }
        }
    }
    return nil;
}
@end
