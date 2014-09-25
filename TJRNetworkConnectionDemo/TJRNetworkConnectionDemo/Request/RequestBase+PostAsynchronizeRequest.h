//
//  RequestBase+PostAsynchronizeRequest.h
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-26.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (PostAsynchronizeRequest)

+ (void)postRequestWithG:(NSString *)g m:(NSString *)m c:(NSString *)c type:(NSString *)type callback:(Callback)callback;

@end
