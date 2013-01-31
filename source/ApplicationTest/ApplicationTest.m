//
//  ApplicationTest.m
//  ApplicationTest
//
//  Created by Rojaramani on 31/10/12.
//
//

#import "ApplicationTest.h"

@implementation ApplicationTest

- (void)setUp
{
    [super setUp];
    
//    appDelegate = [[UIApplication sharedApplication]delegate];
//    loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
}


-(void)testAppDelegate
{
    
    //STAssertNotNil(appDelegate, @"Cannot find the application delegate");
}

- (void)tearDown
{
    
    [super tearDown];
}

- (void)testLogin
{

    [loginVC testLoginButton:nil userName:@"john@phresco.com" passWord:@"john"];
    STAssertTrue([loginVC.successMsg isEqualToString:@"Login Success"],@"Login Success", @"pass");
    
    [loginVC testLoginButton:nil userName:@"john@phresco.com" passWord:@" "];
    STAssertTrue([loginVC.successMsg isEqualToString:@"Login failed"],@"Login failed", @"invalid password");
    
    [loginVC testLoginButton:nil userName:@" " passWord:@"123"];
    STFail(@"Please enter Email id");
    
    [loginVC testLoginButton:nil userName:@"john@phresco.com" passWord:@" "];
    STFail(@"Please enter password");
    
    [loginVC testLoginButton:nil userName:@" " passWord:@" "];
  STFail(@"PLease enter email id and password");

    
}


@end
