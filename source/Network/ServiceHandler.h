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
//
//  PDPServiceHandler.h
//  iShop2.0
//
//  Created by PHOTON on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServiceHandler : NSObject {

	NSString *coremetricsURLString;
    
    NSString *strId;
    NSString *prodId;
    NSString *productName;
    
    NSMutableString *loginId;
    NSMutableString *pwd;
    
    NSMutableString *firstName;
    NSMutableString *lastName;
    NSMutableString *emailAddress;
    NSMutableString *password;
    NSMutableString *confirmPassword;
    NSMutableString *phoneNumber;
    NSDictionary* loginDict;
  
    //To post the review comment
    NSString *commentProductId;
    NSMutableString *commentUserId;
    NSMutableString *commentRating;
    NSMutableString *commentComment;
    NSMutableString *commentDate;
    NSMutableString *commentUserName;
    
    NSString *loginUserId;
    NSString *loginUserName;
    
@private
	__weak id callBackTarget;
        SEL callBackSelector;	
	
}

@property  (weak) id callBackTarget;
@property (assign) SEL callBackSelector;

@property(nonatomic,strong)  NSString *strId;
@property(nonatomic,strong)  NSString *prodId;
@property(nonatomic,strong)  NSString *productName;

@property(nonatomic,strong)  NSMutableString  *loginId;
@property(nonatomic,strong)  NSMutableString *pwd;
@property(nonatomic,strong)  NSMutableString *firstName;
@property(nonatomic,strong)  NSMutableString *lastName;
@property(nonatomic,strong)  NSMutableString *confirmPassword;
@property(nonatomic,strong)  NSMutableString *emailAddress;
@property(nonatomic,strong)  NSMutableString *password;
@property(nonatomic,strong)  NSMutableString *phoneNumber;

@property(nonatomic,strong)  NSString *commentProductId;
@property(nonatomic,strong)  NSMutableString *commentUserId;
@property(nonatomic,strong)  NSMutableString *commentRating;
@property(nonatomic,strong)  NSMutableString *commentComment;
@property(nonatomic,strong)  NSMutableString *commentDate;
@property(nonatomic,strong)  NSMutableString *commentUserName;
@property(nonatomic,strong)  NSString *loginUserId;
@property(nonatomic,strong)  NSString *loginUserName;


-(void) configService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) configServiceDone:(NSMutableDictionary*) responseDataDict;

-(void) catalogService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) catalogServiceDone:(NSMutableDictionary*) responseDataDict;

-(void) productDetailsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productDetailsServiceDone:(NSMutableDictionary*) responseDataDict ;

-(void) productService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productServiceDone:(NSMutableDictionary*) responseDataDict ;

- (void) productReviewService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productReviewServiceDone:(NSMutableDictionary*) responseDataDict;


-(void) specialProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) specialProductsServiceDone:(NSMutableDictionary*) responseDataDict ;

-(void) searchProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) searchProductsServiceDone:(NSMutableDictionary*) responseDataDict ;

- (void) productReviewCommentService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod;

-(void) productReviewCommentServiceDone:(NSMutableDictionary*) responseDataDict;


@end
