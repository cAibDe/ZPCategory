//
//  UIViewController+ZPViewController.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 导航栏的按钮位置
 
 - NavigationBarPositionLeft: 导航栏左侧
 - NavigationBarPositionRight: 导航栏右侧
 */
typedef NS_ENUM(NSInteger, NavigationBarPosition){
    NavigationBarPositionLeft,
    NavigationBarPositionRight
};

/**
 导航栏右侧的按钮类型
 
 - NativigationButtonTypeMore: 更多
 - NativigationButtonTypeShare: 分享
 */
typedef NS_ENUM(NSInteger, NativigationButtonType) {
    NativigationButtonTypeMore,
    NativigationButtonTypeShare,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZPViewController)

#pragma mark - NavigationBar

/**
 *  设置左侧Navigationbar为“返回”（使用backBarButtonItem）
 */
- (void)setLeftNavigationBarToBack;

/**
 *  设置左侧Navigationbar为“返回”(使用leftbarbutton)
 *
 *  @param block 点击时执行的block代码
 */
- (void)setLeftNavigationBarToBackWithBlock:(void (^)(void))block;

/**
 *  为左侧后退Navigationbar增加确认提示框
 */
- (void)setLeftNavigationBarToBackWithConfirmDialog;

/**
 *  设置NavigationBar（文字）
 *
 *  @param position 位置
 *  @param text     文字
 *  @param block    点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text touched:(void (^)(void))block;

/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName touched:(void (^)(void))block;
/**
 *  设置NavigationBar（图片）
 *
 *  @param position  位置
 *  @param imageName 图片名称
 *  @param block     点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withImageName:(NSString *)imageName spacing:(NSInteger)spacing touched:(void (^)(void))block;

/**
 *  设置NavigationBar（文字）
 *
 *  @param position 位置
 *  @param text     文字
 *  @param color    文字颜色
 *  @param block    点击后执行的代码
 */
- (void)setNavigationBar:(NavigationBarPosition)position withText:(NSString *)text withColor:(UIColor *)color touched:(void (^)(void))block;

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

/**
 *  设置NavigationBar隐藏或显示
 *
 *  @param position 位置
 *  @param hidden   YES：隐藏 NO：显示
 */
- (void)hiddenNavigationBar:(NavigationBarPosition)position hidden:(BOOL)hidden;

/**
 *  跳转到指定的ViewController
 *
 *  @param viewControllerClass 控制器类型
 */
- (void)popToViewController:(Class)viewControllerClass;

/**
 *  NavigationController里上一个ViewController
 *
 */
- (UIViewController *)previosViewController;

/**
 *  移除当前NavigationController里ViewController的上一个ViewController
 */
- (void)removePreviosViewControllerInNavigationControllers;

/**
 *  添加多个按钮时
 *
 *  @param position 位置
 *  @param array    buttonImageNameAndButtonTypeArray
 *  @param target   目标
 *  @param selector 响应方法
 */

- (void)setNavigationBar:(NavigationBarPosition)position withImageNameAndButtonTypeArray:(NSArray *)array target:(id)target selectors:(SEL)selector;

/**
 *  移除navigationbutton
 *
 *  @param position 位置
 */
- (void)removeNavigationBarBar:(NavigationBarPosition)position;
#pragma mark - StoryBoard
/**
 *  从storyboard中初始化ViewController
 *
 *  @param storyBoardName storyboard名称
 *  @param identifier     ViewController标识符
 *
 *  @return ViewController实例
 */
+ (instancetype)viewControllerFromStoryBoard:(NSString *)storyBoardName withIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
