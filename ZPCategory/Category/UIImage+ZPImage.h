//
//  UIImage+ZPImage.h
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/2.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZPImage)

/**
 返回相片的主要颜色

 @param image 图片
 @return 返回的颜色色值
 */
+ (UIColor*)mostColor:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
