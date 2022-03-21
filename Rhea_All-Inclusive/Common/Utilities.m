//
//  Utilities.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/12.
//

#import "Utilities.h"
#import "IAPObserver.h"
#import "IAPConfiguration.h"

@implementation Utilities

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _restoreWasCalled = NO;
    }
    return self;
}

/// - returns: An array with the product identifiers to be queried.
-(NSArray *)identifiers {
    NSURL *url = [[NSBundle mainBundle] URLForResource:PCSProductIdsPlistName withExtension:PCSProductIdsPlistFileExtension];
    return [NSArray arrayWithContentsOfURL:url];
}

/// - returns: An array that will be used to populate the Purchases view.
//-(NSMutableArray *)dataSourceForPurchasesUI {
//    NSMutableArray *dataSource = [[NSMutableArray alloc] initWithCapacity:0];
//    NSArray *purchased = [[IAPObserver sharedInstance].productsPurchased copy];
//    NSArray *restored = [[IAPObserver sharedInstance].productsRestored copy];
//
//    if (self.restoreWasCalled && (restored.count > 0) && (purchased.count > 0)) {
//        dataSource = [[NSMutableArray alloc] initWithObjects:[[Section alloc] initWithName:PCSPurchasesPurchased elements:purchased],
//                      [[Section alloc] initWithName:PCSPurchasesRestored elements:restored], nil];
//
//    } else if (self.restoreWasCalled && (restored.count > 0)) {
//        dataSource = [[NSMutableArray alloc] initWithObjects:[[Section alloc] initWithName:PCSPurchasesRestored elements:restored], nil];
//    } else if (purchased.count > 0) {
//        dataSource = [[NSMutableArray alloc] initWithObjects:[[Section alloc] initWithName:PCSPurchasesPurchased elements:purchased], nil];
//    }
//
//    /*
//         Only want to display restored products when the "Restore" button(iOS), "Store > Restore" (macOS), or "Restore all restorable purchases" (tvOS)
//        was tapped and there are restored products.
//    */
//    self.restoreWasCalled = NO;
//    return dataSource;
//}

#pragma mark - Create Alert
/// - returns: An alert with a given title and message.
+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:PCSMessagesOk style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    return alert;
}

@end


@implementation NSString (category)

+ (NSString *)uuid{
    // create a new UUID which you own
    CFUUIDRef uuidref = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidref);
    
    NSString *result = (__bridge NSString *)uuid;
    //release the uuidref
    CFRelease(uuidref);
    // release the UUID
    CFRelease(uuid);
    
    return result;
}

@end


@implementation NSDate (category)

+ (NSString *)chindDateFormate:(NSDate *)update{
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:update];
    return destDateString;
}

+ (NSString *)dateShortFormate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

@end


@implementation SKDownload (SKDownloadAdditions)
/// - returns: A string representation of the downloadable content length.
-(NSString *)downloadContentSize {
    return [NSByteCountFormatter stringFromByteCount:self.contentLength countStyle:NSByteCountFormatterCountStyleFile];
}

@end


@implementation SKProduct (SKProductAdditions)
/// - returns: The cost of the product formatted in the local currency.
-(NSString *)regularPrice {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale: self.priceLocale];
    return [formatter stringFromNumber:self.price];
}

@end
