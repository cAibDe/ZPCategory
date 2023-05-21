//
//  UIView+Extension.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/12/28.
//  Copyright © 2019 c4ibD3. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

/// 给UIView画圆角
/// - Parameters:
///   - leftTop: 左上
///   - rigtTop: 右上
///   - bottemLeft: 左下
///   - bottemRight: 右下
///   - view: 需要被画圆角的视图
///   - frame: 视图的Frame
+ (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                              view:(UIView *)view
                             frame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
