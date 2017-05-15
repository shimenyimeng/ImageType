//
//  GXFHttpTool.h
//  GXFHttpTool
//
//  Created by 顾雪飞 on 17/4/11.
//  Copyright © 2017年 顾雪飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface GXFHttpTool : AFHTTPSessionManager

typedef void (^HttpSuccessBlock)(id json);

typedef void (^HttpFailureBlock)(NSError *error);

typedef void (^HttpDownLoadProgressBlock)(CGFloat progress);

typedef void (^HttpUpLoadProgressBlock)(CGFloat progress);

+ (instancetype)shareHttpTool;

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

+ (void)downLoadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownLoadProgressBlock)progress;


+ (void)upLoadImageWithPath:(NSString *)path params:(NSDictionary *)params thumbName:(NSString *)imageKey image:(UIImage *)image success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUpLoadProgressBlock)progress;
@end
