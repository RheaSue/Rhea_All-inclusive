//
//  IAPObserver.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/8.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#import "IAPConfiguration.h"

@interface IAPObserver : NSObject

+ (IAPObserver *)sharedInstance;

/**
     Indicates whether the user is allowed to make payments.
     - returns: true if the user is allowed to make payments and false, otherwise. Tell StoreManager to query the App Store when the user is allowed to
               make payments and there are product identifiers to be queried.
 */
@property (NS_NONATOMIC_IOSONLY, readonly) BOOL isAuthorizedForPayments;

/// Indicates the cause of the purchase failure.
@property (nonatomic, copy) NSString *message;

/// Keeps track of all purchases.
@property (strong) NSMutableArray *productsPurchased;

/// Keeps track of all restored purchases.
@property (strong) NSMutableArray *productsRestored;

/// Indicates the purchase status.
@property (nonatomic) PCSPurchaseStatus status;

/// Implements the purchase of a product.
-(void)buy:(SKProduct *)product;

/// Implements the restoration of previously completed purchases.
-(void)restore;

@end
