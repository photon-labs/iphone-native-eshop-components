//
//  LoginView.m
//  Phresco
//
//  Created by SHIVAKUMAR_CH on 1/23/13.
//  Copyright (c) 2013 SHIVAKUMAR_CH. All rights reserved.
//

#import "LoginView.h"
#import "ThemeReader.h"

#define SCREENWIDTH [UIScreen mainScreen].applicationFrame.size.width
#define SCREENHEIGHT [UIScreen mainScreen].applicationFrame.size.height

#define emailLabelTag 3453
#define passwordLabelTag 9454

#define cancelButtonTag 233

#define emailTextFieldTag 123
#define passwordTextFieldTag 198


#define emailTag 345
#define passwordTag 867

@implementation LoginView
@synthesize loginDelegate;
@synthesize emailField;
@synthesize passwordField;
- (id)init
{
    self = [super init];
    if (self) {
        loginDelegate = nil;
    }
    return self;
}

-(void) createLoginView
{    
    ThemeReader *themeReader = [[ThemeReader alloc] init];
    NSMutableDictionary *loginDict = [themeReader loadDataFromPlist:@"Login"];
    
    NSString *bgString = [loginDict objectForKey:@"backgroundImage"];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.frame];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:bgString ofType:@"png"];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:filePath];
    bgView.image = bgImage;
    [self addSubview:bgView];
    
    NSString *loginHeaderString = [loginDict objectForKey:@"header"];
    if(nil != loginHeaderString && [loginHeaderString length] >0)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:loginHeaderString ofType:@"png"];
        UIImage *loginHeaderImage = [UIImage imageWithContentsOfFile:filePath];
        if(nil != loginHeaderImage)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - loginHeaderImage.size.width)/2, self.frame.origin.y - loginHeaderImage.size.height/2 +10, loginHeaderImage.size.width, loginHeaderImage.size.height)];
            imageView.image = loginHeaderImage;
            [self addSubview:imageView];
        }
    }
    //Email Label
    NSString *emailAddressString = [loginDict objectForKey:@"emailaddress"];
    if(nil !=emailAddressString && [emailAddressString length]>0)
    {
        NSString* font = [loginDict objectForKey:@"font"];
        if(nil != font && [font length]>0){
            UILabel *emailAddView=nil;
         if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {   
             emailAddView = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x+25,self.frame.origin.y+45,250,50 )];
             emailAddView.font=[UIFont fontWithName:font size:24];
         }
         else{
             emailAddView = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x+25,self.frame.origin.y+45,120,15 )];
             emailAddView.font=[UIFont fontWithName:font size:12];
         }
        emailAddView.text=emailAddressString;
        emailAddView.tag = emailLabelTag;
        emailAddView.backgroundColor=[UIColor clearColor];
        emailAddView.textColor=[UIColor whiteColor];
        [self addSubview:emailAddView];
        }
    }
    //Email Text Field
    UIView *email = [self viewWithTag:emailLabelTag];
//    UITextField *emailField=nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

    emailField=[[UITextField alloc]initWithFrame:CGRectMake(email.frame.origin.x,self.frame.origin.y+90,650,50)];
    }
    else{
        emailField=[[UITextField alloc]initWithFrame:CGRectMake(email.frame.origin.x,self.frame.origin.y+70,270,30)];

    }
    emailField.delegate = self;
    emailField.text=@"";
    emailField.borderStyle = UITextBorderStyleNone;
    emailField.keyboardType = UIKeyboardTypeDefault;
    emailField.returnKeyType = UIReturnKeyNext;
    emailField.tag = emailTextFieldTag;
    emailField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:emailField];
    
   //PassWord Label
    NSString *passwordString = [loginDict objectForKey:@"password"];
    if(nil !=passwordString && [passwordString length]>0)
    {
        NSString* font = [loginDict objectForKey:@"font"];
        if(nil != font && [font length]>0){
            UILabel *passwordView=nil;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
               passwordView = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x+25,(self.frame.origin.y+emailField.frame.size.height+80),250,50 )];
                 passwordView.font=[UIFont fontWithName:font size:24];
            }
            else{
                passwordView = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x+25,(self.frame.origin.y+emailField.frame.size.height+80),120,15 )];
                 passwordView.font=[UIFont fontWithName:font size:12];
            }
    
    passwordView.text= passwordString;
    passwordView.tag = passwordLabelTag;
    passwordView.backgroundColor=[UIColor clearColor];
    passwordView.textColor=[UIColor whiteColor];
    [self addSubview:passwordView];
        }
    }
    
    //Password field
    UIView *password = [self viewWithTag:passwordLabelTag];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    passwordField=[[UITextField alloc]initWithFrame:CGRectMake(password.frame.origin.x,self.frame.origin.y+190,650,50)];
    }else{
        passwordField=[[UITextField alloc]initWithFrame:CGRectMake(password.frame.origin.x,self.frame.origin.y+140,270,30)];
 
    }
    passwordField.delegate = self;
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.returnKeyType = UIReturnKeyDone;
    passwordField.tag = passwordTextFieldTag;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.secureTextEntry=YES;
    [self addSubview:passwordField];
    //
    
    
    NSString *cancelButton =[loginDict objectForKey:@"cancelImage"];
    if(cancelButton != nil && [cancelButton length]>0){
        NSString *filePath = [[NSBundle mainBundle] pathForResource:cancelButton ofType:@"png"];
        UIImage *cancelImage = [UIImage imageWithContentsOfFile:filePath];
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(SCREENWIDTH - cancelImage.size.width - 20, passwordField.frame.origin.y + passwordField.frame.size.height + 20, cancelImage.size.width, cancelImage.size.height);
        button.tag = cancelButtonTag;
        [button addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:cancelImage forState:UIControlStateNormal];
        [self addSubview:button];
    }

    NSString *loginButton =[loginDict objectForKey:@"loginImage"];
    if(loginButton != nil && [loginButton length]>0){
        
         NSString *filePath = [[NSBundle mainBundle] pathForResource:loginButton ofType:@"png"];
        UIImage *loginImage = [UIImage imageWithContentsOfFile:filePath];
        UIButton *button = [[UIButton alloc]init];
        UIView *cancelButton = [self viewWithTag:cancelButtonTag];
        button.frame=CGRectMake(SCREENWIDTH - cancelButton.frame.size.width - loginImage.size.width - 40,passwordField.frame.origin.y + passwordField.frame.size.height + 20 ,loginImage.size.width,loginImage.size.height);
        [button setBackgroundImage:loginImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginButtonPressed:PASSWORD:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == emailTextFieldTag)
    {
        UITextField *textField = (UITextField*)[self viewWithTag:passwordTextFieldTag];
        [textField becomeFirstResponder];
        UIView *passwordLabel = [self viewWithTag:passwordLabelTag];
        if(!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            originalFrame = self.frame;
            [self animateKeyboard:CGRectMake(self.frame.origin.x, self.frame.origin.y - textField.frame.size.height - passwordLabel.frame.size.height, self.frame.size.width, self.frame.size.height)];
        }
    }
    if(textField.tag == passwordTextFieldTag)
    {
        if(!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self animateKeyboard:originalFrame];
        }
    }
}

-(void) animateKeyboard:(CGRect) frame
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.frame = frame;
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"#"]) {
        return NO;
    }
    else {
        return YES;
    }

}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}


-(void)loginButtonPressed:(NSString*)emailAddress PASSWORD:(NSString*)password
{
    emailAddress=emailField.text;
    password=passwordField.text;
    NSLog(@"%@",emailAddress);
    if(nil != loginDelegate && [loginDelegate respondsToSelector:@selector(loginButtonAction:PASSWORD:)])
    {
        [loginDelegate loginButtonAction:emailAddress PASSWORD:password];
    }
}

-(void) cancelButtonPressed
{
    if(nil != loginDelegate && [loginDelegate respondsToSelector:@selector(cancelButtonAction)])
    {
        [loginDelegate cancelButtonAction];
    }
}



@end
