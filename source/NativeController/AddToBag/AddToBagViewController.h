//
//  AddToBagViewController.h
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewCartViewController;
@class CheckOutViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;
@class ServiceHandler;

@interface AddToBagViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
    UIScrollView *scrollView;
    
    UITableView		*addToBagTable;
    
    NSMutableArray *productImageArray;
	
	NSMutableArray	*productNameArray;
    
    NSIndexPath *pathDelete;
    
    NSString *cartCount;
    
    UITextField *txtQty;
    
    UILabel *lblSubtotal;
    
    NSInteger theInteger;
    
    UILabel *myCartView;
    
    UIButton *viewMyCart;
    
    NSMutableArray *inputTexts;
    
    UIButton *updateCart;
    
    int insVal;
    int purchase;
    int delIndex;
    
    
    Tabbar *tabbar;
    BrowseViewController* browseViewController;
    SpecialOffersViewController* specialOffersViewController;
    CheckOutViewController* checkCartController;
    ViewCartViewController  *viewCartController;
    ServiceHandler *serviceHandler;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView		*addToBagTable;

@property (nonatomic, strong) NSMutableArray *productImageArray;
@property (nonatomic, strong) ServiceHandler *serviceHandler;

@property (nonatomic, strong) NSMutableArray	*productNameArray;

@property (nonatomic, strong) NSString *cartCount;

@property (nonatomic, strong)  BrowseViewController* browseViewController;
@property (nonatomic, strong) SpecialOffersViewController* specialOffersViewController;
@property (nonatomic, strong) ViewCartViewController  *viewCartController;
@property (nonatomic, strong) CheckOutViewController* checkCartController;

-(void)goBack:(id)sender;

-(void) loadNavigationBar;

-(void) initializeTableView;

-(void)removeIndex:(id)sender;

-(void)updateAction:(id)sender;

-(void)viewAction:(id)sender;

@end
