//
//  UITextView+ZPTextView.m
//  ZPCategory
//
//  Created by 张鹏 on 2019/4/1.
//  Copyright © 2019 c4ibD3. All rights reserved.
//

#import "UITextView+ZPTextView.h"
@implementation UITextView (ZPTextView)
@dynamic placeHolder;
@dynamic placeHolderFont;
- (void)setPlaceHolder:(NSString *)placeHolder {
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeHolder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor colorWithRed:118/255.0 green:118/255.0 blue:118/255.0 alpha:1];
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    placeHolderLabel.font = self.font;
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
@end
