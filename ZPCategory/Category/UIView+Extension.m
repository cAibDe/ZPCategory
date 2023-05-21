//
//  UIView+Extension.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/12/28.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
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
                             frame:(CGRect)frame {
   
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
   
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    maskPath.lineWidth = 1.0;
    maskPath.lineCapStyle = kCGLineCapRound;
    maskPath.lineJoinStyle = kCGLineJoinRound;
    [maskPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
    [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];
   
    [maskPath addQuadCurveToPoint:CGPointMake(width, height- bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
    [maskPath addLineToPoint:CGPointMake(width, rigtTop)]; //右边直线
   
    [maskPath addQuadCurveToPoint:CGPointMake(width - rigtTop, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
    [maskPath addLineToPoint:CGPointMake(leftTop, 0)]; //顶部直线
   
    [maskPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)]; //左上角圆弧
    [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)]; //左边直线
    [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end
