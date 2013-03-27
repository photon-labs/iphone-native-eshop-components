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
//  ViewController.h
//  Phresco
//
//  Created by Rojaramani on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHandler.h"
@class Tabbar;
@class HomeViewController;
@class NavigationBar;
@class WebContainer;
@class MoreViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class AddToBagViewController;
@interface ViewController : UIViewController
{
    IBOutlet UIView *loading;
	
    int indexSelectedInMorePage;
    Tabbar          *tabbar;
    NavigationBar   *navigationBar;
     WebContainer    *webContainer;
    ServiceHandler *serviceHandler;
    HomeViewController	 *homeViewController;
    
    MoreViewController *moreViewController;
    BrowseViewController *browseViewController;
    SpecialOffersViewController *specialOffersViewController;
    AddToBagViewController* addToBagViewController;

}
@property (nonatomic, strong) HomeViewController	 *homeViewController;
@property(nonatomic, strong) WebContainer    *webContainer;
@property(nonatomic, strong) NavigationBar   *navigationBar;
@property(nonatomic, strong) Tabbar *tabbar;
@property (nonatomic, strong) MoreViewController *moreViewController;
@property (nonatomic, strong) BrowseViewController *browseViewController;
@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;
@property (nonatomic, strong) AddToBagViewController* addToBagViewController;
-(void)addLoadingScreen;
-(void)removeLoadingScreen;
-(void)callConfigService;
-(void)configServiceCallDone:(NSMutableDictionary*)dictionary;
-(void)willStartLoadingFeaturedAssets;
-(void)willStartLoadingExtraAssets;

-(void)showTabbar;
-(UIView*)loadNavigationBar;

-(NSArray*)categoriseFeaturesWithRange:(NSRange)range;
-(void)addNativeControllerForIndex:(int)index toArray:(NSMutableArray*)controllers;
-(void)moreButtonsAction:(id)sender;
-(void)tabBarButtonAction:(id)sender;
-(void)showViewOfFeature:(NSString*)title userInfo:(NSDictionary*)userInfo;
-(void)willStartLoadingFeaturedAssets;

@end
