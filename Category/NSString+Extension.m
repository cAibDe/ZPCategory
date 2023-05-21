//
//  NSString+Extension.m
//  ZPCategory
//
//  Created by 张鹏 on 2020/11/16.
//  Copyright © 2020 c4ibD3. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)
#pragma mark - 字符串宽度&&高度
/**
*
*  size             预计的大小
*  font             字体大小
*  alignment        对齐方式
*  linebreakMode    显示模式
*  lineSpace        行间距
*
*/
- (CGSize)calculateRectWithSize:(CGSize)size
                           font:(UIFont *)font
                      alignment:(NSTextAlignment)alignment
                  linebreakMode:(NSLineBreakMode)linebreakMode
                      lineSpace:(CGFloat)lineSpace{
    if (self.length == 0) {
        return CGSizeZero;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = linebreakMode;
    paragraphStyle.alignment = alignment;
    if (lineSpace > 0) {
        paragraphStyle.lineSpacing = lineSpace;
    }
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize rectSize = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:NULL].size;
    
    return CGSizeMake(ceil(rectSize.width), ceil(rectSize.height));
}

/// 计算文字的高度
/// @param size 预计的计算的size
/// @param text 文字
/// @param numberOfLine 需要计算的行数
/// @param font 字体
+ (CGSize)calcTextSizeWithSize:(CGSize)size text:(id)text numberOfLine:(NSInteger)numberOfLine font:(UIFont *)font{
    return calcTextSize(size, text, numberOfLine, font, NSTextAlignmentNatural, NSLineBreakByTruncatingTail,0.0, CGSizeZero);
}
CGSize calcTextSize(CGSize fitsSize, id text, NSInteger numberOfLines, UIFont *font, NSTextAlignment textAlignment, NSLineBreakMode lineBreakMode, CGFloat minimumScaleFactor, CGSize shadowOffset) {
    
    if (text == nil || [text length] <= 0) {
        return CGSizeZero;
    }
    
    NSAttributedString *calcAttributedString = nil;

    //如果不指定字体则用默认的字体。
    if (font == nil) {
        font = [UIFont systemFontOfSize:17];
    }
    
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
        
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = lineBreakMode;
    //系统大于等于11才设置行断字策略。
    if (systemVersion >= 11.0) {
        @try {
            [paragraphStyle setValue:@(1) forKey:@"lineBreakStrategy"];
        } @catch (NSException *exception) {}
    }
        
    if ([text isKindOfClass:NSString.class]) {
        calcAttributedString = [[NSAttributedString alloc] initWithString:(NSString *)text attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
    } else {
        NSAttributedString *originAttributedString = (NSAttributedString *)text;
        //对于属性字符串总是加上默认的字体和段落信息。
        NSMutableAttributedString *mutableCalcAttributedString = [[NSMutableAttributedString alloc] initWithString:originAttributedString.string attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
        
        //再附加上原来的属性。
        [originAttributedString enumerateAttributesInRange:NSMakeRange(0, originAttributedString.string.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            [mutableCalcAttributedString addAttributes:attrs range:range];
        }];
        
        //这里再次取段落信息，因为有可能属性字符串中就已经包含了段落信息。
        if (systemVersion >= 11.0) {
            NSParagraphStyle *alternativeParagraphStyle = [mutableCalcAttributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:NULL];
            if (alternativeParagraphStyle != nil) {
                paragraphStyle = (NSMutableParagraphStyle*)alternativeParagraphStyle;
            }
        }
        
        calcAttributedString = mutableCalcAttributedString;
    }
    
    //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
    fitsSize.height = FLT_MAX;
    if (fitsSize.width <= 0 ) {
        fitsSize.width = FLT_MAX;
    }
        
    //构造出一个NSStringDrawContext
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = minimumScaleFactor;
    @try {
        //因为下面几个属性都是未公开的属性，所以我们用KVC的方式来实现。
        [context setValue:@(numberOfLines) forKey:@"maximumNumberOfLines"];
        if (numberOfLines != 1) {
            [context setValue:@(YES) forKey:@"wrapsForTruncationMode"];
        }
        [context setValue:@(YES) forKey:@"wantsNumberOfLineFragments"];
    } @catch (NSException *exception) {}
       

    //计算属性字符串的bounds值。
    CGRect rect = [calcAttributedString boundingRectWithSize:fitsSize options:NSStringDrawingUsesLineFragmentOrigin context:context];
    
    //需要对段落的首行缩进进行特殊处理！
    //如果只有一行则直接添加首行缩进的值，否则进行特殊处理。。
    CGFloat firstLineHeadIndent = paragraphStyle.firstLineHeadIndent;
    if (firstLineHeadIndent != 0.0 && systemVersion >= 11.0) {
        //得到绘制出来的行数
        NSInteger numberOfDrawingLines = [[context valueForKey:@"numberOfLineFragments"] integerValue];
        if (numberOfDrawingLines == 1) {
            rect.size.width += firstLineHeadIndent;
        } else {
            //取内容的行数。
            NSString *string = calcAttributedString.string;
            NSCharacterSet *charset = [NSCharacterSet newlineCharacterSet];
            NSArray *lines = [string componentsSeparatedByCharactersInSet:charset]; //得到文本内容的行数
            NSString *lastLine = lines.lastObject;
            NSInteger numberOfContentLines = lines.count - (NSInteger)(lastLine.length == 0);  //有效的内容行数要减去最后一行为空行的情况。
            if (numberOfLines == 0) {
                numberOfLines = NSIntegerMax;
            }
            if (numberOfLines > numberOfContentLines)
                numberOfLines = numberOfContentLines;
            
            //只有绘制的行数和指定的行数相等时才添加上首行缩进！这段代码根据反汇编来实现，但是不理解为什么相等才设置？
            if (numberOfDrawingLines == numberOfLines) {
                rect.size.width += firstLineHeadIndent;
            }
        }
    }
    
    //取fitsSize和rect中的最小宽度值。
    if (rect.size.width > fitsSize.width) {
        rect.size.width = fitsSize.width;
    }
    
    //加上阴影的偏移
    rect.size.width += fabs(shadowOffset.width);
    rect.size.height += fabs(shadowOffset.height);
       
    //转化为可以有效显示的逻辑点, 这里将原始逻辑点乘以缩放比例得到物理像素点，然后再取整，然后再除以缩放比例得到可以有效显示的逻辑点。
    CGFloat scale = [UIScreen mainScreen].scale;
    rect.size.width = ceil(rect.size.width * scale) / scale;
    rect.size.height = ceil(rect.size.height *scale) / scale;
    
    return rect.size;
}
/// 计算标签数组的高度
/// - Parameters:
///   - word: 标签数组
///   - maxWidth: 最大宽度
///   - verticalMargin: 列间距
///   - horizontalMargin: 行间距
///   - itemMargin: 单个标签的间距
///   - font: 字体大小
///   - lineHeight: 行高
+ (CGFloat)getTotalHeightWithWords:(NSArray *)word
                          maxWidth:(CGFloat)maxWidth
                    verticalMargin:(CGFloat)verticalMargin
                  horizontalMargin:(CGFloat)horizontalMargin
                        itemMargin:(CGFloat)itemMargin
                              font:(UIFont *)font
                        lineHeight:(CGFloat)lineHeight{
    CGFloat height = 0;
    CGFloat lineWidth = 0;
    int line = ([word count] == 0) ? 0 : 1;
    if (line == 0) {
        return 0;
    }
    for (int i = 0 ; i< word.count ; i ++) {
        NSString *tagString = word[i];
        CGFloat tagStringWidth = [tagString getSizeWithFont:font maxSize:CGSizeMake(CGFLOAT_MAX, 100)].width;
        CGFloat width = tagStringWidth + itemMargin*2;
        if (i != 0) {
            lineWidth += verticalMargin;
        }
        lineWidth += width;
        
        if (lineWidth > maxWidth) {
            line++;
            lineWidth = 0;
            if (i != 0) {
                lineWidth += verticalMargin;
            }
            lineWidth += width;
        }
    }
    height += ((line * lineHeight) + ((line - 1)*horizontalMargin));
    return height;
}
/// 计算文字size
/// - Parameters:
///   - font: 字体
///   - maxSize: 最大宽度
- (CGSize)getSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    CGRect textFrame = [self boundingRectWithSize:maxSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributesDictionary
                                          context:nil];
    CGSize stringSize = textFrame.size;
    return stringSize;
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
*  转成NSMutableAttributedString
*
*  @param string    字符串
*  @param font      字体
*  @param lineSpace 行间距
*
*  @return NSAttributedString
*/
+ (NSMutableAttributedString *)toAttributeStringWithString:(NSString *)string
                                                      font:(UIFont *)font
                                                 lineSpace:(CGFloat)lineSpace{
    NSMutableAttributedString *attStr =  [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [string length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    return attStr;
}
#pragma mark - NSString 计算字节长度
- (NSUInteger)charactorNumber{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:encoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

- (NSUInteger)charactorNumberForChineseSpecial{
    NSUInteger strLength = 0;
    for(int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fa5) { // judging whether it is Chinese
            strLength += 2;
        } else {
            strLength += 1;
        }
    }
    return strLength;
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
