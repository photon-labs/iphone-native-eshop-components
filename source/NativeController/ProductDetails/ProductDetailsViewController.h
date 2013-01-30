//
//  ProductDetailsViewController.h
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddToBagViewController;
@class ReviewViewController;
@class Tabbar;

@interface ProductDetailsViewController : UIViewController
{
    
    UIScrollView *scrollView;
    UIImageView *starImage;
    BOOL loginChk;
    int index;
    
    Tabbar *tabbar;
    ReviewViewController* reviewViewController;
    AddToBagViewController *addToBagController;
    
}

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, strong) AddToBagViewController *addToBagController;

@property (nonatomic, strong) ReviewViewController* reviewViewController;

@property (nonatomic) BOOL loginChk;

@property (nonatomic) int index;

-(void) loadNavigationBar;

-(void) initializeProductImageView;

-(void) initializeProductDescription;

-(void) setProductDetail;

-(void) addToCart:(id) sender;

@end
