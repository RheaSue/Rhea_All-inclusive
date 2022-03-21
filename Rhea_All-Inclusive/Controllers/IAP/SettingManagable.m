//
//  SettingManagable.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/9.
//

#import "SettingManagable.h"



@implementation SettingManagable

- (NSURL *)settingURL {
    NSURL *cachesdirectory = [[NSFileManager.defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    return [cachesdirectory URLByAppendingPathComponent:@".plist"];
}

//- (BOOL)update {
//    BOOL result = false;
//    NSData encoded = self
//}

@end
