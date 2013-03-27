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
//  CardIOPaymentViewControllerDelegate.h
//  Copyright (c) 2011-2012 PayPal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CardIOPaymentViewController;
@class CardIOCreditCardInfo;

@protocol CardIOPaymentViewControllerDelegate<NSObject>

@required

//
// Precisely one of userDidCancelPaymentViewController: or userDidProvideCreditCardInfo:inPaymentViewController: will be called.
// In either case, it is your responsibility to dismiss the CardIOPaymentViewController.
//

// This method will be called if the user cancels the scan. You must dismiss paymentViewController.
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController;

// This method will be called when there is a successful scan (or manual entry). You must dismiss paymentViewController.
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController;

@end