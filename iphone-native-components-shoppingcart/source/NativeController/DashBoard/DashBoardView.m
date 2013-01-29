//
//  ViewController.m
//  DashBoardComponent
//
//  Created by Rojaramani on 22/01/13.
//  Copyright (c) 2013 Photon. All rights reserved.
//

#import "DashBoardView.h"
#import "Constants.h"
#import "ThemeReader.h"

@implementation DashBoardView
@synthesize bgView;
@synthesize delegate;

#define iPadXpos 100
#define iPadYpos 80
#define iPhoneXpos 60
#define iPhoneYpos 40
#define iPhoneImageWidth 120
#define iPhoneImageheight 120
#define iPadImageWidth 300
#define iPadImageheight 250

- (id)init
{
    self = [super init];
    if(self) {
        delegate = nil;
   }
    return self;
}

- (void)loadComponents {
 
    themeReader = [[ThemeReader alloc]init];
   
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        float xCoord = self.frame.origin.x + iPadXpos;
        float yCoord  = self.frame.origin.y + iPadYpos;
        [self xCoordinate:xCoord yCoordinate:yCoord  device:kiPadButtonImages bgImage:kipadHomeBgImage];
        
        }
    else
    {
        float xCoord = self.frame.origin.x + iPhoneXpos;
        float yCoord  = self.frame.origin.y + iPhoneYpos;
        [self xCoordinate:xCoord yCoordinate:yCoord  device:kiPhoneButtonImages bgImage:kipadHomeBgImage];
        
    }
}

- (BOOL) gotoNextRow:(int) num
{
    BOOL isOdd = NO;
    if(num % 2 != 0)
    {
        isOdd = YES;
    }
    else
    {
        isOdd = NO;
    }
    return isOdd;
}

- (void)xCoordinate:(float)x yCoordinate:(float)y  device:(NSString*)key bgImage:(NSString*)img {
    
    NSMutableDictionary *dict = [themeReader loadDataFromManifestPlist:kdashBoard];
    NSDictionary *buttonImagesArray = [dict objectForKey:key];
    NSArray* imagesArray = [buttonImagesArray objectForKey:khomePageIcons]; //khomeButtonTitles
    NSArray* titlesArray = [dict objectForKey:khomeButtonTitles];
    NSString* path = [imagesArray objectAtIndex:0];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
    
    float width = image.size.width; //home icon image width
    float height = image.size.height;
    
    bgView = [[UIImageView alloc] init]; //homepage icon background view
    self.bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    NSString* imagePath = [buttonImagesArray objectForKey:img];
    bgView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagePath ofType:@"png"]];
    [bgView setUserInteractionEnabled:YES];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        bgView.frame = self.frame;
    }
    else {
        
        bgView.frame = self.frame;
    }
    [self addSubview:bgView];
    
    for(int i = 0; i< [imagesArray count]; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        [button setFrame:CGRectMake(x, y, width, height)];
        button.titleLabel.text = [titlesArray objectAtIndex:i];
        NSString* path = [imagesArray objectAtIndex:i];
        UIImage* image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView  addSubview:button];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            x = x + iPadImageWidth;
            if([self gotoNextRow:i])
            {
                y = y + iPadImageheight;
                x = iPadXpos;
            }
        }
        else {
        
               x = x + iPhoneImageWidth;
            if([self gotoNextRow:i])
            {
                y = y + iPhoneImageheight;
                x = iPhoneXpos;
            }
        }
    }
}

- (void)homeButtonAction:(id)sender {
    UIButton *button = (UIButton*) sender;
    if((delegate != nil) && [delegate respondsToSelector:@selector(callViewController:)]) {
     [delegate callViewController:button];
    }
}

@end
