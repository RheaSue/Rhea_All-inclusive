//
//  SandBoxHelper.h
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/14.
//

#import <Foundation/Foundation.h>

@interface SandBoxHelper : NSObject

/**
 程序主目录，可见子目录(3个):Documents、Library、tmp
 */
+ (NSString *)homePath;

/**
 程序目录，不能存任何东西
 */
+ (NSString *)appPath;

/**
 Documents:
 保存用户创建的文档文件的目录，用户可以通过文件分享分享该目录下的文件
 在iTunes和iCloud备份时会备份该目录
 建议保存你希望用户看得见的文件
 */
+ (NSString *)docPath;

/**
 Preferences:
 用户偏好存储目录，在使用NSUserDefaults或者CFPreferences接口保存的数据保存在该目录下，
 编程人员不需要对该目录进行管理。在iTunes和iCloud备份时会备份该目录。
 */
+ (NSString *)libPrefPath;

/**
 Cache:
 建议保存数据缓存使用。
 在用户的磁盘空间已经使用完毕时有可能删除该目录下的文件，
 在APP使用期间不会删除，APP没有运行时系统有可能进行删除。
 需要持久化的数据建议不要保存在该目录下，以免系统强制删除。
 */
+ (NSString *)libCachePath;         // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除

/**
 tmp:
 苹果建议该目录用来保存临时使用的数据
 编程人员应该在数据长时间内不使用时主动删除该目录下的文件，在APP没有运行期间，系统可能删除该目录下的文件。
 在iTunes和iCloud备份时不会备份该目录。
 */
+ (NSString *)tmpPath;

/**
 用于存储iap内购返回的购买凭证
 */
+ (NSString *)iapReceiptPath;

@end
