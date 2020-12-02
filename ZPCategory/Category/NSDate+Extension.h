//
//  NSDate+Extension.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSDateFormatLongLong  @"yyyy-MM-dd HH:mm:ss"
#define NSDateFormatLong      @"yyyy-MM-dd HH:mm"
#define NSDateFormatDate      @"yyyy-MM-dd"
#define NSDateFormatDay       @"MM-dd"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

/**
 *  转字符串
 *
 *  @param dateFormat 格式化字符串：如yyyy-MM-dd等
 *
 *  @return 格式化后的字符串
 */
- (NSString *)formatString:(NSString *)dateFormat;

/**
 *  根据unix时间戳构造nsdate
 *
 *  @param unixtime unix时间戳
 *
 *  @return nsdate对象
 */
+ (NSDate *)dateWithUnixTime:(double)unixtime;
/**
 *  将时间转化为0秒模式
 *
 *  @param date 需要修改的日期
 *
 */
+ (NSDate *)changeDateToZeroMinutDate:(NSDate *)date;

/**
 *  获得指定月份的第一天和最后一天
 *  @param date 指定月份
 *  @return 第一天和最后一天数组
 */
+ (NSArray *)getFirstAndLastDayOfThisMonthWithNsDate:(NSDate *)date;

/// UTC时间转成当地的时间
/// @param UTCTime 国际时间
/// @param needDateFormatter 需要的时间格式
+ (NSString *)currentAreaTimeWitthUTCTime:(NSString *)UTCTime
                        needDateFormatter:(NSString *)needDateFormatter;

@end

NS_ASSUME_NONNULL_END
