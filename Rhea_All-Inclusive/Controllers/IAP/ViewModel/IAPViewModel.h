//
//  IAPViewModel.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/12.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "IAPDataModel.h"

@protocol IAPViewModelDelegate <NSObject>

@required
- (void)willStartProcess;
- (void)didFinishProcess;

@optional
- (void)shouldUpdateUI;
- (void)showIAPRelatedError:(NSError *)error;

@end

@interface IAPViewModel : NSObject

@property (nonatomic,weak) id<IAPViewModelDelegate> delegate;

@property(nonatomic, strong) IAPDataModel *nonConsumableData;

@property(nonatomic, strong) IAPDataModel *nonRenewingSubData;

@property(nonatomic, strong) IAPDataModel *model;

- (SKProduct *)getProductForItem:(NSInteger)section;

- (BOOL)purchaseProduct:(SKProduct *)product;

- (void)restorePurchases;

@end
