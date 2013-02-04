//
//  ResultViewCell.m
//  ProductListComponent
//
//  Created by Rojaramani on 16/01/13.
//  Copyright (c) 2013 Photon. All rights reserved.
//

#import "ProductResultViewCell.h"
#import "Constants.h"
#import "ThemeReader.h"

@implementation ProductResultViewCell
@synthesize productImage;
@synthesize productName;
@synthesize productPrice;
@synthesize priceLabel;
@synthesize reviewsButton;
@synthesize dollarSign;
@synthesize ratingsView;
@synthesize imageFramesArray;
@synthesize isSelected;
@synthesize disImage;
@synthesize productCountLabel;
@synthesize countImage;
@synthesize productResultDefaultDict;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSDictionary* defaultColorDict = [NSDictionary dictionaryWithObjectsAndKeys:@"29.0",kredColor,@"106.0",kgreenColor,@"150.0",kblueColor,@"1.0",kalpha,
                                          nil];
        NSString* defaultFont = @"Times New Roman";
        NSString* defaultiPhoneFontSize = @"12";
        NSString* defaultiPadFontSize = @"17";
        productResultDefaultDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:defaultColorDict,kbgColor,defaultFont,ktextFont,defaultiPhoneFontSize,kIphoneFontSize,defaultiPadFontSize, kIpadFontSize, nil];
        
        NSString* Font = nil;
        NSString* fontSize = nil;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            fontSize = [self getObjectForKey:kIpadFontSize];
            Font= [self getObjectForKey:ktextFont];
        }
        else {
            fontSize =  [self getObjectForKey:kIphoneFontSize];
            Font = [self getObjectForKey:ktextFont];
        }
       
        /*IF the FontName is empty*/
        if([Font isEqualToString:@""]) { 
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                Font = [self getObjectForKey:ktextFont];
            }
            else {
                Font = [self getObjectForKey:ktextFont];
            }
        }
        /*IF the FontSize is empty*/
        if([fontSize isEqualToString:@""]) {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                fontSize = [self getObjectForKey:kIpadFontSize];
            }
            else {
                fontSize =  [self getObjectForKey:kIphoneFontSize];
            }
        }
        productName = [[UILabel alloc] init];
        productName.backgroundColor = [UIColor clearColor];
        productName.font = [UIFont fontWithName:Font size:[fontSize floatValue]];
        productName.numberOfLines = 2;
        productName.textColor = [UIColor whiteColor];
        
        priceLabel = [[UILabel alloc] init];
        [priceLabel setFont:[UIFont fontWithName:Font size:[fontSize floatValue]]];
        [priceLabel setText:@"Price :"];
        priceLabel.textColor = [UIColor blackColor];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        
        dollarSign = [[UILabel alloc] init];
        [dollarSign setFont:[UIFont fontWithName:Font size:[fontSize floatValue]]];
        dollarSign.textColor = [UIColor yellowColor];
        [dollarSign setBackgroundColor:[UIColor clearColor]];
        
        productPrice = [[UILabel alloc] init];
        [productPrice setFont:[UIFont fontWithName:Font size:[fontSize floatValue]]];
        productPrice.backgroundColor = [UIColor clearColor];
        productPrice.textColor = [UIColor yellowColor];
        
        productCountLabel = [[UILabel alloc] init];
        [productCountLabel setFont:[UIFont fontWithName:Font size:[fontSize floatValue]]];
         productCountLabel.backgroundColor = [UIColor clearColor];
        [productCountLabel setTextColor:[UIColor whiteColor]];

        countImage = [[UIImageView alloc] init];
        [countImage setBackgroundColor:[UIColor clearColor]];
        
        disImage = [[UIImageView alloc] init];
        [disImage setBackgroundColor:[UIColor clearColor]];

        reviewsButton = [[UIButton alloc] init];
        [reviewsButton setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
        
        [self addSubview:productCountLabel];
        [self addSubview:productName];
        [self addSubview:productImage];
        [self addSubview:productPrice];
        [self addSubview:priceLabel];
        [self addSubview:dollarSign];
        [self addSubview:countImage];
        [self bringSubviewToFront:productCountLabel];
        [self addSubview:disImage];
        [self addSubview:reviewsButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}
-(NSString*)getObjectForKey:(NSString*)navigationKey{
    if(navigationKey != nil &&[navigationKey length]>0){
        ThemeReader *themeReader =[[ThemeReader alloc]init];
        NSMutableDictionary *navigationDict = nil;
        navigationDict = [themeReader loadDataFromManifestPlist:kproductResults];
        
        if(nil != navigationDict && [navigationDict count] >0)  //Get data from manifest plist
        {
            NSString* object=[navigationDict objectForKey:navigationKey];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else  //feature
            {
                navigationDict = [themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:kproductResults];
                if(nil != navigationDict && [navigationDict count] > 0)
                {
                    NSString *object = [navigationDict objectForKey:navigationKey];

                    if(nil != object && [object length] > 0)
                    {
                        return object;
                    }
                    else
                    {
                        return [productResultDefaultDict objectForKey:navigationKey];
                    }
                }
                
            }
        }
        else
        {
            NSMutableDictionary *navigationViewDict=[themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:kproductResults];
            if(nil != navigationViewDict && [navigationViewDict count] > 0)
            {
                NSString *object = [navigationViewDict objectForKey:navigationKey];
                NSLog(@"3 NavigationKey %@ Object %@", navigationKey, object);

                if(nil != object && [object length] > 0)
                {
                    return object;
                }
                else
                {
                    return [productResultDefaultDict objectForKey:navigationKey];
                }
            }
        }
        return [productResultDefaultDict objectForKey:navigationKey];
        
    }
    return nil;
}

@end
