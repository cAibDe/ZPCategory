//
//  UITextField+Extension.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "UITextField+Extension.h"
#import "NSString+Extension.h"
#import <objc/runtime.h>

#define TextFieldLeftViewMinWidth   60  //左侧文字最小宽度，为了输入位置对齐

static char maxLengthKey;
static char canOnlyInputNumberKey;

@implementation UITextField (Extension)
#pragma mark - LeftView

/**
 *  设置leftview为图片
 *
 *  @param imageName 图片名称
 */
- (void)setLeftViewWithImageName:(NSString *)imageName{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.height, self.frame.size.height)];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    //    NSLog(@"img frame:%@",NSStringFromCGRect(img.frame));
    img.frame = CGRectMake((leftView.frame.size.width - CGRectGetWidth(img.frame)) / 2, (leftView.frame.size.height - CGRectGetHeight(img.frame)) / 2, CGRectGetWidth(img.frame), CGRectGetHeight(img.frame));
    
    [leftView addSubview:img];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}

/**
 *  设置leftView为文字
 *
 */
- (void)setLeftViewWithText:(NSString *)text{
    [self setLeftViewWithText:text minWidth:0];
}

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 */
- (void)setLeftViewWithText:(NSString *)text
                   minWidth:(CGFloat)minWidth{
    [self setLeftViewWithText:text
                     minWidth:minWidth
                        color:[UIColor colorWithRed:215/255.0 green:12/255.0 blue:37/255.0 alpha:1.0]];
}

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 *  @param color 占位文字颜色
 */
- (void)setLeftViewWithText:(NSString *)text
                   minWidth:(CGFloat)minWidth
                      color:(UIColor *)color{
    if (minWidth <= 0) {
        minWidth = TextFieldLeftViewMinWidth;
    }
    
    CGFloat width = [text calculateRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)
                                           font:self.font
                                      alignment:NSTextAlignmentLeft
                                  linebreakMode:NSLineBreakByWordWrapping
                                      lineSpace:0.0].width + 10.0;
    
    if (width < minWidth) {
        width = minWidth;
    }
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, self.frame.size.height)];
    leftLabel.font = self.font;
    leftLabel.text = text;
    leftLabel.textColor = color;
    
    self.leftView = leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - RightView
/**
 *  设置rightView为文字
 *
 *  @param text 文字
 */
- (void)setRightViewWithText:(NSString *)text{
    CGFloat width = [text calculateRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)
                                           font:self.font
                                      alignment:NSTextAlignmentLeft
                                  linebreakMode:NSLineBreakByWordWrapping
                                      lineSpace:0.0].width + 10.0;
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, width, self.frame.size.height)];
    rightLabel.font = self.font;
    rightLabel.text = text;
    
    self.rightView = rightLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
}

/**
 *  设置rightView为图片
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewWithImageName:(NSString *)imageName{
    
    [self layoutIfNeeded];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(img.frame)+8, self.frame.size.height)];
    
    img.frame = CGRectMake((rightView.frame.size.width - CGRectGetWidth(img.frame)) / 2, (rightView.frame.size.height - CGRectGetHeight(img.frame)) / 2, CGRectGetWidth(img.frame), CGRectGetHeight(img.frame));
    img.userInteractionEnabled = NO;
    rightView.userInteractionEnabled = NO;
    [rightView addSubview:img];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightView;
}

/**
 *  设置rightView为button
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewButtonWithImageName:(NSString *)imageName
                                  taget:(id)taget
                               selector:(SEL)selector{
    [self layoutIfNeeded];
    UIImage * img = [UIImage imageNamed:imageName];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.rightView.frame.size.height, self.rightView.frame.size.height)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 50);
    [rightView addSubview:button];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightView;
}

#pragma mark - Padding
/**
 *  设置UITextField左侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingLeftSpace:(float)padding{
    CGRect frame = [self frame];
    frame.size.width = padding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

/**
 *  设置UITextField右侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingRightSpace:(float)padding{
    CGRect frame = [self frame];
    frame.size.width = padding;
    UIView *rightview = [[UIView alloc] initWithFrame:frame];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightview;
}

#pragma mark - UI显示
/**
 *  设置底部边框
 *
 *  @param lineColor 边框颜色
 */
- (void)setBottomBorderLineWithColor:(UIColor *)lineColor{
    [self layoutIfNeeded];
    CALayer *bottomLayer = [CALayer new];
    bottomLayer.frame = CGRectMake(0.0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds), 1.0);
    bottomLayer.backgroundColor = lineColor.CGColor;
    [self.layer addSublayer:bottomLayer];
}

/**
 *  设置placeholder的颜色
 *
 */
- (void)setPlaceholderColor:(UIColor *)color{
    
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
}
/**
 *  设置下划线出去左边的文字
 */
- (void)setLeftViewWithText:(NSString *)text
                   minWidth:(CGFloat)minWidth
 withOutTextBottomLineColor:(UIColor *)color{
    if (minWidth <= 0) {
        minWidth = TextFieldLeftViewMinWidth;
    }
    
    CGFloat width = [text calculateRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)
                                           font:self.font
                                      alignment:NSTextAlignmentLeft
                                  linebreakMode:NSLineBreakByWordWrapping
                                      lineSpace:0.0].width + 10.0;
    if (width < minWidth) {
        width = minWidth;
    }
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, width, self.frame.size.height)];
    leftLabel.font = self.font;
    leftLabel.text = text;
    leftLabel.textColor = [UIColor colorWithRed:243/255.0 green:88/255.0 blue:88/255.0 alpha:1.0];
    
    self.leftView = leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self layoutIfNeeded];
    CALayer *bottomLayer = [CALayer new];
    bottomLayer.frame = CGRectMake(CGRectGetWidth(self.leftView.bounds), CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds)-CGRectGetWidth(self.leftView.bounds), 1.0);
    bottomLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:bottomLayer];
}

#pragma mark - ========== 最大长度&&只可以输入数字 ==========
#pragma mark - Property

- (NSInteger)maxLength {
    NSNumber *maxLengthNumber = objc_getAssociatedObject(self, &maxLengthKey);
    return maxLengthNumber.integerValue;
}

- (void)setMaxLength:(NSInteger)maxLength {
    NSNumber *maxLengthNumber = [NSNumber numberWithInteger:maxLength];
    objc_setAssociatedObject(self, &maxLengthKey, maxLengthNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)canOnlyInputNumber {
    NSNumber *obj = objc_getAssociatedObject(self, &canOnlyInputNumberKey);
    return obj.boolValue;
}

- (void)setCanOnlyInputNumber:(BOOL)canOnlyInputNumber {
    NSNumber *numberObj = [NSNumber numberWithBool:canOnlyInputNumber];
    objc_setAssociatedObject(self, &canOnlyInputNumberKey, numberObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)textFieldChanged:(UITextField *)textField {
    
    if (textField.maxLength <= 0) {
        return;
    }
    
    UITextRange *selectedRange = [self markedTextRange];
    //获取高亮部分
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textField.text.length > textField.maxLength) {
            textField.text = [self.text substringToIndex:self.maxLength];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length == 0) return YES;
    
    if (textField.canOnlyInputNumber && ![string isPositiveInteger]) {
        return NO;
    }
    NSInteger length = textField.text.length - range.length + string.length;
    if (textField.maxLength > 0 && length > textField.maxLength) {
        return NO;
    }
    return YES;
}

@end
