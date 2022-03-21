//
//  IAPManager.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/7.
//

#import <Foundation/Foundation.h>
#import "IAPDataModel.h"

typedef enum : NSUInteger {
    noProductIDsFound,
    noProductsFound,
    paymentWasCancelled,
    productRequestfailed
} IAPManagerError;

typedef void(^GetProductsHandler)(BOOL isSuccess, NSArray *products);
typedef void(^OnBuyProductHandler)(BOOL isSuccess, SKPaymentTransaction *transaction);

@interface IAPManager : NSObject

+ (IAPManager *)sharedInstance;

@property (nonatomic, copy) GetProductsHandler getProductsHandler;
@property (nonatomic, copy) OnBuyProductHandler onBuyProductHandler;

@property (nonatomic, strong) NSMutableArray *availableProducts;

/// Keeps track of all valid products (these products are available for sale in the App Store) and of all invalid product identifiers.
@property (strong) NSMutableArray *storeResponse;

/**
 启动工具
 */
- (void)startObserver;

/**
 结束工具
 */
- (void)stopObserver;

/**
 获取商品
 */
- (void)getProducts;

/**
 购买商品
 */
- (void)buyProductRequest:(SKProduct *)product;

/**
 恢复已购买的商品
 */
- (void)restorePurchasedProducts;

- (void)fetchProductsMatchingIdentifiers:(NSArray *)identifiers;

- (NSString *)getPriceFormattedForProduct:(SKProduct *)product;

@end
