//
//  Macro.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//环境配置
#ifdef DEBUG
//开发环境
#   define BASE_URL_API     @""
#   define BASE_URL_IMAGE   @""  //图片域名地址
#   define BASE_URL_SHARE   @"" //分享链接地址
#else
//正式环境
#   define BASE_URL_API     @""
#   define BASE_URL_IMAGE   @""
#   define BASE_URL_SHARE   @"" //分享链接地址
#endif


//TODO: 各种第三方的key配置

//RGB 颜色
#define UIColorFromRGB(r,g,b) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:1]

//弱引用self
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

//状态栏高度
#define StatusBarHeight (IS_iPhoneX ? 44.f : 20.f)
//导航栏高度
#define NavBarHeight (44.f+StatusBarHeight)
//底部标签栏高度
#define TabBarHeight (IS_iPhoneX ? (49.f+34.f) : 49.f)
//安全区域高度
#define BottomSafeAreaHeight (IS_iPhoneX ? 34.f : 0.f)


#endif /* Macro_h */
