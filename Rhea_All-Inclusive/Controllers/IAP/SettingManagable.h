//
//  SettingManagable.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/9.
//

#import <Foundation/Foundation.h>

@protocol SettingManagableProtocol <NSObject>

- (NSURL *)settingURL;
- (BOOL)update;
- (BOOL)delete;
- (BOOL)reset;
- (BOOL)load;
- (BOOL)loadUsingSettingFile;
- (NSArray *)toDictionary;

@end

@interface SettingManagable : NSObject<SettingManagableProtocol>

@end
