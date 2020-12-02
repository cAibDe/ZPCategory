//
//  NSString+Extension.h
//  ZPCategory
//
//  Created by 张鹏 on 2020/11/16.
//  Copyright © 2020 c4ibD3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

#pragma mark - 字符串宽度&&高度
/// 计算文字的size
/// @param size 预计计算的size
/// @param font 字体
/// @param alignment 文字的对齐方式
/// @param linebreakMode 文字的省略模式
/// @param lineSpace 行间距
- (CGSize)calculateRectWithSize:(CGSize)size
                           font:(UIFont *)font
                      alignment:(NSTextAlignment)alignment
                  linebreakMode:(NSLineBreakMode)linebreakMode
                      lineSpace:(CGFloat)lineSpace;


/// 计算文字的size
/// @param size 预计的计算的size
/// @param text 文字
/// @param numberOfLine 需要计算的行数
/// @param font 字体
+ (CGSize)calcTextSizeWithSize:(CGSize)size
                          text:(id)text
                  numberOfLine:(NSInteger)numberOfLine
                          font:(UIFont *)font;


#pragma mark - 字符串 正则表达式

/// 判断电话号码是否正确
- (BOOL)isValidateMobile;

/// 判断是否固定电话
- (BOOL)isValidatePhone;

/// 判断是否是400客服电话
- (BOOL)is400Phone;

/// 检查输入字符串是否是身份证号
- (BOOL)isIdCard;
#pragma mark - 数据类型的判断

/// 是否正整数
- (BOOL)isPositiveInteger;

/// 是否浮点数
- (BOOL)isFloat;

/// 检查输入字符串是否只由英文字母和数字组成
- (BOOL)isNumberOrLetter;

/// 检查输入字符串是否只由汉字和英文字母组成
- (BOOL)isChineseOrLetter;

/// 是否为空字符串
- (BOOL)isBlankString;
#pragma mark - NSString->NSAttributedString

/// 转成NSMutableAttributedString
/// @param string 字符串
/// @param font 字体
/// @param lineSpace 行间距
+ (NSMutableAttributedString *)toAttributeStringWithString:(NSString *)string
                                                      font:(UIFont *)font
                                                 lineSpace:(CGFloat)lineSpace;
#pragma mark - NSString 计算字节长度

/// 计算字符串的字节长度
///  * 中文 = 2
///  * 英文或者数字 = 1
///  * 表情 = 4
- (NSUInteger)charactorNumber;


/// 根据不同的编码方式计算字节长度
/// @param encoding 编码方式
- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding;

/**
 calulate the number of charactor.
 1 Chinese(not including Chinese mark) = 2
 1 other charactor = 1
 
 @return NSUInteger
 */

- (NSUInteger)charactorNumberForChineseSpecial;

#pragma mark - 字符串加密

/// MD5加密
- (NSString *)md5;

/// SHA1加密
- (NSString *)SHA1;
#pragma mark - 字符串过滤

/// 去除两端空格和回车
- (NSString *)trim;

/// 仅去除两端空格
- (NSString *)trimOnlyWhitespace;

/// 去除html格式
/// @param html html文字
+ (NSString *)filterHtml:(NSString *)html;

#pragma mark - 根据图片名字返回图片

/// 根据图片名字返回图片
- (UIImage *)toImage;

@end

NS_ASSUME_NONNULL_END
