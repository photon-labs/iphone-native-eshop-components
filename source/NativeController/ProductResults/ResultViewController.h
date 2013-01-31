//
//  ResultsViewController.h
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tabbar;
@class ReviewViewController;
@class AddToBagViewController;
@class SpecialOffersViewController;
@class LoginViewController;
@class ProductDetailsViewController;

@interface ResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;
	
	UITableView		*resultTable;
	
	NSMutableArray	*priceArray;
    
    NSMutableArray* array_;
    
    BOOL loginChk;
    
    int index;
    
    UIActivityIndicatorView* activityIndicator;
    
	ProductDetailsViewController *productDetailsViewController;
    
	ReviewViewController* reviewViewController;
    
    AddToBagViewController* addToBagViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    LoginViewController* loginViewController;
    
    Tabbar *tabbar;
    
}

@property (nonatomic, strong) NSMutableArray *productImageArray;

@property (nonatomic, strong) NSMutableArray	*productNameArray;

@property (nonatomic, strong) UITableView		*resultTable;

@property (nonatomic, strong) NSMutableArray	*priceArray;



@property (nonatomic) BOOL loginChk;

@property (nonatomic, strong) NSMutableArray* array_;

@property (nonatomic, strong) AddToBagViewController* addToBagViewController;

@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, retain)LoginViewController* loginViewController;

@property (nonatomic, strong) ProductDetailsViewController *productDetailsViewController;

@property (nonatomic, strong) ReviewViewController *reviewViewController;


-(void) loadNavigationBar;

-(void) initializeProductResults;

-(void) finishedProductDetialsService:(id) data;

-(void)reviewButtonSelected :(id)sender;


@end
