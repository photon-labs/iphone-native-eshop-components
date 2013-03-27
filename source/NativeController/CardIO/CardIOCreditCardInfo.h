/**
 * PHR_iphoneNativeEshopARC
 *
 * Copyright (C) 1999-2013 Photon Infotech Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//
//  CardIOCreditCardInfo.h
//  Copyright (c) 2011-2012 PayPal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  CardIOCreditCardTypeUnknown = 0,
  CardIOCreditCardTypeAmex = '3',
  CardIOCreditCardTypeJCB = 'J',
  CardIOCreditCardTypeVisa = '4',
  CardIOCreditCardTypeMastercard = '5',
  CardIOCreditCardTypeDiscover = '6'
} CardIOCreditCardType;


@interface CardIOCreditCardInfo : NSObject<NSCopying>

@property(nonatomic, copy, readwrite) NSString *cardNumber;
@property(nonatomic, copy, readonly) NSString *redactedCardNumber; // card number with all but the last four digits obfuscated

// expiryMonth & expiryYear may be 0, if expiry information is not requested
@property(nonatomic, assign, readwrite) NSUInteger expiryMonth; // January == 1
@property(nonatomic, assign, readwrite) NSUInteger expiryYear; // the full four digit year

// cvv and/or zip may be nil, if not requested
@property(nonatomic, copy, readwrite) NSString *cvv;
@property(nonatomic, copy, readwrite) NSString *zip;

// was the card number scanned (as opposed to manually entered)?
@property(nonatomic, assign, readwrite) BOOL scanned;

// Derived from cardNumber
@property(nonatomic, assign, readonly) CardIOCreditCardType cardType;

// Convenience method to return a card type string (e.g. "Visa", "AmEx", "JCB", "MasterCard", or "Discover") suitable for display.
// Currently English only.
+ (NSString *)displayStringForCardType:(CardIOCreditCardType)cardType;

@end
