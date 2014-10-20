//
//  RequestBase.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

/**
 *  这是网络请求框架的第二层。
 *  它的任务就是防止第一层（触发网络请求层）和第三层（网络请求层）直接交互。
 *  
 *  实现：
 *  1. 在基类中写一个相同的发起请求方法（也可以是四个：GET同步、GET异步、POST同步、POST异步）
 *  2. 为每一个请求都一个类目
 *  3. 在类目中将第一层给的请求参数和key对应，并且配置请求地址
 *  4. 调用基类中相应方法，让第三层发起网络请求
 */

#import "RequestBase.h"

static RequestBase *networkBase = nil;

@implementation RequestBase

- (id)init
{
    self = [super init];
    return self;
}

+ (RequestBase *)shareNetWorkBase
{
    if(networkBase == nil)
    {
        networkBase = [[RequestBase alloc] init];
    }
    return networkBase;
}

/**
 *  发起get同步请求
 *
 *  @param method     请求的网络地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
+ (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendGetSynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

/**
 *  发起get异步请求
 *
 *  @param method     请求的网络地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
+ (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendGetAsynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

/**
 *  发起post同步请求
 *
 *  @param method     请求的网络地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
+ (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendPostSynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

/**
 *  发起post异步请求
 *
 *  @param method     请求的网络地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
+ (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendPostAsynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

/**
 *  发起POST异步请求并上传图片
 *
 *  @param method     请求的网络地址
 *  @param parameters 参数
 *  @param pictures   图片
 *  @param callback   回调方法
 */
+ (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters pictures:(NSDictionary *)pictures callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendPostAsynchronizeRequestWithMethod:method parameters:parameters pictures:pictures callback:callback];
}

@end