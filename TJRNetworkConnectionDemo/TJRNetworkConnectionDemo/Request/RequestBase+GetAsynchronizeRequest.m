//
//  RequestBase+GetAsynchronizeRequest.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase+GetAsynchronizeRequest.h"

@implementation RequestBase (GetAsynchronizeRequest)

+ (void)getRequestWithG:(NSString *)g m:(NSString *)m c:(NSString *)c type:(NSString *)type callback:(Callback)callback {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:g forKey:@"g"];
    [parameters setObject:m forKey:@"m"];
    [parameters setObject:c forKey:@"c"];
    [parameters setObject:type forKey:@"type"];
    
    [self sendGetAsynchronizeRequestWithMethod:@"http://125.70.10.34:8119/ggc/api.php" parameters:parameters callback:callback];
}

@end