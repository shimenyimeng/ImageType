//
//  GXFHttpTool.m
//  GXFHttpTool
//
//  Created by 顾雪飞 on 17/4/11.
//  Copyright © 2017年 顾雪飞. All rights reserved.
//

#import "GXFHttpTool.h"
#import <AFNetworking.h>

static NSString *kBaseURL = @"";

@implementation GXFHttpTool

+ (instancetype)shareHttpTool {
    
    static GXFHttpTool *httpTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        httpTool = [[GXFHttpTool alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL] sessionConfiguration:configuration];
        
        // 接收参数的类型
        httpTool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        
        httpTool.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpTool.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // 超时时长
        httpTool.requestSerializer.timeoutInterval = 15.0;
        
        // 安全策略
//        httpTool.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return httpTool;
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    // 拼接完整URL
    NSString *url = [kBaseURL stringByAppendingString:path];
    
    [[self shareHttpTool] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    // 拼接完整URL
    NSString *url = [kBaseURL stringByAppendingString:path];
    
    [[self shareHttpTool] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}

+ (void)downLoadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownLoadProgressBlock)progress {
    
    // 拼接完整URL
    NSString * urlString = [kBaseURL stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[self shareHttpTool] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}


+ (void)upLoadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)imageKey image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUpLoadProgressBlock)progress {
    
    
    NSString * urlString = [kBaseURL stringByAppendingPathComponent:path];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    [[self shareHttpTool] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

@end
