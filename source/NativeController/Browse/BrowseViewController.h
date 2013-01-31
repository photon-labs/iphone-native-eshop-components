//
//  BrowseViewController.h
//  Phresco
//
//  Created by Rojaramani on 08/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tabbar;
@class ResultViewController;
@class AddToBagViewController;
@class ProductDetailsViewController;
@class SpecialOffersViewController;
@class LoginViewController;
@interface BrowseViewController : UIViewController
                    <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
	IBOutlet UISearchBar *searchBar;
	
	IBOutlet UITableView	*productTable;
	
	IBOutlet NSMutableArray *productImageArray;
	
	IBOutlet NSMutableArray	*productNameArray;
    
    IBOutlet NSMutableArray  *productCountArray; 
	
    IBOutlet UITextField	*txtBar;
    
    IBOutlet UIButton *btnSearchIcon;
    
    BOOL loginChk;
    
    NSMutableArray* array_;
    
    UIActivityIndicatorView* activityIndicator;
    
    Tabbar *tabbar;
    
    LoginViewController* loginViewController;
    
    ResultViewController *resultViewController;

   AddToBagViewController* addToBagViewController;
   
   ProductDetailsViewController* product;
   
   SpecialOffersViewController *specialOffersViewController;
    
    
}

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) IBOutlet UITableView	*productTable;

@property (nonatomic, strong) IBOutlet NSMutableArray *productImageArray;

@property (nonatomic, strong) IBOutlet NSMutableArray	*productNameArray;

@property (nonatomic, strong) IBOutlet NSMutableArray  *productCountArray;

@property (nonatomic) BOOL loginChk;

@property (nonatomic, strong) NSMutableArray* array_;

@property (nonatomic, strong) ResultViewController *resultViewController;

@property (nonatomic, retain) AddToBagViewController* addToBagViewController;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, retain) LoginViewController* loginViewController;


-(void) loadNavigationBar;

-(void) addSearchBar;

-(void) initializeTableView;

- (void)searchButtonSelected:(id)sender;


@end

