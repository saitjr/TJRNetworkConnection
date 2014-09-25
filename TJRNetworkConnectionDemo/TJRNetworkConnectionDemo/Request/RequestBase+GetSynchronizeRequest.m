//
//  RequestBase+GetSynchronizeRequest.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase+GetSynchronizeRequest.h"

@implementation RequestBase (GetSynchronizeRequest)

+ (void)getRequestWithLat:(NSString *)lat lon:(NSString *)lon source:(NSString *)source count:(NSString *)count callback:(Callback)callback {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:lat forKey:@"lat"];
    [parameters setObject:lon forKey:@"lon"];
    [parameters setObject:source forKey:@"source"];
    [parameters setObject:count forKey:@"count"];

    [self sendGetSynchronizeRequestWithMethod:@"http://api.jiepang.com/v1/locations/search" parameters:parameters callback:callback];
}

@end