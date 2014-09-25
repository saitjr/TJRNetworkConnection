//
//  RequestBase.h
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJRNetworkConnection.h"

@interface RequestBase : NSObject

+ (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;

+ (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;

@end
