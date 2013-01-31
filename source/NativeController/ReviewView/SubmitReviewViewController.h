//
//  SubmitReviewViewController.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class AddToBagViewController;
@class SpecialOffersViewController;
@class Tabbar;
@class LoginViewController;

@interface SubmitReviewViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* commentTextView;
    UIButton* submitButton;
    NSString* productReviewID;
    UIButton *ratingsButton;
    UIActivityIndicatorView* activityIndicator;
    NSString* user ;
    NSString* userID;
    NSMutableArray* submitArray;
    
    BOOL isFromSpecialOffer;
    BOOL isUserLogged;
    BOOL loginChk;
    int submitProductID;
    
    Tabbar *tabbar;
    LoginViewController* loginViewController;
    AddToBagViewController *addToBagViewController;
    SpecialOffersViewController *specialOffersViewController;
    
    
}
@property (nonatomic,retain) UITextField* commentTextView;
@property (nonatomic, retain) UIButton* submitButton;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) NSMutableArray* submitArray;
@property (nonatomic, retain)NSString* user ;
@property (nonatomic, retain)NSString* userID ;
@property (nonatomic) int submitProductID;
@property (nonatomic) BOOL isFromSpecialOffer;
@property (nonatomic, assign)BOOL isUserLogged;
@property (nonatomic) BOOL loginChk;

@property (nonatomic, retain) LoginViewController* loginViewController;
@property (nonatomic, retain) AddToBagViewController *addToBagViewController;
@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;



-(void) loadNavigationBar;
-(void) initializeTableView;
-(void) goBack:(id) sender;
-(void)postComments:(id)sender;
@end
