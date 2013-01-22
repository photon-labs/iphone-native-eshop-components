//
//  LogicTest.h
//  LogicTest
//
//  Created by Rojaramani on 30/10/12.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIkit.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "BrowseViewController.h"
#import "ResultViewController.h"
#import "ProductDetailsViewController.h"
#import "AddToBagViewController.h"
#import "ViewCartViewController.h"
#import "CheckOutViewController.h"
#import "CheckOutOverallViewController.h"
#import "ReviewViewController.h"
#import "ReviewCommentsViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "SpecialOffersViewController.h"
@interface LogicTest : SenTestCase
{
@private
    AppDelegate *appDelegate;
    ViewController *rootController;
    HomeViewController *homeController;
    BrowseViewController *browseController;
    ResultViewController *resultController;
    ProductDetailsViewController *pdtDetailController;
    AddToBagViewController *addCartController;
    ViewCartViewController *viewCartController;
    CheckOutViewController *checkViewController;
    CheckoutOverAllViewController *checkOverallController;
    ReviewViewController *reviewController;
    ReviewCommentsViewController *reviewCommentsController;
    LoginViewController *loginController;
    RegistrationViewController *registerController;
    SpecialOffersViewController *splOfferController;
    
    UITableView *tblView;
}
@end
