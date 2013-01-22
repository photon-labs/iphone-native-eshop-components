//
//  ViewCartViewController.h
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CheckOutViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class Tabbar;

@interface ViewCartViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView* viewCartTable;
    UILabel* Quantity;
    UILabel* Product;
    UILabel* Price;
    UILabel *lblSubtotal;
    UILabel* PriceLabel;
    
    NSString *cartPurchaseTotal;
    NSString *cartQuantity;
    
    CheckOutViewController  *checkCartController;
    
    BrowseViewController *browseViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    Tabbar *tabbar;

}
@property(nonatomic, strong)  UITableView* viewCartTable;

@property(nonatomic, strong) UILabel* Quantity;

@property(nonatomic, strong) UILabel*  Product;

@property(nonatomic, strong) UILabel*  Price;

@property(nonatomic, strong) UILabel*  PriceLabel;

@property (nonatomic, strong) NSString *cartPurchaseTotal;

@property (nonatomic, strong) NSString *cartQuantity;

@property (nonatomic, strong) CheckOutViewController  *checkCartController;

@property (nonatomic, strong) BrowseViewController *browseViewController;

@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;

-(void) loadNavigationBar;

-(void) initializeTableView;

-(void) goBack:(id) sender;

- (void) browseButtonSelected:(id) sender;
@end


