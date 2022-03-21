//
//  Utilities.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/12.
//

#import <Foundation/Foundation.h>

@import StoreKit;
@import UIKit;

@interface Utilities : NSObject

/// - returns: An array that will be used to populate the Purchases view.
@property (NS_NONATOMIC_IOSONLY, readonly, assign) NSArray *dataSourceForPurchasesUI;

/// - returns: An array with the product identifiers to be queried.
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *identifiers;

/// Indicates whether the user has initiated a restore.
@property (nonatomic) BOOL restoreWasCalled;

/// - returns: An alert with a given title and message.
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message;

@end


@interface NSString (category)

+ (NSString *)uuid;

@end


@interface NSDate (category)

+ (NSString *)chindDateFormate:(NSDate *)date;

+ (NSString *)dateShortFormate:(NSDate *)date;

- (NSDate *)dateByAddingYears:(NSInteger)years;

@end


@interface SKDownload (SKDownloadAdditions)
/// - returns: A string representation of the downloadable content length.
-(NSString *)downloadContentSize;
@end


@interface SKProduct (SKProductAdditions)
/// - returns: The cost of the product formatted in the local currency.
-(NSString *)regularPrice;
@end
