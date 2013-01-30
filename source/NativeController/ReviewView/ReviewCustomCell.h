//
//  ReviewCustomCell.h
//  Phresco
//
//  Created by Rojaramani on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCustomCell : UITableViewCell
{
    UIImageView* ratingImage;
    UILabel* commentsLabel;
    UIImageView* disImage;
    UILabel *userNameLabel;
    UILabel *dateLabel;
    NSMutableArray            *imageFramesArray;
}
@property(nonatomic, retain) UILabel*  commentsLabel;
@property(nonatomic, retain) UIImageView* ratingImage;
@property(nonatomic, retain) UIImageView* disImage;
@property (nonatomic, retain) UILabel *userNameLabel; 
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) NSMutableArray *imageFramesArray;

@end
