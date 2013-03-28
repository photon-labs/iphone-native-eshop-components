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
