//
//  NavigationView.m
//  NavigationBar
//
//  Created by Nagarajan on 1/19/13.
//  Copyright (c) 2013 Nagarajan. All rights reserved.
//

#import "NavigationView.h"
#import "ThemeReader.h"

@implementation NavigationView
@synthesize navigationDelegate;

- (id)init
{
    self = [super init];
    if (self) {
        navigationDelegate = nil;
    }
    return self;
}

-(void)loadNavbar:(BOOL)isBackNeeded :(BOOL)isForwardNeeded
{
    ThemeReader *themeReader = [[ThemeReader alloc] init];
    
    NSMutableDictionary *dict = [themeReader loadDataFromPlist:@"NavigationBar"];
    if(dict != nil && [dict count] > 0)
    {
        NSString *backgroundImage = nil;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            backgroundImage = [dict objectForKey:@"backgroundImage_iphone"];
        }
        else
        {
            backgroundImage = [dict objectForKey:@"backgroundImage_ipad"];
        }
        if(nil != backgroundImage && [backgroundImage length] > 0)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:backgroundImage ofType:@"png"];
            UIImage *bgImage = [UIImage imageWithContentsOfFile:filePath];
            imageView.image = bgImage;
            [self addSubview:imageView];
        }

        if(isBackNeeded)
        {
            NSString *leftBarButton = nil;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                leftBarButton = [dict objectForKey:@"leftBarButton_iphone"];
            }
            else
            {
                leftBarButton = [dict objectForKey:@"leftBarButton_ipad"];
            }
            if(leftBarButton != nil && [leftBarButton length] > 0)
            {
                UIButton *button = [[UIButton alloc] init];
                NSString *filePath = [[NSBundle mainBundle] pathForResource:leftBarButton ofType:@"png"];
                UIImage *leftImage = [UIImage imageWithContentsOfFile:filePath];
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
            rightBarButton=[dict objectForKey:@"rightBarButton_iphone"];
            }
            else
            {
                rightBarButton=[dict objectForKey:@"rightBarButton_ipad"];
            }
            if(rightBarButton !=nil && [rightBarButton length]>0)
            {
                UIButton *button =[[UIButton alloc]init];
                NSString *filePath =[[NSBundle mainBundle]pathForResource:rightBarButton ofType:@"png"];
                UIImage *rightImage =[UIImage imageWithContentsOfFile:filePath];
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
@end
