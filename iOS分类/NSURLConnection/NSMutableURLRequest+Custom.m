//
//  NSMutableURLRequest+Custom.m
//  Post上传文件
//
//  Created by ziboow on 15/12/26.
//  Copyright (c) 2015年 ziboow. All rights reserved.
//

#import "NSMutableURLRequest+Custom.h"

static NSString * boundary = @"boundary";

@implementation NSMutableURLRequest (Custom)

+ (instancetype) requestWithURL:(NSURL *)URL andShowFileName:(NSString *)showFileName andUploadFileName:(NSString *)uploadFileName{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:URL cachePolicy:1 timeoutInterval:2.0];
    
    request.HTTPMethod = @"post";
    
    NSMutableData *uploadData = [NSMutableData data];
    
    NSString *uploadDataString = [NSString stringWithFormat:@"\r\n--%@\r\n",boundary];
    [uploadData appendData:[uploadDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    uploadDataString = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\" \r\n",showFileName]; // userfile 对应后台程序上传文件的变量名称
    [uploadData appendData:[uploadDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    uploadDataString = @"Content-Type: application/octet-stream\r\n\r\n";
    [uploadData appendData:[uploadDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *uploadPath = [[NSBundle mainBundle] pathForResource:uploadFileName ofType:nil];
    [uploadData appendData:[NSData dataWithContentsOfFile:uploadPath]];
    
    uploadDataString = [NSString stringWithFormat:@"\r\n--%@\r\n",boundary];
    [uploadData appendData:[uploadDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPBody = uploadData; // 设置请求体
    
    uploadDataString = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [request setValue:uploadDataString forHTTPHeaderField:@"Content-Type"]; //设置请求头部
    
    return request;
}


@end
