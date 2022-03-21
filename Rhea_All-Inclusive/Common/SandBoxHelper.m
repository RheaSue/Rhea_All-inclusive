//
//  SandBoxHelper.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/14.
//

#import "SandBoxHelper.h"

@implementation SandBoxHelper

+ (NSString *)homePath {
    return NSHomeDirectory();
}

+ (NSString *)appPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libCachePath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)tmpPath {
    return NSTemporaryDirectory();
}

+ (NSString *)iapReceiptPath {
    
    NSString *path = [[self libPrefPath] stringByAppendingFormat:@"/IAPDemo"];
    [self hasExist:path];
    return path;
}

+ (BOOL)hasExist:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

@end
