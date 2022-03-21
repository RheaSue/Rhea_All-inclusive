//
//  IAPViewModel.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/12.
//

#import "IAPViewModel.h"
#import "IAPObserver.h"
#import "IAPManager.h"
#import "Utilities.h"

@interface IAPViewModel()

@end

@implementation IAPViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = [[IAPDataModel alloc] init];
        __weak typeof(self) weakSelf = self;
        [IAPManager sharedInstance].getProductsHandler = ^(BOOL isSuccess, NSArray *products) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (isSuccess && products.count > 0) {
                strongSelf.model.products = products;
                
                for (SKProduct *product in products) {
                    if ([product.productIdentifier isEqualToString:@"test2"]) {
                        strongSelf.model.nonConsumeModel.product = product;
                    }
                    if ([product.productIdentifier isEqualToString:@"test3"]) {
                        strongSelf.model.nonRenewModel.product = product;
                    }
                }
                
                if ([strongSelf.delegate respondsToSelector:@selector(shouldUpdateUI)]) {
                    [strongSelf.delegate shouldUpdateUI];
                }
            }
        };
        [[IAPManager sharedInstance] getProducts];
    }
    return self;
}

- (SKProduct *)getProductForItem:(NSInteger)section {
    // Search for a specific keyword depending on the index value.
    NSString *keyword;
    
    switch (section) {
        case 0:
            keyword = @"test2";
            break;
        case 1:
            keyword = @"test3";
            break;
        default:
            keyword = @"";
            break;
    }
    
    SKProduct *product = [_model getProductContainingKeyword:keyword];
    return product;
}

- (BOOL)purchaseProduct:(SKProduct *)product {    
    if ([IAPObserver sharedInstance].isAuthorizedForPayments) {
        [_delegate willStartProcess];
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [IAPManager sharedInstance].onBuyProductHandler = ^(BOOL isSuccess, SKPaymentTransaction *transaction) {
                if (isSuccess) {
                    [strongSelf updateDataWithPurchasedProduct:product];
                    
                    if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
                        strongSelf.model.nonRenewModel.nonRenewQuantity += 1;
                    }
                    
                    strongSelf.model.nonRenewModel.purchasedDate = transaction.transactionDate;
                    
                } else {
                    NSLog(@"------****** Buy product failed. ******------");
                }
            };
            
            [[IAPManager sharedInstance] buyProductRequest:product];
        });
        
        return YES;
    } else {
        return NO;
    }
}

- (void)updateDataWithPurchasedProduct:(SKProduct *)product {
    if ([product.productIdentifier containsString:@"test2"]) {
        _model.nonConsumeModel.isUnlockExtraFunction = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(shouldUpdateUI)]) {
        [self.delegate shouldUpdateUI];
    }
}

- (void)restorePurchases {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [IAPManager sharedInstance].onBuyProductHandler = ^(BOOL isSuccess, SKPaymentTransaction *transaction) {
            if (isSuccess) {
                if (transaction && transaction.payment) {
                    self.model.nonConsumeModel.product = [self.model getProductContainingKeyword:transaction.payment.productIdentifier];
                    self.model.nonConsumeModel.isUnlockExtraFunction = YES;
                    [strongSelf updateDataWithPurchasedProduct:self.model.nonConsumeModel.product];
                }
                
            } else {
                NSLog(@"------****** Buy product failed. ******------");
            }
        };
        
        [[IAPManager sharedInstance] restorePurchasedProducts];
    });
}

@end
