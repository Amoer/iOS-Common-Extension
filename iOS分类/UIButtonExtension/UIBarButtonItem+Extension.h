//
//  UIBarButtonItem+Extension.h
//  新浪微博-01
//
//  Created by ziboow on 16/1/1.
//  Copyright (c) 2016年 ziboow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highlightImage;

@end
