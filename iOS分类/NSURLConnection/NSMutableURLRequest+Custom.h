//
//  NSMutableURLRequest+Custom.h
//  Post上传文件
//
//  Created by ziboow on 15/12/26.
//  Copyright (c) 2015年 ziboow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (Custom)

+ (instancetype) requestWithURL:(NSURL *)URL andShowFileName:(NSString *)showFileName andUploadFileName:(NSString *)uploadFileName;

@end
