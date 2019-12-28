//
//  NSTimer+ZPtimer.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "NSTimer+ZPtimer.h"

@implementation NSTimer (ZPtimer)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                      block:(void (^)(void))block
                                     repeat:(BOOL)repeat{
    void (^timerBlock)(void) = [block copy];
    NSTimer *timer = [self scheduledTimerWithTimeInterval:timeInterval
                                                   target:self
                                                 selector:@selector(executeBlock:)
                                                 userInfo:timerBlock
                                                  repeats:repeat];
    return timer;
}

+ (void)executeBlock:(NSTimer *)timer{
    if ([timer userInfo]) {
        void (^timerBlock)(void) = (void (^)(void))[timer userInfo];
        timerBlock();
    }
}
@end
