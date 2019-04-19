# ZPCategory

## 目录
***
1. **宏文件**
2. **NSString**
3. **NSDate**
4. **NSTimer**
5. **NSDictionary**
6. **UITextField**
7. **UITextView**
8. **UIButton**
9. **UIImage**
10. **UIViewController**  

***  

## 宏文件
这个文件中主要有以下几个功能：  
1. 开发环境和正式环境的配置；  
2. 项目中集成的第三方的配置；  
3. RGB颜色；  
4. 弱引用self；  
5. 屏幕宽&高；  
6. 状态栏&Tabbar&SafeArea的数值；  
7. 设备的判断；  
***  

## NSString  

### 字符串宽度&&高度  
1.根据字体&高度，获取字符串的宽度（没有行高）
```objc
- (float)widthWithFont:(UIFont *)font height:(float)height;
```
2.根据字体&宽度，获取字符串的高度（没有行高）
```objc
- (float)heightWithFont:(UIFont *)font width:(float)width;
```
3.根据字体&宽度&行高，获取字符串改的高度；
```objc
- (float)heightWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing;
```
4.根据字体&宽度&行高，获取字符串的Size；
```objc
- (CGSize)sizeWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing;
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
1.NSString->NSAttributedString 带有行高属性
```objc
- (NSAttributedString *)toAttributeStringWithLineSpacing:(float)lineSpacing;
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
## UITextView

### 增加 placeHolder & placeHolderFont 属性
```objc
@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIFont *placeHolderFont;
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
