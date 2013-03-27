/**
 * PHR_iphoneNativeEshopARC
 *
 * Copyright (C) 1999-2013 Photon Infotech Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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
