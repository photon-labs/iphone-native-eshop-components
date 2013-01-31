//
//  SharedObjects.m
//  iShop3.0
//
//  Created by Admin on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SharedObjects.h"
#import "DataModelEntities.h"

static SharedObjects *shardObjectsDelegate = nil;

@implementation SharedObjects

@synthesize assetsDataEntity;
@synthesize appInfoEntity;
@synthesize userProfileData;

- (id) init {
	self = [super init];	
	
    if(self != nil) {
        self.assetsDataEntity = [[AssetsDataEntity alloc] init];
	
        self.appInfoEntity = [[AppInfoEntity alloc] init];
	
        self.userProfileData = [[UserProfileEntity alloc] init];
    }

	return self;
}


#pragma mark --
#pragma mark singleton object methods 
#pragma mark --

+ (SharedObjects *)sharedInstance {
    @synchronized(self) {
        if (shardObjectsDelegate == nil) 
		{
			shardObjectsDelegate= [[self alloc] init]; // assignment not done here
        }
    }
	
    return shardObjectsDelegate;
}


@end
