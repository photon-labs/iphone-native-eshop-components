//
//  AppDelegate.h
//  Phresco
//
//  Created by Rojaramani on 03/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    NSDate *date;
	Reachability *reachability;	
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, strong) NSDate *date;	

@property (nonatomic, strong) Reachability *reachability;

@end
