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
//  HomeViewController.h
//  Phresco
//
//  Created by Rojaramani on 04/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "DashBoardView.h"
@class LoginViewController;
@class RegistrationViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class ResultViewController;
@class Tabbar;
@class SubmitReviewViewController;

@interface HomeViewController : UIViewController <UITextFieldDelegate,dashBoardDelegate>
{
    Tabbar *tabbar;
    
    UIActivityIndicatorView* activityIndicator;
    UIButton *btnSearchIcon;
    
    NSMutableArray* array;
    
    BrowseViewController		*browseViewController;
    
    SubmitReviewViewController* SubmitReviewViewController;
    
    LoginViewController *loginViewController;
    
    RegistrationViewController  *registrationViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    ResultViewController        *resultViewController;
    
    DashBoardView* dashBoard;
    
    float navBarHieght;
    float searchBarHieght;
}

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, strong) NSMutableArray* array_;

@property (nonatomic, strong) BrowseViewController		*browseViewController;

@property (nonatomic, retain) LoginViewController *loginViewController;

@property (nonatomic, retain) RegistrationViewController  *registrationViewController;


@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong) ResultViewController        *resultViewController;

@property (nonatomic, retain) SubmitReviewViewController *submitReviewViewController;

@property (nonatomic, strong)DashBoardView* dashBoard;

-(void) loadNavigationBar;

-(void) addSearchBar;

-(void) addHomePageIcons;

-(BOOL) checkIfOdd:(int) num;

-(void) callViewController:(id) sender;

- (void)searchButtonSelected:(NSString*)searchTextEdit;

-(void) finishedCatalogService:(id) data;
@end
