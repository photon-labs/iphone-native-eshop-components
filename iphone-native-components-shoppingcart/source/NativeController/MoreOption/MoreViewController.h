//
//  MoreViewController.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tabbar;
@interface MoreViewController : UIViewController
{
    UIView* moreView;
    Tabbar *tabbar;
}
@property (nonatomic, retain) UIView* moreView;

-(void) loadNavigationBar;
-(void) initializeTextView;
-(void)goBack:(id)sender;
@end

