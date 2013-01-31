//
//  CheckoutOverAllViewController.h
//  Phresco
//
//  Created by Rojaramani on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIO.h"

@class OrderStatusViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;
@interface CheckoutOverAllViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, CardIOPaymentViewControllerDelegate>
{
    UIButton *btnSaved;
    NSString *strFirst;
    NSString *strLast;
    NSString *strComp;
    NSString *strAddr1;
    NSString *strAddr2;
    NSString *strCity;
    NSString *strState;
    NSString *strCountry;
    NSString *strZip;
    NSString *strPhone;
    NSString *strEmailId;
    NSString *strOrderComments;
    
    UITableView		*addToBagTable;
    NSMutableArray *productImageArray;
	NSMutableArray	*productNameArray;
    NSMutableIndexSet *expandedSections;
    NSMutableData *receivedData;
	NSData *data;
	NSString *responseString;
    NSString *stringTotalPrice;
    UIActivityIndicatorView* activityIndicator;
    
    Tabbar *tabbar;
    OrderStatusViewController* orderStatusViewController;
    BrowseViewController* browseViewController;
    SpecialOffersViewController *specialOffersViewController;
}


@property (nonatomic, strong) UITableView	*addToBagTable;

@property (nonatomic, strong) NSMutableArray *productImageArray;

@property (nonatomic, strong) NSMutableArray	*productNameArray;

@property (nonatomic, strong)  NSString *strFirst;

@property (nonatomic, strong)  NSString *strLast;

@property (nonatomic, strong)  NSString *strComp;

@property (nonatomic, strong)  NSString *strAddr1;

@property (nonatomic, strong)  NSString *strAddr2;

@property (nonatomic, strong)  NSString *strCity;

@property (nonatomic, strong)  NSString *strState;

@property (nonatomic, strong)  NSString *strCountry;

@property (nonatomic, strong)  NSString *strZip;

@property (nonatomic, strong)  NSString *strPhone;

@property (nonatomic, strong)  NSString *strEmailId;

@property (nonatomic, strong)  NSString *strOrderComments;

@property (nonatomic, strong)  NSString *stringTotalPrice;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong)  SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong) OrderStatusViewController *orderStatusViewController;

@property (nonatomic, strong)  BrowseViewController *browseViewController;


-(void)goBack:(id)sender;

-(void) loadNavigationBar;

-(void) initializeTableView;

-(void)reviewAction:(id)sender;

-(void)cancelAction:(id)sender;


@end
