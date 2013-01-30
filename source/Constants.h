/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
/*
 *  Constants.h
 *
 *  Created by Shashi Kumar on 11/1/10.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

/****************************************************************/



#define kAssetsConfigURL PHRESCO_QA_ENV



/////////////////////////////App Notifications////////////////////////

///////Assets Notifications/////////

#define kAllAssetsDownloadedNotification    @"AllAssetsDownloadedNotification"
#define kAddIconsInTabbarNotification		@"kAddIconsInTabbarNotification"
#define kExtraAssetsDownloadedNotification  @"ExtraAssetsDownloadedNotification"

#define kAppInfo							@"AppInfo"
#define kFeatureLayout						@"FeatureLayout"
#define kFeatureAssets						@"FeatureAssets"
#define kConfigDict							@"ConfigDict"
#define kSupportedVersions					@"SupportedVersions"
#define kVersionUpdateURL					@"VersionUpdateURL"
#define kConfigVersion						@"ConfigVersion"
#define kAppVersion							@"AppVersion"
#define kExtraAssets						@"ExtraAssets"

#define kLocationAwareness                  @"LocationAwareness"
#define kPushNotification                   @"PushNotification"
#define kAutoLogin                          @"AutoLogin"
#define kSavedUserName                      @"SavedUserName"
#define kSavedUserPassword                  @"SavedUserPassword"

#define kTabbarTagOffset                    110
#define kMorePageTagOffset                  210


#define kConfigFile                         @"ConfigFile"

#define kwebserviceprotocol                 @"protocol"
#define kwebservicehost                     @"host"
#define kwebserviceport                     @"port"
#define kwebservicecontext                  @"context"

#define kRestApi                            @"rest/api"
#define kpost                               @"post"
#define kRegister                           @"register"
#define kConfigService                      @"config"
#define kCatalogService                     @"categories"
#define kCategory                           @"category"
#define kProductService                     @"products"
#define kProductItem                        @"productItem"
#define kSpecialproducts                    @"specialproducts"
//Network detection
#define kErrorMessageNoNetwork              @"No network connection found, please try again later."

#define kEmailAddress                       873
#define kPassword                           934

#define	kColorClear							[UIColor clearColor]
#define kColorWhiteColor					[UIColor whiteColor]
#define kColorBlue							[UIColor blueColor];
#define kFontHelvetica						[UIFont fontWithName:@"Helvetica" size:12];
#define kFontHelveticaBold					[UIFont fontWithName:@"Helvetica-Bold" size:13];
#define kFontHelveticaSmallBold				[UIFont fontWithName:@"Helvetica-Bold" size:12];
#define kFontHelveticaBoldBigger			[UIFont fontWithName:@"Helvetica-Bold" size:17.0]

#define kProductDescription					@"Discount VIZIO M370NV 32 inch LED LCD HDTV online sale in USA. Cheap deals and low prices VIZIO M370NV 32 INCH LED LCD. HDTV. Get discount now. Limited in stock. Free and Fast shipping"

#define kfirstname                          @"firstName"
#define klastname                           @"lastName"
#define kcompany                            @"company"
#define kaddress1                           @"address1"
#define kaddress2                           @"address2"
#define kstate                              @"state"
#define kcountry                            @"country"
#define kzip                                @"postcode"
#define kphone                              @"phonenumber"

#define SCREENWIDTH [UIScreen mainScreen].applicationFrame.size.width
#define SCREENHEIGHT [UIScreen mainScreen].applicationFrame.size.height


#define emailLabelTag                       3453
#define passwordLabelTag                    9454

#define cancelButtonTag                     233

#define emailTextFieldTag                   123
#define passwordTextFieldTag                198


#define emailTag                            345
#define passwordTag                         867


///Dashboard macros
#define kbgImage                       @"backgroundImage"
#define kfontSize                      @"fontSize"
#define kiPhoneButtonImages            @"iPhoneHomeButtonImages"
#define kiPadButtonImages              @"iPadHomeButtonImages"
#define kbuttonTitle                   @"buttonTitle"
#define kdashBoard                     @"DashBoard"
#define kbrowse                        @"browse"
#define kspecial                       @"special"
#define klogin                         @"login"
#define kregister                      @"register"
#define kipadHomeBgImage               @"homeBg"
#define khomePageIcons                 @"imagesArray"
#define khomeButtonTitles              @"titleLabelArray"




#define kDefaultPassdCaption           @"Password"
#define kDefaultPasswordCaption        @"password"
#define kDefaultEmailCaption           @"Email address"
#define kDefaultEmailAddressCaption    @"emailaddress"
#define kDefaultBgImage                @"login_bg"
#define kDefaultBackgroundImage        @"backgroundImage"
#define kDefaultHdImage                @"login_header"
#define kDefaultHeaderImage            @"header"
#define kDefaultLgImage                @"login_btn"
#define kDefaultLoginImage             @"loginImage"
#define kDefaultClImage                @"cancel_btn"
#define kDefaultCancelImage            @"cancelImage"
#define kDefaultFont                   @"Helvetica-Bold"
#define kDefaultFontType               @"font"

#define kDefaultRightBarButtonIpad     @""
#define kDefaultRightButtonIpad        @"rightBarButton_ipad"
#define kDefaultLeftBarButtonIpad      @"back_btn-72"
#define kDefaultLeftButtonIpad         @"leftBarButton_ipad"
#define kDefaultBgImageIpad            @"header_logo-72"
#define kDefaultBackgroundImageIpad    @"backgroundImage_ipad"
#define kDefaultRightBarButtonIphone   @""
#define kDefaultRightButtonIphone      @"rightBarButton_iphone"
#define kDefaultLeftBarButtonIphone    @"back_btn"
#define kDefaultLeftButtonIphone       @"leftBarButton_iphone"
#define kDefaultBgImageIphone          @"header_logo"
#define kDefaultBackgroundImageIphone  @"backgroundImage_iphone"
