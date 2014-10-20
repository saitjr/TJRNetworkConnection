//
//  RequestBase+PostAsynchronizeRequestSendPicture.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14/10/19.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "RequestBase+PostAsynchronizeRequestSendPicture.h"

@implementation RequestBase (PostAsynchronizeRequestSendPicture)

+ (void)postRequestWithImageName:(NSString *)imageName Image:(UIImage *)image callback:(Callback)callback {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:imageName forKey:@"imageName"];
    
    NSMutableDictionary *pictures = [NSMutableDictionary dictionary];
    
    [pictures setObject:image forKey:@"image"];
    
    [self sendPostAsynchronizeRequestWithMethod:@"http://tjrtest.sinaapp.com/TJRNetworkConnection/UploadImage.php" parameters:parameters pictures:pictures callback:callback];
}

@end