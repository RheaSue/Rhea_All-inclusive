//
//  AppDelegate.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/6.
//

@import StoreKit;
#import "AppDelegate.h"
#import "IAPManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 启动IAP工具类 Attach an observer to the payment queue. */
    [[IAPManager sharedInstance] startObserver];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /** 结束IAP工具类 Remove the observer.*/
    [[IAPManager sharedInstance] stopObserver];
}

@end
