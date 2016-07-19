//
//  TJRNetworkConnection.h
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Callback)(NSError *error, id result);

@interface TJRNetworkConnection : NSObject

- (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
- (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;

- (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
- (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;

- (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters pictures:(NSDictionary *)pictures callback:(Callback)callback;

@end