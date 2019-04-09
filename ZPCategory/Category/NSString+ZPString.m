//
//  NSString+ZPString.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "NSString+ZPString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZPString)
#pragma mark - 字符串宽度&&高度
/**
 *  获取字符串的实际宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 实际宽度
 */
- (float)widthWithFont:(UIFont *)font height:(float)height{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize actualsize =[self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.width;
}

/**
 *  获取字符串的实际高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 实际高度
 */
- (float)heightWithFont:(UIFont *)font width:(float)width{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize actualsize =[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.height;
}
/**
 *  获取字符串的实际高度
 *
 *  @param font        字体
 *  @param width       宽度
 *  @param lineSpacing 行间距
 *
 *  @return 实际高度
 */
- (float)heightWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    CGSize actualsize =[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.height;
}
/**
 *  返回字体的实际大小
 *
 *  @param font  字体大小
 *  @param width 限制宽度
 *
 *  @return 实际大小
 */
- (CGSize)sizeWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    CGSize actualsize =[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize;
}

#pragma mark - 字符串 正则表达式
/**
 *  判断电话号码是否正确
 *
 *  @return YES:是 NO：否
 */
- (BOOL)isValidateMobile{
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/**
 *  判断是否固定电话
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isValidatePhone{
    NSString *phoneRegex = @"^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/**
 *  判断是否是400客服电话
 *
 *  @return YES：是 NO：否
 */
- (BOOL)is400Phone{
    NSString *phoneRegex = @"^400[016789]\\d{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
/**
 *  检查输入字符串是否是身份证号
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isIdCard{
    if (self.length != 15 && self.length !=18) {
        return NO;
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [self substringToIndex:2];
    
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    int year =0;
    
    switch (self.length) {
            
        case 15:
            
            year = [self substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:self
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, self.length)];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
            
        case 18:
            year = [self substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:self
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, self.length)];
            
            if(numberofMatch >0) {
                
                int S = ([self substringWithRange:NSMakeRange(0,1)].intValue + [self substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([self substringWithRange:NSMakeRange(1,1)].intValue + [self substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([self substringWithRange:NSMakeRange(2,1)].intValue + [self substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([self substringWithRange:NSMakeRange(3,1)].intValue + [self substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([self substringWithRange:NSMakeRange(4,1)].intValue + [self substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([self substringWithRange:NSMakeRange(5,1)].intValue + [self substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([self substringWithRange:NSMakeRange(6,1)].intValue + [self substringWithRange:NSMakeRange(16,1)].intValue) *2 + [self substringWithRange:NSMakeRange(7,1)].intValue *1 + [self substringWithRange:NSMakeRange(8,1)].intValue *6 + [self substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                //                if ([M isEqualToString:[self substringWithRange:NSMakeRange(17,1)]]) {
                if ([M compare:[self substringWithRange:NSMakeRange(17,1)] options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
#pragma mark - 数据类型的判断
/**
 *  是否正整数
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isPositiveInteger{
    NSString *regex = @"^\\d+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}
/**
 *  是否浮点数
 *
 */
- (BOOL)isFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
/**
 *  检查输入字符串是否只由英文字母和数字组成
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isNumberOrLetter{
    NSString *regex = @"^[0-9a-zA-Z]+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}

/**
 *  检查输入字符串是否只由汉字和英文字母组成
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isChineseOrLetter{
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:self];
}
/**
 *  是否为空字符串
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isBlankString{
    if (self == nil) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self trim] length] == 0) {
        return YES;
    }
    return NO;
}
#pragma mark - NSString->NSAttributedString
/**
 *  转成NSAttributedString
 *
 *  @param lineSpacing 行间距
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)toAttributeStringWithLineSpacing:(float)lineSpacing{
    if ([self isBlankString]) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return attributedString;
}

#pragma mark - 字符串加密
/**
 *  MD5加密
 *
 *  @return 加密后字符串
 */
- (NSString *)md5{
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}
/**
 *  SHA1加密
 *
 *  @return 加密后字符串
 */
- (NSString *)SHA1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
#pragma mark - 字符串过滤
/**
 *  @brief  去除两端空格和回车
 *
 *  @return 去除后的字符串
 */
- (NSString *)trim{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}

/**
 *  @brief  仅去除两端空格
 *
 *  @return 去除后的字符串
 */
- (NSString *)trimOnlyWhitespace{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
}
/**
 *  去除html格式
 *
 *  @param html html文字
 *
 */
+ (NSString *)filterHtml:(NSString *)html{
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([scanner isAtEnd]==NO) {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    NSString *newHtml =[html trim];
    return newHtml;
}
#pragma mark - 根据图片名字返回图片
- (UIImage *)toImage{
    if (self.length  == 0) {
        return nil;
    }
    
    __block UIImage *resultImage = nil;
    NSArray *suffixs = @[@".png", @".jpg", @".jpeg", @".webp"];
    __block BOOL hasSuffix = NO;
    [suffixs enumerateObjectsUsingBlock:^(id  _Nonnull suffix, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self containsString:suffix]) {
            hasSuffix = YES;
            *stop = true;
        }
    }];
    
    if (!hasSuffix) {
        [suffixs enumerateObjectsUsingBlock:^(NSString * _Nonnull suffix, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *imageName = [self stringByAppendingString:suffix];
            NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
            resultImage = [UIImage imageWithContentsOfFile:path];
            if (resultImage) {
                *stop = true;
            }
        }];
    } else {
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self];
        resultImage = [UIImage imageWithContentsOfFile:path];
    }
    
    if (!resultImage) {
        resultImage = [UIImage imageNamed:self];
    }
    
    return resultImage;
}
@end
