//
//  SpecialOffersViewController.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReviewViewController;
@class AddToBagViewController;
@class BrowseViewController;
@class ProductDetailsViewController;
@class Tabbar;
@interface SpecialOffersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* specialProductTable;
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;
    
    NSMutableArray	*priceArray;
    
    
    UIButton* review;
    
    UIActivityIndicatorView* activityIndicator;
    
    BOOL loginChk;
    
    int index;
    
    Tabbar *tabbar;
    
    ReviewViewController *reviewViewController;
    
    AddToBagViewController *addToBagViewController;
    
    BrowseViewController *browseViewController;
    
    ProductDetailsViewController *productDetailsViewController;
}

@property (nonatomic, strong)UITableView* specialProductTable; 

@property (nonatomic, strong) NSMutableArray *productImageArray;

@property (nonatomic, strong) NSMutableArray	*productNameArray;

@property (nonatomic, strong) NSMutableArray	*priceArray;


@property (nonatomic, strong) UIButton* review;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic) BOOL loginChk;

@property (nonatomic, strong)ReviewViewController *reviewViewController;

@property (nonatomic, strong)AddToBagViewController *addToBagViewController;

@property (nonatomic, strong)BrowseViewController *browseViewController;

@property (nonatomic, strong) ProductDetailsViewController *productDetailsViewController;



-(void) loadNavigationBar;

-(void) initializeProductResults;

-(void)reviewButtonSelected :(id)sender;

-(void)goBack:(id)sender;


@end
