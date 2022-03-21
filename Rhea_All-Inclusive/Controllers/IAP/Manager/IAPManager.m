//
//  IAPManager.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/7.
//

#import "Utilities.h"
#import "IAPManager.h"
#import "SandBoxHelper.h"
#import <StoreKit/StoreKit.h>

static NSString * const receiptKey = @"receipt_key";
static NSString * const dateKey = @"date_key";
static NSString * const userIdKey = @"userId_key";

dispatch_queue_t iap_queue() {
    static dispatch_queue_t as_iap_queue;
    static dispatch_once_t onceToken_iap_queue;
    dispatch_once(&onceToken_iap_queue, ^{
        as_iap_queue = dispatch_queue_create("com.iap.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return as_iap_queue;
}

@interface IAPManager()<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, assign) BOOL goodsRequestFinished; //判断一次请求是否完成

@property (nonatomic, copy) NSString *receipt; //交易成功后拿到的一个64编码字符串

@property (nonatomic, copy) NSString *date; //交易时间

@property (nonatomic, copy) NSString *userId; //交易人

@end

@implementation IAPManager

+ (IAPManager *)sharedInstance {
    static dispatch_once_t onceToken;
    static IAPManager * iapManagerSharedInstance;

    dispatch_once(&onceToken, ^{
        iapManagerSharedInstance = [[IAPManager alloc] init];
    });
    return iapManagerSharedInstance;
}

//用户允许app内购
- (BOOL)isAuthorizedForPayments {
    return [SKPaymentQueue canMakePayments];
}

- (void)startObserver { //开启监听

    dispatch_async(iap_queue(), ^{
               
        /***
         内购支付两个阶段：
         1.app直接向苹果服务器请求商品，支付阶段；
         2.苹果服务器返回凭证，app向公司服务器发送验证，公司再向苹果服务器验证阶段；
         */
        
        /**
         阶段一正在进中,app退出。
         在程序启动时，设置监听，监听是否有未完成订单，有的话恢复订单。
         */
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        /**
         阶段二正在进行中,app退出。
         在程序启动时，检测本地是否有receipt文件，有的话，去二次验证。
         */
//        [self checkIAPFiles];
    });
}

- (void)stopObserver{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    });
}

#pragma mark - Request Information

- (void)getProducts {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"IAP_ProductIDs" withExtension:@"plist"];
    NSArray *productsIDs = [NSArray arrayWithContentsOfURL:url];
    
    [self fetchProductsMatchingIdentifiers:productsIDs];
}

/// Fetches information about your products from the App Store.
-(void)fetchProductsMatchingIdentifiers:(NSArray *)identifiers {
    // Create a set for the product identifiers.
    NSSet *productIdentifiers = [NSSet setWithArray:identifiers];

    // Initialize the product request with the above identifiers.
    SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productRequest.delegate = self;

    // Send the request to the App Store.
    [productRequest start];
}

#pragma mark - SKProductsRequestDelegate

/// Used to get the App Store's response to your request and notify your observer.
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    // products contains products whose identifiers have been recognized by the App Store. As such, they can be purchased.
    if (response.products.count > 0) {
        if (self.getProductsHandler) {
            self.getProductsHandler(YES, response.products);
        }
    } else {
        if (self.getProductsHandler) {
            self.getProductsHandler(NO, nil);
        }
    }
}

#pragma mark - SKRequestDelegate

/// Called when the product request failed. 查询失败后的回调
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    if (self.getProductsHandler) {
        self.getProductsHandler(NO, nil);
    }
    NSLog(@"------****** request did fail: %@ ******------", error.localizedDescription);
}

#pragma mark - Submit Payment Request

/// Create and add a payment request to the payment queue.
- (void)buyProductRequest:(SKProduct *)product {
    if ([self isAuthorizedForPayments]) {
        if (product) {
            NSLog(@"------****** %@ 商品正在请求中 ******------",product.productIdentifier);
            
            SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            
        } else {
            NSLog(@"------****** 商品为空 ******------");
        }
    } else { // 用户没有授权支付权限
        NSLog(@"------****** 用户没有授权支付权限 ******------");
        // 错误处理
    }
}

- (void)restorePurchasedProducts {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - SKPaymentTransactionObserver Methods

/// Called when there are transactions in the payment queue.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: break;
            // Do not block your UI. Allow the user to continue using your app.
            case SKPaymentTransactionStateDeferred:
                NSLog(@"------****** Allow the user to continue using your app. ******------");
                break;
                
            // The purchase was successful.
            case SKPaymentTransactionStatePurchased:
                NSLog(@"------****** Purchase product successfully. ******------");
                if (self.onBuyProductHandler) {
                    [self getReceipt];  // 获取交易凭证
                    [self saveReceipt]; // 存储交易凭证
                    self.onBuyProductHandler(YES, transaction);
                    
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            // The transaction failed.
            case SKPaymentTransactionStateFailed:
                NSLog(@"------****** Purchase product failed. ******------");
                if (self.onBuyProductHandler) {
                    self.onBuyProductHandler(NO, transaction);
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            // There are restored products.
            case SKPaymentTransactionStateRestored:
                NSLog(@"------****** Restore product successfully. ******------");
                if (self.onBuyProductHandler) {
                    [self getReceipt];  // 获取交易凭证
                    [self saveReceipt]; // 存储交易凭证
                    self.onBuyProductHandler(YES, transaction);
                }
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            default: break;
        }
    }
}

/// Logs all transactions that have been removed from the payment queue.
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"%@ was removed from the payment queue.", transaction.payment.productIdentifier);
    }
}

/// Called when all restorable transactions have been processed by the payment queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    NSLog(@"All restorable transactions have been processed by the payment queue.");
}

/// Called when an error occur while restoring purchases. Notify the user about the error.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    if (error.code != SKErrorPaymentCancelled) {
        
        NSLog(@"------****** IAP Restore Error: %@ ******------", error.localizedDescription);
        
//        self.status = PCSRestoreFailed;
//        self.message = error.localizedDescription;

        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:PCSPurchaseNotification object:self];
        });
    }
}

#pragma mark - Save files

- (void)getReceipt {
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
   
    self.receipt = [receiptData base64EncodedStringWithOptions:0];
}

- (void)saveReceipt {
    self.date = [NSDate chindDateFormate:[NSDate date]];
    
    NSString *fileName = [NSString uuid];
    
    self.userId = @"UserID";
    
    NSString *savePath = [NSString stringWithFormat:@"%@/%@.plist", [SandBoxHelper iapReceiptPath], fileName];
    
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:
                        self.receipt,                 receiptKey,
                        self.date,                    dateKey,
                        self.userId,                  userIdKey,
                        nil];
   
    NSLog(@"%@",savePath);
    
    [dic writeToFile:savePath atomically:YES];
}

#pragma mark - Utilities
- (NSString *)getPriceFormattedForProduct:(SKProduct *)product {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale: product.priceLocale];
    return [formatter stringFromNumber:product.price];
}

@end
