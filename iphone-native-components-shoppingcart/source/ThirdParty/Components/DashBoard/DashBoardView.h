//
//  ViewController.h
//  DashBoardComponent
//
//  Created by Rojaramani on 22/01/13.
//  Copyright (c) 2013 Photon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dashBoardDelegate <NSObject>
- (void)callViewController:(id)sender;
@end

@class ThemeReader;
@interface DashBoardView : UIView <dashBoardDelegate>
{
    __weak id <dashBoardDelegate> delegate;
    UIImageView* bgView;
}
@property (nonatomic, strong) UIImageView* bgView;
@property (weak) id <dashBoardDelegate> delegate;
- (void)homeButtonAction: (id)sender;
- (void)loadComponents ;
@end
