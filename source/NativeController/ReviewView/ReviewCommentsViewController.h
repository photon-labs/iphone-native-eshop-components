//
//  ReviewCommentsViewController.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddToBagViewController;
@class SpecialOffersViewController;
@class Tabbar;
@interface ReviewCommentsViewController : UIViewController {
    UILabel* commentsLabel;
    UIImageView* ratingImage;
    
    UIImageView* disImage;
    UILabel *userNameLabel;
    UILabel *dateLabel;
    NSMutableArray* commentArray;
    NSString* ratingCount;
    
    SpecialOffersViewController *specialOffersViewController;
    AddToBagViewController *addToBagViewController;
    Tabbar *tabbar;


}
@property(nonatomic, retain) UILabel*  commentsLabel;
@property(nonatomic, retain) UIImageView* ratingImage;

@property(nonatomic, retain) UIImageView* disImage;
@property (nonatomic, retain) UILabel *userNameLabel; 
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) NSMutableArray* commentArray;
@property (nonatomic, retain) NSString*  ratingCount;

@property (nonatomic, retain) SpecialOffersViewController *specialOffersViewController;
@property (nonatomic, retain) AddToBagViewController *addToBagViewController;

-(void) loadNavigationBar;
-(void) initializeTableView;
-(void)goBack:(id)sender;

@end
