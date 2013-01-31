

#import <Foundation/Foundation.h>

@class AssetsDataEntity;
@class AppInfoEntity;
@class UserProfileEntity;

@interface SharedObjects : NSObject {
	
//	__weak AssetsDataEntity *assetsDataEntity;
//	
//	__weak AppInfoEntity *appInfoEntity;
//	
//	__weak UserProfileEntity *userProfileData;

    
     AssetsDataEntity *assetsDataEntity;
	
	 AppInfoEntity *appInfoEntity;
	
	 UserProfileEntity *userProfileData;

    
}

@property (nonatomic) AssetsDataEntity *assetsDataEntity;

@property (nonatomic) AppInfoEntity *appInfoEntity;

@property (nonatomic) UserProfileEntity *userProfileData;

#pragma mark singleton object methods 

+ (SharedObjects *)sharedInstance;

@end
