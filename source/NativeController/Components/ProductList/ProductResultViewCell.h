//
//  ResultViewCell.h
//  ProductListComponent
//
//  Created by Rojaramani on 16/01/13.
//  Copyright (c) 2013 Photon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeReader;
@interface ProductResultViewCell : UITableViewCell {
    UIImageView		*productImage;
    UILabel		    *productName;
    UILabel			*priceLabel;
    UILabel         *dollarSign;
    UIButton		*reviewsButton;
    UIImageView		*ratingsView;
    /*For Categories page*/
    UILabel *productCountLabel;
    UIImageView* disImage;
    UIImageView* countImage;
    NSMutableArray  *imageFramesArray;
    BOOL isSelected;
    NSMutableDictionary* productResultDefaultDict;
}
@property (nonatomic, strong) NSMutableDictionary* productResultDefaultDict;
@property (nonatomic, strong) UIImageView	*productImage;
@property (nonatomic, strong) UILabel		*productName;
@property (nonatomic, strong) UILabel		*productPrice;
@property (nonatomic, strong) UILabel		*priceLabel;
@property (nonatomic, strong) UILabel       *dollarSign;
@property (nonatomic, strong) UIButton		*reviewsButton;
@property(nonatomic, strong)  UIImageView    *disImage;
@property (nonatomic, strong) NSMutableArray  *imageFramesArray;
@property (nonatomic, strong) UIImageView   *ratingsView;
@property (nonatomic, strong) UILabel *productCountLabel;
@property (nonatomic, strong) UIImageView* countImage;
@property(nonatomic) BOOL isSelected;
-(NSString*)getObjectForKey:(NSString*)navigationKey;

@end
