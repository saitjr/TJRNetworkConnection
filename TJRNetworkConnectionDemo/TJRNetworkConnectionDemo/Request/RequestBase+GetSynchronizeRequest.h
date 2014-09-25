//
//  RequestBase+GetSynchronizeRequest.h
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (GetSynchronizeRequest)

+ (void)getRequestWithLat:(NSString *)lat lon:(NSString *)lon source:(NSString *)source count:(NSString *)count callback:(Callback)callback;

@end
