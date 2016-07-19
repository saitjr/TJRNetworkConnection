//
//  ViewController.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

/**
 *  这是网络请求框架的第一层
 *  这一层一般为视图控件（即UI）层。
 *  
 *  实现：
 *  1. 按钮（或自动）触发一个响应事件时
 *  2. 获取需要传递的参数
 *  3. 调用第二层方法，传递参数以及配置请求完成后的回调方法
 */

#import "ViewController.h"
#import "RequestBase+Article.h"

@interface ViewController ()

- (IBAction)requestButtonTapped:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)requestButtonTapped:(UIButton *)sender {
    [RequestBase requestArticleWithUserId:@"1" callback:^(NSError *error, id result) {
        NSLog(@"error %@", error);
        // 已经在 RequestBase+Article中，将返回的dic+array转为了vc能直接使用的model
        NSLog(@"%@", result);
    }];
}

@end