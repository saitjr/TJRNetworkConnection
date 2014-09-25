//
//  RequestBase.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

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

+ (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendGetSynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

+ (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendGetAsynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

+ (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendPostSynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

+ (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    TJRNetworkConnection *connection = [[TJRNetworkConnection alloc] init];
    [connection sendPostAsynchronizeRequestWithMethod:method parameters:parameters callback:callback];
}

@end