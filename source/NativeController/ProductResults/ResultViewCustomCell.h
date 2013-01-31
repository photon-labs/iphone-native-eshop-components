//
//  ResultViewCustomCell.h
//  Phresco
//
//  Created by Rojaramani on 09/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewCustomCell : UITableViewCell
{
UIImageView		*productImage;

UILabel		*productName;

UILabel			*priceLabel;

UILabel         *dollarSign;

UIButton		*reviewsButton;

UIImageView		*ratingsView;

NSMutableArray  *imageFramesArray;

BOOL isSelected;

UIImageView* disImage;

}

@property (nonatomic, retain) UIImageView		*productImage;

@property (nonatomic, retain) UILabel		*productName;

@property (nonatomic, retain) UILabel		*productPrice;

@property (nonatomic, retain) UILabel		*priceLabel;

@property (nonatomic, retain) UILabel       *dollarSign;

@property (nonatomic, retain) UIButton		*reviewsButton;

@property(nonatomic, retain) UIImageView* disImage;

@property (nonatomic, retain)NSMutableArray  *imageFramesArray;
@property (nonatomic, retain) UIImageView   *ratingsView;
@property(nonatomic) BOOL isSelected;


@end
