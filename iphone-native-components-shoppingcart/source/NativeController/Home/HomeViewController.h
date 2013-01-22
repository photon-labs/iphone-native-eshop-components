//
//  HomeViewController.h
//  Phresco
//
//  Created by Rojaramani on 04/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@class LoginViewController;
@class RegistrationViewController;
@class BrowseViewController;
@class SpecialOffersViewController;
@class ResultViewController;
@class Tabbar;
@class SubmitReviewViewController;

@interface HomeViewController : UIViewController
{
     Tabbar *tabbar;
    
    UIActivityIndicatorView* activityIndicator;
    
    UITextField	*searchTextField;
    
    UIButton *btnSearchIcon;
    
    NSMutableArray* array;
    
    BrowseViewController		*browseViewController;
    
    SubmitReviewViewController* SubmitReviewViewController;
    
    LoginViewController *loginViewController;
   
    RegistrationViewController  *registrationViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    ResultViewController        *resultViewController;


}
@property (nonatomic, strong) UITextField	*searchTextField;

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@property (nonatomic, strong) NSMutableArray* array_;

@property (nonatomic, strong) BrowseViewController		*browseViewController;

@property (nonatomic, retain) LoginViewController *loginViewController;

@property (nonatomic, retain) RegistrationViewController  *registrationViewController;


@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong) ResultViewController        *resultViewController;

@property (nonatomic, retain) SubmitReviewViewController *submitReviewViewController;

-(void) loadNavigationBar;

-(void) addSearchBar;

-(void) addHomePageIcons;

-(BOOL) checkIfOdd:(int) num;

-(void) buttonAction:(id) sender;

- (void)searchButtonSelected;

-(void) finishedCatalogService:(id) data;
@end
