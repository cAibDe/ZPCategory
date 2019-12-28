//
//  NSTimer+Extension.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Extension)

/**
 创建定时器

 @param timeInterval 时间间隔
 @param block 回调block
 @param repeat 是否重复
 @return timer 定时器
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                      block:(void (^)(void))block
                                     repeat:(BOOL)repeat;

@end

NS_ASSUME_NONNULL_END
