//
//  ViewController.m
//  063-- 判断文件的图片类型
//
//  Created by 顾雪飞 on 17/5/15.
//  Copyright © 2017年 顾雪飞. All rights reserved.
//

#import "ViewController.h"
#import <YYImage.h>
#import <UIImageView+WebCache.h>
#import "GXFHttpTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dong" ofType:nil]];
//    
//    CFDataRef cfData = CFBridgingRetain(data);
//    YYImageType type = YYImageDetectType(cfData);
    
    // https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494823850283&di=9c7eeacc8fe75325fe2d5cc56e9c1520&imgtype=0&src=http%3A%2F%2Fmvimg1.meitudata.com%2F54df069c4df662588.jpg
    
    [GXFHttpTool getWithPath:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494824621153&di=551a4fc2e9cbcd84212f876117b29e5c&imgtype=0&src=http%3A%2F%2Fmvimg2.meitudata.com%2F56251d715562b5913.jpg" params:nil success:^(id json) {
        
//        NSLog(@"%@", json);
        CFDataRef cfData = CFBridgingRetain(json);
        YYImageType type = YYImageDetectType(cfData);
        NSLog(@"%zd", type);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
    
}


@end
