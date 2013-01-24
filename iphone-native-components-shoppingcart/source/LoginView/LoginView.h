//
//  LoginView.h
//  Phresco
//
//  Created by SHIVAKUMAR_CH on 1/23/13.
//  Copyright (c) 2013 SHIVAKUMAR_CH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate<NSObject>

-(void)cancelButtonAction;
-(void)loginButtonAction:(NSString*)emailAddress PASSWORD:(NSString*)password;
@end
@interface LoginView : UIView<UITextFieldDelegate>
{
    __weak id loginDelegate;
    CGRect kbSize;
    CGRect originalFrame;
    UITextField *emailField;
    UITextField *passwordField;
}
@property(weak) id loginDelegate;
@property(nonatomic,retain)UITextField *emailField;
@property(nonatomic,retain)UITextField *passwordField;
-(void) createLoginView;
@end
