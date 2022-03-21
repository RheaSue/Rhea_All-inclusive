//
//  IAPDataModel.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/9.
//

#import "IAPDataModel.h"
#import "Utilities.h"

@implementation IAPProductModel

- (void)setPurchasedDate:(NSDate *)purchasedDate {
    _purchasedDate = purchasedDate;
    
    if (self.productType == NonRenewingSubscriptions) {
        NSDate *date = [_purchasedDate dateByAddingYears:self.nonRenewQuantity];
        self.nonRenewExpiredDate = [NSDate dateShortFormate:date];
    }
}

@end

@implementation IAPDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nonConsumeModel = [[IAPProductModel alloc] init];
        _nonConsumeModel.productType = NonConsumable;
        
        _nonRenewModel = [[IAPProductModel alloc] init];
        _nonRenewModel.productType = NonRenewingSubscriptions;
    }
    return self;
}

- (SKProduct *)getProductContainingKeyword:(NSString *)keyword {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productIdentifier == %@",keyword];
    return [self.products filteredArrayUsingPredicate:predicate].firstObject;
}

@end
