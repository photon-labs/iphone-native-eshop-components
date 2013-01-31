//
//  ReviewViewController.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddToBagViewController;
@class SubmitReviewViewController;
@class SpecialOffersViewController;
@class ReviewCommentsViewController;
@class Tabbar;
@class LoginViewController;
@interface ReviewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    
    UITableView* reviewTableView;
    UITextView* reviewTextview;
    
    UILabel* oneStar;
    UILabel* twoStar;
    UILabel* threeStar;
    UILabel* fourStar;
    UILabel* fiveStar;
    
    NSMutableArray* commentArray;
    UIImageView *starImage ;
    NSMutableArray* averageArray;
    UILabel* average;
    
    AddToBagViewController* addToBagViewController;
    
    SubmitReviewViewController *submitReviewViewController;
    
    SpecialOffersViewController *specialOffersViewController;
    
    ReviewCommentsViewController *reviewCommentsViewController;
    
    UIButton* submitReview;
    
    NSString* revId;
    
    NSString *stringAverage;
    
    Tabbar *tabbar;
    BOOL isSpecialOffer;
    
    LoginViewController* loginViewController;
    
    BOOL loginChk;
    int reviewProductId;
    
    NSMutableArray* array_;
}
@property (nonatomic, strong) NSMutableArray* commentArray;
@property (nonatomic, strong) NSMutableArray* averageArray;
@property (nonatomic, strong) UITableView* reviewTableView;
@property (nonatomic, strong) UITextView* reviewTextview;
@property (nonatomic, strong) UILabel* oneStar;
@property (nonatomic, strong) UILabel* twoStar;
@property (nonatomic, strong) UILabel* threeStar;
@property (nonatomic, strong) UILabel* fourStar;
@property (nonatomic, strong) UILabel* fiveStar;
@property (nonatomic, strong) NSMutableArray* array_;
@property (nonatomic, strong) UILabel* average;
@property (nonatomic, strong) UIButton* submitReview;
@property (nonatomic) BOOL isSpecialOffer;
@property (nonatomic) BOOL loginChk;
@property (nonatomic) int reviewProductId;

@property (nonatomic, retain) LoginViewController* loginViewController;

@property (nonatomic, strong) AddToBagViewController* addToBagViewController;

@property (nonatomic, strong) SubmitReviewViewController *submitReviewViewController;

@property (nonatomic, strong) SpecialOffersViewController *specialOffersViewController;

@property (nonatomic, strong)ReviewCommentsViewController *reviewCommentsViewController;

-(void) loadNavigationBar;
-(void) initializeTableView;
-(void) goBack:(id) sender;
-(void)ratingValuechanged:(id)sender;
-(void)submitReviewButtonSelected:(id)sender;


@end

