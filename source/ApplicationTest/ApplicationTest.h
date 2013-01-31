//
//  ApplicationTest.h
//  ApplicationTest
//
//  Created by Rojaramani on 31/10/12.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "BrowseViewController.h"
#import "LoginViewController.h"
@class LoginViewController;

@interface ApplicationTest : SenTestCase {
    
@private
    AppDelegate* appDelegate;
    LoginViewController* loginVC;
}

@end
