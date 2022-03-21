//
//  IAPDataModel.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/9.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef struct {
    BOOL isUnlockExtraFunction; // non-consumable product
    int primaryRemainDays; // non-renewing subscriptions remain days
    
} SettingsManageable;

typedef enum {
    Consumable,
    NonConsumable,
    AutoRenewableSubscriptions,
    NonRenewingSubscriptions
} ProductType;

@interface IAPProductModel : NSObject

@property(nonatomic, strong) SKProduct *product;

@property(nonatomic, assign) ProductType productType;

@property(nonatomic, assign) BOOL isUnlockExtraFunction;

@property(nonatomic, strong) NSString *nonRenewExpiredDate;
@property(nonatomic, assign) NSInteger nonRenewQuantity;

@property(nonatomic, strong) NSDate *purchasedDate;

@end


@interface IAPDataModel : NSObject

@property(nonatomic, strong) NSArray<SKProduct *> *products;

@property(nonatomic, strong) IAPProductModel *nonConsumeModel;
@property(nonatomic, strong) IAPProductModel *nonRenewModel;

//@property(nonatomic, assign) BOOL isUnlockExtraFunction;
//
//@property(nonatomic, strong) NSString *nonRenewExpiredDate;
//@property(nonatomic, assign) NSInteger *nonRenewQuantity;

@property(nonatomic, strong) NSArray *element;

- (SKProduct *)getProductContainingKeyword:(NSString *)keyword;

@end


