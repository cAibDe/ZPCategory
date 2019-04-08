//
//  NSDictionary+ZPDictionary.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "NSDictionary+ZPDictionary.h"

@implementation NSDictionary (ZPDictionary)
#pragma mark - 数据类型的判断

/**
 设置一个BOOL值
 */
- (BOOL)boolForKey:(NSString *)key{
    if([self objectForKey:key] == [NSNull null])
        return NO;
    return [[self objectForKey:key] boolValue];
}

/**
 设置一个NSInteger值
 */
- (NSInteger)integerForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return NSIntegerMax;
    }
    return  [[self valueForKey:key] integerValue];
}

/**
 设置一个int值
 */
- (int)intForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return 0;
    }
    
    return [[self valueForKey:key] intValue];
}

/**
 设置一个double值
 */
- (double)doubleForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    return [[self valueForKey:key] doubleValue];
}
/**
 设置一个float值
 */
- (float)floatForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    
    return [[self valueForKey:key] floatValue];
}
/**
 设置一个long long值
 */
- (long long)longLongForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    return [[self valueForKey:key] longLongValue];
}
/**
 设置一个unsigned long long值
 */
- (unsigned long long)unsignedLongLongForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    
    return [[self valueForKey:key] unsignedLongLongValue];
}
/**
 设置一个NSString值
 */
- (NSString *)stringForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil) {
        return @"";
    }
    return [[self valueForKey:key] description];
}
/**
 设置一个NSArray值
 */
- (NSArray *)arrayForKey:(NSString *)key{
    if ([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil || ![[self objectForKey:key] isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return [NSArray arrayWithObject:[self objectForKey:key]];
}

/**
 *  value为空时，不set此key
 *
 *  @param value value（可nil）
 *  @param key   key
 */
- (void)safeValue:(id)value forKey:(NSString *)key{
    if(value) {
        [self setValue:value forKey:key];
    }
}

@end
