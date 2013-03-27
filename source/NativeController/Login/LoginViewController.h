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
//  LoginViewController.h
//  Phresco
//
//  Created by Rojaramani on 24/10/12.
//
//

#import <UIKit/UIKit.h>
@class RegistrationViewController;
@class iShopAppDelegate;
@class Tabbar;
@class SubmitReviewViewController;
@class BrowseViewController;
@class HomeViewController;
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *emailAddress;
    
    UITextField *password;
    RegistrationViewController *registrationViewController;
    UIButton *backButton;
    
    UIButton *closeButton;
    UIButton *okButton;
    UIButton* registerButton;
    UIButton *button_;
    UIButton *loginButton;
    UIButton *cancelButton;
    iShopAppDelegate* appDelegate;
    UIActivityIndicatorView* activityIndicator;
    Tabbar *tabbar;
    
    int index;
    BOOL isLogin;
    BOOL unitTestCheck;
    
    NSMutableString* strMsg;
    
    NSMutableString* successMsg;
    
    NSMutableString* userID;
    
    NSMutableString* userName;
    
    NSMutableArray* loginArray;
    
    SubmitReviewViewController* submitReviewViewController;
    
    BrowseViewController *browseViewController;
    
    HomeViewController *homeViewController;
    
    
    
}

@property (nonatomic, strong) UITextField *emailAddress;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton* registerButton;
@property (nonatomic, strong) UIButton* button_;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property  BOOL isLogin;
@property  BOOL unitTestCheck;

@property (nonatomic, strong)NSMutableString* strMsg;
@property (nonatomic, strong) NSMutableString* successMsg;
@property (nonatomic, strong)NSMutableString* userID;
@property (nonatomic, strong)NSMutableString* userName;
@property (nonatomic, strong)NSMutableArray* loginArray;

@property (nonatomic, strong) SubmitReviewViewController* submitReviewViewController;
@property (nonatomic, strong) BrowseViewController *browseViewController;
@property (nonatomic, strong)  HomeViewController *homeViewController;
@property (nonatomic, strong) RegistrationViewController *registrationViewController;


-(void) loadNavigationBar;

-(void) createLoginScreen;

- (void)registerButtonSelected:(id)sender;

-(void)testLoginButton:(id)sender userName:(NSString*)user  passWord:(NSString*)pwd ;


@end
