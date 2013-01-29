//
//  NavigationView.h
//  NavigationBar
//
//  Created by Nagarajan on 1/19/13.
//  Copyright (c) 2013 Nagarajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationBarDelegate <NSObject>

-(void) backButtonAction;
-(void) goBack:(id)sender;
@end

@interface NavigationView : UIView
{
    __weak id navigationDelegate;
    NSMutableDictionary* dataDictionary ;
}
@property (weak) id navigationDelegate;
-(void)loadNavbar:(BOOL)isBackNeeded :(BOOL)isForwardNeeded;
@end
