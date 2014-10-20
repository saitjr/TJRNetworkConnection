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
    
    // 在我的后台中，可以上传一个图片名称，给保存到服务器的图片命名，如果为空，则默认为default
    if (imageName != nil) {
        
        [parameters setObject:imageName forKey:@"imageName"];
    }
    
    NSMutableDictionary *pictures = [NSMutableDictionary dictionary];
    
    // 图片的key根据后台来定
    [pictures setObject:image forKey:@"image"];
    
    [self sendPostAsynchronizeRequestWithMethod:@"http://tjrtest.sinaapp.com/TJRNetworkConnection/UploadImage.php" parameters:parameters pictures:pictures callback:callback];
}

@end