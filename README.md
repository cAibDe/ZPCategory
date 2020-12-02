# ZPCategory

## 目录
***
1. **NSString**
2. **NSDate**
3. **NSTimer**
4. **NSDictionary**
5. **UITextField**
6. **UIButton**
7. **UIImage**
8. **UIViewController**  
9. **UIImage** 
10. **NSNumber** 
***  

## NSString  

### 字符串宽度&&高度  
```objc
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
                      lineSpace:(CGFloat)lineSpace;
```
```objc
/// 计算文字的size
/// @param size 预计的计算的size
/// @param text 文字
/// @param numberOfLine 需要计算的行数
/// @param font 字体
+ (CGSize)calcTextSizeWithSize:(CGSize)size
                          text:(id)text
                  numberOfLine:(NSInteger)numberOfLine
                          font:(UIFont *)font;
```
### 字符串 正则表达式  
1.判断是不是手机号
```objc
- (BOOL)isValidateMobile;
```
2.判断是不是固定电话
```objc
- (BOOL)isValidatePhone;
```
3.判断是不是客服电话
```objc
- (BOOL)is400Phone;
```
4.判断是不是身份证
```objc
- (BOOL)isIdCard;
```

### 数据类型额判断
1.是否是正整数
```objc
- (BOOL)isPositiveInteger;
```
2.是否是浮点数
```objc
- (BOOL)isFloat;
```
3.检查输入字符串是否只由英文字母和数字组成
```objc
- (BOOL)isNumberOrLetter;
```
4.检查输入字符串是否只由汉字和英文字母组成
```objc
- (BOOL)isChineseOrLetter;
```
5.是否为空字符串
```objc
- (BOOL)isBlankString;
```  

### NSString->NSAttributedString
```objc
/**
*  转成NSMutableAttributedString
*
*  @param string    字符串
*  @param font      字体
*  @param lineSpace 行间距
*
*  @return NSAttributedString
*/
- (NSMutableAttributedString *)toAttributeStringWithString:(NSString *)string
                                                      font:(UIFont *)font
                                                 lineSpace:(CGFloat)lineSpace;
```  
### NSString 计算字节长度
```objc 
/**
 计算字符串的字节长度
 * 中文 = 2
 * 英文或者数字 = 1
 * 表情 = 4
 
 @return NSUInteger
 */
- (NSUInteger)charactorNumber;

/**
 根据不同的编码方式计算字节长度
 
 @param encoding 编码方式
 @return NSUInteger
 */
- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding;

/**
 calulate the number of charactor.
 1 Chinese(not including Chinese mark) = 2
 1 other charactor = 1
 
 @return NSUInteger
 */
- (NSUInteger)charactorNumberForChineseSpecial;
```
这是我从github的一位仁兄哪里收集到的[LXKit](https://github.com/lyonxu/LXKit) 想要了解的可以点击进去详细了解。
### 字符串加密
1.MD5
```objc
- (NSString *)md5;
```
2.SHA1
```objc
- (NSString *)SHA1;
```  

### 字符串过滤 
1.去除两端空格和回车
```objc
- (NSString *)trim;
```
2.仅去除两端空格
```objc
- (NSString *)trimOnlyWhitespace;
```
3.去除html格式
```objc
+ (NSString *)filterHtml:(NSString *)html;
```  

### 根据图片名字返回图片
1.根据图片名字返回图片
```objc
- (UIImage *)toImage;
```

***  
## NSDate
1.NSDate -> NSString 
```objc
- (NSString *)formatString:(NSString *)dateFormat;
```
2.根据unix时间戳构造NSDate
```objc
+ (NSDate *)dateWithUnixTime:(double)unixtime;
```
3.将时间转化为0秒模式
```objc
+ (NSDate *)changeDateToZeroMinutDate:(NSDate *)date;
```
4.获得指定月份的第一天和最后一天
```objc
+ (NSArray *)getFirstAndLastDayOfThisMonthWithNsDate:(NSDate *)date;
```  
***  
5.UTC时间转成当地的时间  
```objc
/// UTC时间转成当地的时间
/// @param UTCTime 国际时间
/// @param needDateFormatter 需要的时间格式
+ (NSString *)currentAreaTimeWitthUTCTime:(NSString *)UTCTime
                        needDateFormatter:(NSString *)needDateFormatter;
```
## NSTimer
1.用block的方式穿件定时器
```objc
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)(void))block repeat:(BOOL)repeat;
``` 
***
## NSDictionary  

### 数据类型的Get  
1.设置一个BOOL值
```objc
- (BOOL)boolForKey:(NSString *)key;
```
2.设置一个NSInteger值
```objc
- (NSInteger)integerForKey:(NSString *)key;
```
3.设置一个int值
```objc
- (int)intForKey:(NSString *)key;
```
4.设置一个double值
```objc
- (double)doubleForKey:(NSString *)key;
```
5.设置一个float值
```objc
- (float)floatForKey:(NSString *)key;
```
6.设置一个long long值
```objc
- (long long)longLongForKey:(NSString *)key;
```
7.设置一个unsigned long long值
```objc
- (unsigned long long)unsignedLongLongForKey:(NSString *)key;
```
8.设置一个NSString值
```objc
- (NSString *)stringForKey:(NSString *)key;
```
9.设置一个NSArray值
```objc
- (NSArray *)arrayForKey:(NSString *)key;
```
10.value为空时，不set此key
```objc
- (void)safeValue:(id)value forKey:(NSString *)key;
```
***  
## UITextField
### 最大长度和只可以输入数字的属性添加
```objc
/**
 最大长度
 */
@property (nonatomic, assign) NSInteger maxLength;

/**
 是否只可以输入数字
 */
@property (nonatomic, assign) BOOL canOnlyInputNumber;
```
### LeftView 
1.设置leftview为图片  
```objc
/**
 *  设置leftview为图片
 *
 *  @param imageName 图片名称
 */
- (void)setLeftViewWithImageName:(NSString *)imageName;
```
2.设置leftView为文字  
```objc
/**
 *  设置leftView为文字
 *
 */
- (void)setLeftViewWithText:(NSString *)text;
```
3.设置leftView为文字  
```objc
/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth;
```
4.设置leftView为文字  
```objc
/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 *  @param color 占位文字颜色
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth color:(UIColor *)color;
```

### RightView
1.设置rightView为文字
```objc
/**
 *  设置rightView为文字
 *
 *  @param text 文字
 */
- (void)setRightViewWithText:(NSString *)text;
```
2.设置rightView为图片
```objc
/**
 *  设置rightView为图片
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewWithImageName:(NSString *)imageName;
```
3.设置rightView为button
```objc
/**
 *  设置rightView为button
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewButtonWithImageName:(NSString *)imageName taget:(id)taget selector:(SEL)selector;
```

### Padding
1.设置UITextField左侧内边距
```objc
/**
 *  设置UITextField左侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingLeftSpace:(float)padding;
```
2.设置UITextField右侧内边距
```objc
/**
 *  设置UITextField右侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingRightSpace:(float)padding;
```
### UI显示  
1.设置底部边框
```objc
/**
 *  设置底部边框
 *
 *  @param lineColor 边框颜色
 */
- (void)setBottomBorderLineWithColor:(UIColor *)lineColor;
```
2.设置placeholder的颜色
```objc
/**
 *  设置placeholder的颜色
 *
 */
- (void)setPlaceholderColor:(UIColor *)color;
```
3.设置下划线出去左边的文字
```objc
/**
 *  设置下划线出去左边的文字
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth withOutTextBottomLineColor:(UIColor *)color;
```
***
## UButton
### 点击方式换成block方式
```objc
/**
 *  UIButton+Block
 *
 *  @param controlEvent 触摸事件
 *  @param action 执行的方法
 */
- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;
```
***
## UIImage
### 返回相片的主要颜色
```objc
/**
 返回相片的主要颜色

 @param image 图片
 @return 返回的颜色色值
 */
+ (UIColor*)mostColor:(UIImage *)image;
```
***
## UIViewController
### NavigationBar
1.设置左侧Navigationbar为“返回”（使用backBarButtonItem）
```objc
/**
 *  设置左侧Navigationbar为“返回”（使用backBarButtonItem）
 */
- (void)setLeftNavigationBarToBack;
```
2.设置左侧Navigationbar为“返回”(使用leftbarbutton)
```objc
/**
 *  设置左侧Navigationbar为“返回”(使用leftbarbutton)
 *
 *  @param block 点击时执行的block代码
 */
- (void)setLeftNavigationBarToBackWithBlock:(void (^)(void))block;
```
3.为左侧后退Navigationbar增加确认提示框 
```objc
/**
 *  为左侧后退Navigationbar增加确认提示框
 */
- (void)setLeftNavigationBarToBackWithConfirmDialog;
```
4.设置NavigationBar（文字）
```objc
/**
 *  设置NavigationBar（文字）
 *
 *  @param position 位置
 *  @param text     文字
 *  @param block    点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text touched:(void (^)(void))block;
```
5.设置NavigationBar（图片）
```objc
/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName touched:(void (^)(void))block;
```
6.设置NavigationBar（图片） 
```objc
/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName spacing:(NSInteger)spacing touched:(void (^)(void))block;
```
7.设置NavigationBar（文字）
```objc
/**
 *  设置NavigationBar（文字）
 *
 *  @param position 位置
 *  @param text     文字
 *  @param color    文字颜色
 *  @param block    点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text withColor:(UIColor *)color touched:(void (^)(void))block;
```
8.设置NavigationBar（文字）
```objc
/**
 *  设置NavigationBar（文字）
 *
 *  @param position 位置
 *  @param text     文字
 *  @param color    文字颜色
 *  @param font     字体
 *  @param block    点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text withColor:(UIColor *)color withFont:(UIFont *)font touched:(void (^)(void))block;
```
9.设置NavigationBar隐藏或显示
```objc
/**
 *  设置NavigationBar隐藏或显示
 *
 *  @param position 位置
 *  @param hidden   YES：隐藏 NO：显示
 */
- (void)hiddenNavigationBar:(NavigationBarPosition)position hidden:(BOOL)hidden;
```
10.跳转到指定的ViewController 
```objc
/**
 *  跳转到指定的ViewController
 *
 *  @param viewControllerClass 控制器类型
 */
- (void)popToViewController:(Class)viewControllerClass;
```
11.NavigationController里上一个ViewController 
```objc
/**
 *  NavigationController里上一个ViewController
 *
 */
- (UIViewController *)previosViewController;
```
12.移除当前NavigationController里ViewController的上一个ViewController
```objc
/**
 *  移除当前NavigationController里ViewController的上一个ViewController
 */
- (void)removePreviosViewControllerInNavigationControllers;
```
13.添加多个按钮时
```objc
/**
 *  添加多个按钮时
 *
 *  @param position 位置
 *  @param array    buttonImageNameAndButtonTypeArray
 *  @param target   目标
 *  @param selector 响应方法
 */

- (void)setNavigationBar:(NavigationBarPosition)position withImageNameAndButtonTypeArray:(NSArray *)array target:(id)target selectors:(SEL)selector;
```
14.移除navigationbutton
```objc
/**
 *  移除navigationbutton
 *
 *  @param position 位置
 */
- (void)removeNavigationBarBar:(NavigationBarPosition)position;
```
### StoryBoard
1.从storyboard中初始化ViewController
```objc
/**
 *  从storyboard中初始化ViewController
 *
 *  @param storyBoardName storyboard名称
 *  @param identifier     ViewController标识符
 *
 *  @return ViewController实例
 */
+ (instancetype)viewControllerFromStoryBoard:(NSString *)storyBoardName withIdentifier:(NSString *)identifier;
```  
***
## UIImage
```objc
/**
 返回相片的主要颜色

 @param image 图片
 @return 返回的颜色色值
 */
+ (UIColor*)mostColor:(UIImage *)image;
```  
***
## NSNumber  
```objc
/// 去掉浮点型的不必要的0
- (NSString *)zp_description;
```

