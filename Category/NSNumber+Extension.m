//
//  NSNumber+Extension.m
//  ZPCategory
//
//  Created by 张鹏 on 2020/11/16.
//  Copyright © 2020 c4ibD3. All rights reserved.
//

#import "NSNumber+Extension.h"

@implementation NSNumber (Extension)

- (NSString *)zp_description {
    if (self.description.length >= 16) {
        return @([self floatValue]).description;
    }
    return self.description;
}

@end
