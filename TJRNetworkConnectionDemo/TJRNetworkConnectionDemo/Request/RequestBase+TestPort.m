//
//  RequestBase+TestPort.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 15/1/9.
//  Copyright (c) 2015年 tangjr. All rights reserved.
//

#import "RequestBase+TestPort.h"

@implementation RequestBase (TestPort)

+ (void)sendTestPortRequest {
    
    [RequestBase sendGetAsynchronizeRequestWithMethod:@"http://118.123.246.70/interface/DBinterfacedemo.asp" parameters:nil callback:^(NSError *error, NSMutableDictionary *result) {
        
        NSLog(@"%@", error);
        NSLog(@"%@", result);
    }];
}

@end
