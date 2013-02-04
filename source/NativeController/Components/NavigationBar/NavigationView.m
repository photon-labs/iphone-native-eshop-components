   //
//  NavigationView.m
//  NavigationBar
//
//  Created by Nagarajan on 1/19/13.
//  Copyright (c) 2013 Nagarajan. All rights reserved.
//

#import "NavigationView.h"
#import "ThemeReader.h"
#import "Constants.h"



@implementation NavigationView
@synthesize navigationDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        navigationDelegate = nil;
        navigationDefaultsDict = nil;
    }
    return self;
}

-(void)loadNavbar:(BOOL)isBackNeeded :(BOOL)isForwardNeeded
{
 navigationDefaultsDict =[NSDictionary dictionaryWithObjectsAndKeys:@"",kDefaultRightButtonIpad,@"back_btn-72",kDefaultLeftButtonIpad,@"header_logo-72",kDefaultBackgroundImageIpad,@"",kDefaultRightButtonIphone,@"back_btn",kDefaultLeftButtonIphone,@"header_logo",kDefaultBackgroundImageIphone, nil];
        NSString *backgroundImage = nil;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            backgroundImage = [self getObjectForKey:@"backgroundImage_iphone"];
        }
        else
        {
            backgroundImage = [self getObjectForKey:@"backgroundImage_ipad"];
        }
        if(nil != backgroundImage && [backgroundImage length] > 0)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
            UIImage *bgImage = [UIImage imageNamed:backgroundImage];
            imageView.image = bgImage;
            [self addSubview:imageView];
        }

        if(isBackNeeded)
        {
            NSString *leftBarButton = nil;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                leftBarButton = [self getObjectForKey:@"leftBarButton_iphone"];
            }
            else
            {
                leftBarButton = [self getObjectForKey:@"leftBarButton_ipad"];
            }
            if(leftBarButton != nil && [leftBarButton length] > 0)
            {
                UIButton *button = [[UIButton alloc] init];
                UIImage *leftImage = [UIImage imageNamed:leftBarButton];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                    
                    button.frame = CGRectMake(self.frame.origin.x + 5, self.frame.origin.y + 5, leftImage.size.width, leftImage.size.height);
                }
                else
                {
                    button.frame = CGRectMake(self.frame.origin.x + 10, self.frame.origin.y + 7.5, leftImage.size.width, leftImage.size.height);
                }
                [button addTarget:self action:@selector(leftNavigationBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:leftImage forState:UIControlStateNormal];
                [self addSubview:button];
            }
        }
    if(isForwardNeeded)
        {
            NSString *rightBarButton = nil;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
            rightBarButton=[self getObjectForKey:@"rightBarButton_iphone"];
            }
            else
            {
                rightBarButton=[self getObjectForKey:@"rightBarButton_ipad"];
            }
            if(rightBarButton !=nil && [rightBarButton length]>0)
            {
                UIButton *button =[[UIButton alloc]init];
                UIImage *rightImage =[UIImage imageNamed:rightBarButton];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                button.frame =CGRectMake([UIScreen mainScreen].bounds.size.width - (rightImage.size.width +5),self.frame.origin.y + 5, rightImage.size.width, rightImage.size.height);
                }
                else
                {
                    button.frame =CGRectMake([UIScreen mainScreen].bounds.size.width - (rightImage.size.width +10),self.frame.origin.y + 7.5, rightImage.size.width, rightImage.size.height);
                }
                [button addTarget:self action:@selector(rightNavigationBarButtonPressed)forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:rightImage forState:UIControlStateNormal];
                [self addSubview:button];
            }
        }
    }
        



-(void) leftNavigationBarButtonPressed
{
    if(nil != navigationDelegate && [navigationDelegate respondsToSelector:@selector(backButtonAction)])
    {
        [navigationDelegate backButtonAction];
    }
}
-(void)rightNavigationBarButtonPressed
{
    
}

-(NSString*)getObjectForKey:(NSString*)navigationKey{
    if(navigationKey != nil &&[navigationKey length]>0){
        ThemeReader *themeReader =[[ThemeReader alloc]init];
        NSMutableDictionary *navigationDict = nil;
        navigationDict = [themeReader loadDataFromManifestPlist:@"NavigationBar"];
        if(nil != navigationDict && [navigationDict count] >0)  //Get data from manifest plist
        {
            NSString* object=[navigationDict objectForKey:navigationKey];
            if(nil != object && [object length] > 0)
            {
                return object;
            }
            else  //feature
            {
                navigationDict = [themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:@"NavigationBar"];
                if(nil != navigationDict && [navigationDict count] > 0)
                {
                    NSString *object = [navigationDict objectForKey:navigationKey];
                    if(nil != object && [object length] > 0)
                    {
                        return object;
                    }
                    else
                    {
                        return [navigationDefaultsDict objectForKey:navigationKey];
                    }
                }
                
            }
        }
        else 
        {
            NSMutableDictionary *navigationViewDict=[themeReader loadDataFromComponentPlist:navigationKey INCOMPONENT:@"NavigationBar"];
            if(nil != navigationViewDict && [navigationViewDict count] > 0)
            {
                NSString *object = [navigationViewDict objectForKey:navigationKey];
                if(nil != object && [object length] > 0)
                {
                    return object;
                }
                else
                {
                    return [navigationDefaultsDict objectForKey:navigationKey];
                }
            }
            
            
        }
        return [navigationDefaultsDict objectForKey:navigationKey];

    }
    return nil;
}
@end
