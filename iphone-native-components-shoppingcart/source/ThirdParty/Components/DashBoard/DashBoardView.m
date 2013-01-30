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
 
    ThemeReader  *themeReader = [[ThemeReader alloc]init];
   
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
    
    NSArray* imagesArray =  [self getArrayImageName:key];
    UIImage *image = nil;
    NSString* path = [imagesArray objectAtIndex:0];
    if(nil != path && [path length] >0)
    {
        image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
    }
    else
    {
        image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_icon" ofType:@"png"]];

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
    bgView.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagePath ofType:@"png"]];
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
        //button.titleLabel.text = [titlesArray objectAtIndex:i];
        NSString* path = [imagesArray objectAtIndex:i];
        UIImage *image = nil;
        if(nil != path && [path length] > 0)
        {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]];
        }
        else
        {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_icon" ofType:@"png"]];
        }
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

-(NSString*)getObjectForKey:(NSString*)key{
    if(key != nil &&[key length]>0){
        ThemeReader *themeReader =[[ThemeReader alloc]init];
        NSMutableDictionary *navigationDict = nil;
        navigationDict = [themeReader loadDataFromManifestPlist:@"DashBoard"];
        if(nil != navigationDict && [navigationDict count] >0)  //Get data from manifest plist
        {
            NSString* object=[navigationDict objectForKey:key];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else  //feature
            {
                navigationDict = [themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
                if(nil != navigationDict && [navigationDict count] > 0)
                {
                    NSString *object = [navigationDict objectForKey:key];
                    if(nil != object && [object length] > 0)
                    {
                        return object;
                    }
                    else
                    {
                        //return [navigationDefaultsDict objectForKey:navigationKey];
                    }
                }
                
            }
        }
        else
        {
            NSMutableDictionary *navigationViewDict=[themeReader loadDataFromComponentPlist:key INCOMPONENT:@"DashBoard"];
            if(nil != navigationViewDict && [navigationViewDict count] > 0)
            {
                NSString *object = [navigationViewDict objectForKey:key];
                if(nil != object && [object length] > 0)
                {
                    return object;
                }
                else
                {
                    //return [navigationDefaultsDict objectForKey:navigationKey];
                }
            }
            
            
        }
        //return [navigationDefaultsDict objectForKey:navigationKey];
        
    }
    return nil;
}

-(NSArray*) getArrayImageName:(NSString*) key
{
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
                                //load from defaults
                            }
                        }
                        else
                        {
                            //load from defaults
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
                        //load from defaults
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
                    //load from defaults
                }
            }
        }
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
                        //load from constants
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
                    //load from constants
                }
            }
            else
            {
                //load from defaults
            }
        }
    }
    return nil;
}

@end
