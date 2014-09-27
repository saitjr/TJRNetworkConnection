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
#import "RequestBase+GetSynchronizeRequest.h"
#import "RequestBase+GetAsynchronizeRequest.h"
#import "RequestBase+PostSynchronizeRequest.h"
#import "RequestBase+PostAsynchronizeRequest.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *getSynchronizeRequestButton;
@property (strong, nonatomic) IBOutlet UIButton *getAsynchronizeRequestButton;

@property (strong, nonatomic) IBOutlet UIButton *postSynchronizeRequestButton;
@property (strong, nonatomic) IBOutlet UIButton *postAsynchronizeRequestButton;

- (IBAction)getSynchronizeRequestButtonPressed:(id)sender;
- (IBAction)getAsynchronizeRequestButtonPressed:(id)sender;
- (IBAction)postSynchronizeRequestButtonPressed:(id)sender;
- (IBAction)postAsynchronizeRequestButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getSynchronizeRequestButtonPressed:(id)sender {
    
    [RequestBase getRequestWithLat:@"30.575413" lon:@"104.064359" source:@"100000" count:@"50" callback:^(NSError *error, NSMutableDictionary *result) {
        
        if (!error) {
            NSLog(@"%@", result);
        }
    }];
}

- (IBAction)getAsynchronizeRequestButtonPressed:(id)sender {
    
    [RequestBase getRequestWithG:@"ApiGGC" m:@"Public" c:@"getConstantList" type:@"relation_type" callback:^(NSError *error, NSMutableDictionary *result) {
        
        if (!error) {
            
            NSLog(@"%@", result);
        }
    }];
}

- (IBAction)postSynchronizeRequestButtonPressed:(id)sender {
    
    [RequestBase postRequestWithLat:@"30.575413" lon:@"104.064359" source:@"100000" count:@"50" callback:^(NSError *error, NSMutableDictionary *result) {
        
        if (!error) {
            NSLog(@"%@", result);
        }
    }];
}

- (IBAction)postAsynchronizeRequestButtonPressed:(id)sender {
    
    [RequestBase postRequestWithG:@"ApiGGC" m:@"Public" c:@"getConstantList" type:@"relation_type" callback:^(NSError *error, NSMutableDictionary *result) {
        
        if (!error) {
            
            NSLog(@"%@", result);
        }
    }];
}
@end
