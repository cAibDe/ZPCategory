//
//  NSNumber+Extension.h
//  ZPCategory
//
//  Created by 张鹏 on 2020/11/16.
//  Copyright © 2020 c4ibD3. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Extension)

/// 去掉浮点型的不必要的0
- (NSString *)zp_description;

@end

NS_ASSUME_NONNULL_END
