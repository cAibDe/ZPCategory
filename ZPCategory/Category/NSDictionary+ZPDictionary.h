//
//  NSDictionary+ZPDictionary.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZPDictionary)

#pragma mark - 数据类型的判断

/**
 设置一个BOOL值
 */
- (BOOL)boolForKey:(NSString *)key;

/**
 设置一个NSInteger值
 */
- (NSInteger)integerForKey:(NSString *)key;

/**
 设置一个int值
 */
- (int)intForKey:(NSString *)key;

/**
 设置一个double值
 */
- (double)doubleForKey:(NSString *)key;
/**
 设置一个float值
 */
- (float)floatForKey:(NSString *)key;
/**
 设置一个long long值
 */
- (long long)longLongForKey:(NSString *)key;
/**
 设置一个unsigned long long值
 */
- (unsigned long long)unsignedLongLongForKey:(NSString *)key;
/**
 设置一个NSString值
 */
- (NSString *)stringForKey:(NSString *)key;
/**
 设置一个NSArray值
 */
- (NSArray *)arrayForKey:(NSString *)key;

/**
 *  value为空时，不set此key
 *
 *  @param value value（可nil）
 *  @param key   key
 */
- (void)safeValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
