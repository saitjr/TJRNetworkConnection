//
//  RequestBase+PostAsynchronizeRequestSendPicture.h
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14/10/19.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (PostAsynchronizeRequestSendPicture)

+ (void)postRequestWithImageName:(NSString *)imageName Image:(UIImage *)image callback:(Callback)callback;

@end