//
//  UIImage+image.m
//  新浪微博-01
//
//  Created by ziboow on 15/12/31.
//  Copyright (c) 2015年 ziboow. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

#pragma mark 不对 UIImage 进行渲染
+ (instancetype)imageWithOriginalRenderName:(NSString *)imageName {
   return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
