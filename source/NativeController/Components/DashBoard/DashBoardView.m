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
#define iPhoneXpos 45
#define iPhoneYpos 20
#define iPhoneImageWidth 120
#define iPhoneImageheight 120
#define iPadImageWidth 300
#define iPadImageheight 250

- (id)init
{
    self = [super init];
    if(self) {
        delegate = nil;
        dashBoardDefaultsArray= nil;
        dashBoardViewDefaultsArray=nil;
        dashBoardDefaultString =nil;
        defaultPadding=nil;
        defaultPaddingvalue=nil;
    }
    return self;
}

- (void)loadComponents {
    defaultPadding= @"80";
    defaultPaddingvalue= @"40";
    
    dashBoardViewDefaultsArray = [[NSArray alloc] initWithObjects:@"Browse",@"SpecialOffer",@"Login",@"Register", nil];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        float xCoord = self.frame.origin.x + iPadXpos;
        float yCoord  = self.frame.origin.y + iPadYpos;
        
        dashBoardDefaultsArray =[[NSArray alloc] initWithObjects:@"browse_icon.png-72",@"specialoffer_icon.png-72",@"login_icon.png-72",@"register_icon.png-72", nil];
        dashBoardDefaultString=[[NSString alloc]init];
        dashBoardDefaultString =@"icons_bg.png";
        [self xCoordinate:xCoord yCoordinate:yCoord  device:kiPadButtonImages bgImage:kipadHomeBgImage];
    }
    else
    {
        float xCoord = self.frame.origin.x + iPhoneXpos;
        float yCoord  = self.frame.origin.y + iPhoneYpos;
        dashBoardDefaultsArray =[[NSArray alloc] initWithObjects:@"browse_icon.png",@"specialoffer_icon.png",@"login_icon.png",@"register_icon.png", nil];
        dashBoardDefaultString=[[NSString alloc]init];
        dashBoardDefaultString =@"icons_bg-72.png";
        
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
    
    NSArray* imagesArray =  [self getArrayImageName:key];
    
    UIImage *image = nil;
    NSString* path = [imagesArray objectAtIndex:0];
    if(nil != path && [path length] >0)
    {
        image = [UIImage imageNamed:path];
    }
    else
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            image = [UIImage imageNamed:@"login_icon-72.png"];
        }
        else
        {
            image = [UIImage imageNamed:@"login_icon.png"];
        }
    }
    float width = 0.0;
    float height = 0.0;
    if(nil != image)
    {
        width = image.size.width; //home icon image width
        height = image.size.height;
    }
    bgView = [[UIImageView alloc] init]; //homepage icon background view
    self.bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    NSString* imagePath = [self getBackgroundImageForKey:key];
    bgView.image =  [UIImage imageNamed:imagePath];
    [bgView setUserInteractionEnabled:YES];
    bgView.frame = self.frame;
    [self addSubview:bgView];
    NSString *paddingValue=[[NSString alloc] init];
    float paddingFloatvalue=0.0;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSString *padding = [self getPadding:@"padding_ipad"];
        paddingValue = padding;
        
        
    }
    else
    {
        NSString *padding = [self getPadding:@"padding_iphone"];
        paddingValue = padding;
    }
    
    paddingFloatvalue = [paddingValue floatValue];
    for(int i = 0; i< [imagesArray count]; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        [button setFrame:CGRectMake(x, y, width, height)];
        NSLog(@"bgvi:%f",bgView.image.size.width);
        if((x+button.frame.size.width)<=bgView.image.size.width)
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                x=x+button.frame.size.width+paddingFloatvalue;
            }
            else
            {
                x=x+button.frame.size.width+paddingFloatvalue;
            }
            
        }
        else
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                x=self.frame.origin.x+iPadXpos;
                y=y+button.frame.size.height+paddingFloatvalue;
            }
            else
            {
                x=self.frame.origin.x+iPhoneXpos;
                y=y+button.frame.size.height+paddingFloatvalue;
            }
            if((x+button.frame.size.width)<=bgView.image.size.width)
            {
                [button setFrame:CGRectMake(x, y, width, height)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    x=x+button.frame.size.width+paddingFloatvalue;
                }
                else
                {
                    x=x+button.frame.size.width+paddingFloatvalue;
                }
            }
        }
        NSArray *titleArray = [self getTitleLabels:@"titleLabel"];
        if(i<[titleArray count])
        {
            button.titleLabel.text = [titleArray objectAtIndex:i];
        }
        NSString* path = [imagesArray objectAtIndex:i];
        UIImage *image = nil;
        if(nil != path && [path length] > 0)
        {
            image = [UIImage imageNamed:path];
        }
        else
        {
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                image = [UIImage imageNamed:@"login_icon-72.png"];
            }
            else
            {
                image = [UIImage imageNamed:@"login_icon.png"];
            }
            
        }
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView  addSubview:button];
    }
}
- (void)homeButtonAction:(id)sender {
    UIButton *button = (UIButton*) sender;
    if((delegate != nil) && [delegate respondsToSelector:@selector(callViewController:)]) {
        [delegate callViewController:button];
    }
}

-(NSArray*) getArrayImageName:(NSString*) key{
    if(key != nil && [key length] > 0)
    {
        ThemeReader *themeReader = [[ThemeReader alloc] init];
        NSMutableDictionary *dashboardDict = nil;
        dashboardDict = [themeReader loadDataFromManifestPlist:@"DashBoard"];
        if(nil != dashboardDict && [dashboardDict count] >0)  //Get data from manifest plist
        {
            NSDictionary *dict = [dashboardDict objectForKey:key];
            if(nil != dict && [dict count] > 0)
            {
                NSArray *imageArray = [dict objectForKey:@"imagesArray"];
                if(nil != imageArray && [imageArray count] > 0)
                {
                    return imageArray;
                }
                else
                {
                    dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                    if(nil != dashboardDict && [dashboardDict count] > 0)
                    {
                        NSDictionary *dict = [dashboardDict objectForKey:key];
                        if(nil != dict && [dict count] > 0)
                        {
                            NSArray *imageArray = [dict objectForKey:@"imagesArray"];
                            if(nil != imageArray && [imageArray count] > 0)
                            {
                                return imageArray;
                            }
                            else
                            {
                                return dashBoardDefaultsArray;
                            }
                        }
                        else
                        {
                            return dashBoardDefaultsArray;
                        }
                    }
                }
            }
            else
            {
                dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                if(nil != dashboardDict && [dashboardDict count] > 0)
                {
                    NSDictionary *dict = [dashboardDict objectForKey:key];
                    if(nil != dict && [dict count] > 0)
                    {
                        NSArray *imageArray = [dict objectForKey:@"imagesArray"];
                        if(nil != imageArray && [imageArray count] > 0)
                        {
                            return imageArray;
                        }
                    }
                    else
                    {
                        return dashBoardDefaultsArray;
                    }
                }
            }
        }
        else
        {
            dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
            if(nil != dashboardDict && [dashboardDict count] > 0)
            {
                NSDictionary *dict = [dashboardDict objectForKey:key];
                if(nil != dict && [dict count] > 0)
                {
                    NSArray *imageArray = [dict objectForKey:@"imagesArray"];
                    if(nil != imageArray && [imageArray count] > 0)
                    {
                        return imageArray;
                    }
                }
                else
                {
                    return dashBoardDefaultsArray;
                }
            }
        }
        return dashBoardDefaultsArray;
    }
    return nil;
}

-(NSString*) getBackgroundImageForKey:(NSString*) key
{
    if(nil != key && [key length] > 0)
    {
        ThemeReader *themeReader = [[ThemeReader alloc] init];
        NSMutableDictionary *dashboardDict = nil;
        dashboardDict = [themeReader loadDataFromManifestPlist:@"DashBoard"];
        if(nil != dashboardDict && [dashboardDict count] >0)  //Get data from manifest plist
        {
            NSString *object = [[dashboardDict objectForKey:key] objectForKey:@"homeBg"];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else
            {
                dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                if(nil != dashboardDict && [dashboardDict count] > 0)
                {
                    NSString *object = [[dashboardDict objectForKey:key] objectForKey:@"homeBg"];
                    if(nil != object && [object length] >0)
                    {
                        return object;
                    }
                    else
                    {
                        return dashBoardDefaultString;
                    }
                }
            }
        }
        else
        {
            dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
            if(nil != dashboardDict && [dashboardDict count] > 0)
            {
                NSString *object = [[dashboardDict objectForKey:key] objectForKey:@"homeBg"];
                if(nil != object && [object length] >0)
                {
                    return object;
                }
                else
                {
                    return dashBoardDefaultString;
                }
            }
            else
            {
                return dashBoardDefaultString;
                
            }
        }
        return dashBoardDefaultString;
    }
    return nil;
}

-(NSArray*) getTitleLabels:(NSString*) key
{
    if(nil != key && [key length] >0)
    {
        ThemeReader *themeReader = [[ThemeReader alloc] init];
        NSMutableDictionary *dashboardDict = nil;
        dashboardDict = [themeReader loadDataFromManifestPlist:@"DashBoard"];
        if(nil != dashboardDict && [dashboardDict count] > 0)
        {
            NSArray *array = [dashboardDict objectForKey:key];
            if(nil != array && [array count] >0)
            {
                return array;
            }
            else
            {
                dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                if(nil != dashboardDict && [dashboardDict count] > 0)
                {
                    NSArray *array = [dashboardDict objectForKey:key];
                    if(nil != array && [array count] >0)
                    {
                        return array;
                    }
                    else
                    {
                        return dashBoardViewDefaultsArray ;
                    }
                }
                else
                {
                    return dashBoardViewDefaultsArray ;
                }
            }
        }
        else
        {
            dashboardDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
            if(nil != dashboardDict && [dashboardDict count] > 0)
            {
                NSArray *array = [dashboardDict objectForKey:key];
                if(nil != array && [array count] >0)
                {
                    return array;
                }
                else
                {
                    return dashBoardViewDefaultsArray ;
                }
            }
            else
            {
                return dashBoardViewDefaultsArray ;
            }
        }
        return dashBoardViewDefaultsArray ;
    }
    return nil;
}
-(NSString*)getPadding:(NSString*)key{
    if(nil != key && [key length] >0)
    {
        ThemeReader *themeReader = [[ThemeReader alloc] init];
        NSMutableDictionary *dashboardDict = nil;
        dashboardDict = [themeReader loadDataFromManifestPlist:@"DashBoard"];
        if(nil != dashboardDict && [dashboardDict count] > 0)
        {
            
            NSString* padding=[dashboardDict objectForKey:key];
            if(padding !=nil && [padding length]>0)
            {
                return padding;
            }
            else
            {
                dashboardDict=[themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                if(nil !=dashboardDict && [dashboardDict count]>0)
                {
                    NSString* padding=[dashboardDict objectForKey:key];
                    if(padding !=nil && [padding length]>0)
                    {
                        return padding;
                    }
                    else
                    {
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        {
                            return defaultPadding;
                        }
                        else
                        {
                            return defaultPaddingvalue;
                        }
                        
                    }
                }
                else
                {
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    {
                        return defaultPadding;
                    }
                    else
                    {
                        return defaultPaddingvalue;
                        
                    }
                    
                }
                
            }
        }
        else
        {
            dashboardDict=[themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
            if(nil !=dashboardDict && [dashboardDict count]>0)
            {
                NSString* padding=[dashboardDict objectForKey:key];
                if(padding !=nil && [padding length]>0)
                {
                    return padding;
                }
                else
                {
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    {
                        return defaultPadding;
                    }
                    else
                    {
                        return defaultPaddingvalue;
                    }
                    
                }
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    return defaultPadding;
                }
                else
                {
                    return defaultPaddingvalue;
                }
                
            }
            
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            return defaultPadding;
        }
        else
        {
            return defaultPaddingvalue;
        }
        
    }
    return nil;
    
}
@end
