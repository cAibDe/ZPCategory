//
//  NSDate+Extension.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  转字符串
 *
 *  @param dateFormat 格式化字符串：如yyyy-MM-dd等
 *
 *  @return 格式化后的字符串
 */
- (NSString *)formatString:(NSString *)dateFormat {
    
    if(!dateFormat)
        dateFormat = NSDateFormatDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
}

/**
 *  根据unix时间戳构造nsdate
 *
 *  @param unixtime unix时间戳
 *
 *  @return nsdate对象
 */
+ (NSDate *)dateWithUnixTime:(double)unixtime {
    if(unixtime == 0)
        return nil;
    return [NSDate dateWithTimeIntervalSince1970:unixtime];
}
/**
 *  将时间转化为0秒模式
 *
 *  @param date 需要修改的日期
 *
 */
+ (NSDate *)changeDateToZeroMinutDate:(NSDate *)date {
    
    NSString * dateString = [date formatString:NSDateFormatLong];
    NSMutableString * nowMDateString = [NSMutableString stringWithString:dateString];
    NSRange range = NSMakeRange(dateString.length - 2, 2);
    [nowMDateString replaceCharactersInRange:range withString:@"00"];
    NSDateFormatter * formate  = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * newDate = [formate dateFromString:nowMDateString];
    return newDate;
}
/**
 *  获得指定月份的第一天和最后一天
 *  @param date 指定月份
 *  @return 第一天和最后一天数组
 */
+ (NSArray *)getFirstAndLastDayOfThisMonthWithNsDate:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:date];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
    
}

@end
