//
//  UIButton+ZPButton.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ActionBlock)(void);
@interface UIButton (ZPButton)

/**
 *  UIButton+Block
 *
 *  @param controlEvent 触摸事件
 *  @param action 执行的方法
 */
- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end

NS_ASSUME_NONNULL_END
