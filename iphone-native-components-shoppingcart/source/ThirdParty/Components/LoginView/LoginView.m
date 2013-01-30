//
//  LoginView.m
//  Phresco
//
//  Created by SHIVAKUMAR_CH on 1/23/13.
//  Copyright (c) 2013 SHIVAKUMAR_CH. All rights reserved.
//

#import "LoginView.h"
#import "ThemeReader.h"
#import "Constants.h"


@implementation LoginView
@synthesize loginDelegate;
@synthesize emailField;
@synthesize passwordField;
- (id)init
{
    self = [super init];
    if (self) {
        loginDelegate = nil;
        loginDefaultsDict = nil;
    }
    return self;
}

-(void) createLoginView
{
loginDefaultsDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Password",kDefaultPasswordCaption , @"Email Address",kDefaultEmailAddressCaption ,@"login_bg",kDefaultBackgroundImage,@"login_header",kDefaultHeaderImage,@"login_btn",kDefaultLoginImage,@"cancel_btn",kDefaultCancelImage,@"Helvetica-Bold",kDefaultFontType, nil];
    
    NSString *bgString = [self getObjectForKey:@"backgroundImage"];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.frame];
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:bgString ofType:@"png"];
    UIImage *bgImage = [UIImage imageNamed:bgString];
    bgView.image = bgImage;
    [self addSubview:bgView];
    
    NSString *loginHeaderString = [self getObjectForKey:@"header"];
    if(nil != loginHeaderString && [loginHeaderString length] >0)
    {
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:loginHeaderString ofType:@"png"];
        UIImage *loginHeaderImage = [UIImage imageNamed:loginHeaderString];
        if(nil != loginHeaderImage)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - loginHeaderImage.size.width)/2, self.frame.origin.y - loginHeaderImage.size.height/2 +10, loginHeaderImage.size.width, loginHeaderImage.size.height)];
            imageView.image = loginHeaderImage;
            [self addSubview:imageView];
        }
    }
    //Email Label
    NSString *emailAddressString = [self getObjectForKey:@"emailaddress"];
    if(nil !=emailAddressString && [emailAddressString length]>0)
    {
        NSString* font = [self getObjectForKey:@"font"];
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
    NSString *passwordString = [self getObjectForKey:@"password"];
    if(nil !=passwordString && [passwordString length]>0)
    {
        NSString* font = [self getObjectForKey:@"font"];
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
    
    
    
    NSString *cancelButton =[self getObjectForKey:@"cancelImage"];
    if(cancelButton != nil && [cancelButton length]>0){
        //NSString *filePath = [[NSBundle mainBundle] pathForResource:cancelButton ofType:@"png"];
        UIImage *cancelImage = [UIImage imageNamed:cancelButton];
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(SCREENWIDTH - cancelImage.size.width - 20, passwordField.frame.origin.y + passwordField.frame.size.height + 20, cancelImage.size.width, cancelImage.size.height);
        button.tag = cancelButtonTag;
        [button addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:cancelImage forState:UIControlStateNormal];
        [self addSubview:button];
    }

    NSString *loginButton =[self getObjectForKey:@"loginImage"];
    if(loginButton != nil && [loginButton length]>0){
        
        
        UIImage *loginImage = [UIImage imageNamed:loginButton];
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

-(NSString*)getObjectForKey:(NSString*)loginKey{
    if(loginKey != nil &&[loginKey length]>0){
        ThemeReader *themeReader =[[ThemeReader alloc]init];
        NSMutableDictionary *loginDict = nil;
        loginDict = [themeReader loadDataFromManifestPlist:@"Login"];
        if(nil != loginDict && [loginDict count] >0)  //Get data from manifest plist
        {
            NSString* object=[loginDict objectForKey:loginKey];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else  //Get Data  from feature-Manifest  for key
            {
            loginDict = [themeReader loadDataFromComponentPlist:loginKey INCOMPONENT:@"Login"];
             if(nil != loginDict && [loginDict count] > 0)
             {
                NSString *object = [loginDict objectForKey:loginKey];
                if(nil != object && [object length] > 0)
                {
                    return object;
                }
                 else
                 {
                     NSString *object = [loginDefaultsDict objectForKey:loginKey];
                     return object;
                 }
             }
             
                
            }
      }
   
      else  //Get Data  from feature-Manifest 
      {
          NSMutableDictionary *loginViewDict=[themeReader loadDataFromComponentPlist:loginKey INCOMPONENT:@"Login"];
          if(nil != loginViewDict && [loginViewDict count] > 0)
          {
              NSString *object = [loginViewDict objectForKey:loginKey];
              if(nil != object && [object length] > 0)
              {
                  return object;
              }
              else{
                  return [loginDefaultsDict objectForKey:loginKey];
              }
             
              
          }
          
      }
        return [loginDefaultsDict objectForKey:loginKey];
     }
    return nil;
 }
@end
