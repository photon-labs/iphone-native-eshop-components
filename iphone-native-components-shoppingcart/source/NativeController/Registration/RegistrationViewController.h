//
//  RegistrationViewController.h
//  Phresco
//
//  Created by Rojaramani on 24/10/12.
//
//

#import <UIKit/UIKit.h>
@class Tabbar;

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate> {
    
    
    
    UITextField* firstName;
    UITextField* lastName;
    UITextField* emailAddress;
    UITextField* passWord;
    UITextField* confirmPassword;
    UITextField* phoneNumber;
    UIScrollView* regScrollView;
    UIView* backGroundView;
    UIView *viewController;
    UIButton *okButton;
    UIButton *closeButton;
    UIImageView *myImageView;
    
    UIButton* registerButton;
    UIButton* cancelButton;
    UIActivityIndicatorView* activityIndicator;
    Tabbar *tabbar;
    
}

@property (nonatomic, retain) UIView* backGroundView;
@property (nonatomic, retain)  UIView *viewController;
@property (nonatomic, retain) UIButton *okButton;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, retain) UIImageView *myImageView;

@property (nonatomic, retain) UIButton* registerButton;
@property (nonatomic, retain) UIButton* cancelButton;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicator;

-(void) loadNavigationBar;

-(void) createRegistrationScreen;

- (BOOL)validateEmail:(NSString *)inputText;

- (void)registerButtonSelected:(id)sender;


@end
