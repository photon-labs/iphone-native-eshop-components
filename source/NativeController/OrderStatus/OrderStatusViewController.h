//
//  OrderStatusViewController.h
//  Phresco
//
//  Created by Rojaramani on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrowseViewController;
@class Tabbar;
@interface OrderStatusViewController : UIViewController
{
    UITextView* orderStatusTextView;//orderStatusTextView
    BrowseViewController* browseViewController;
    Tabbar *tabbar;
}
@property (nonatomic, retain) UITextView* orderStatusTextView;
@property (nonatomic, retain) BrowseViewController* browseViewController;

-(void) loadNavigationBar;
-(void) initializeTextView;
-(void)goBack:(id)sender;
@end
