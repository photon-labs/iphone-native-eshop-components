/**
 * PHR_iphoneNativeEshopARC
 *
 * Copyright (C) 1999-2013 Photon Infotech Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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


