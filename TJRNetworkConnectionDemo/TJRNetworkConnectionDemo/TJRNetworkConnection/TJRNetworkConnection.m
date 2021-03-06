//
//  TJRNetworkConnection.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

/**
 *  这是网络请求框架的第三层。
 *  这一层的任务主要是发起网络请求，获取网络返回值并解析。解析完成后，调用回调
 *  
 *  实现：
 *  1. 实现四个请求方法（GET同步、GET异步、POST同步、POST异步）
 *  2. 其中GET的两个方法，参数都是配置在URL上的，POST的两个参数都是配置在httpbody上的
 *  3. 实现异步请求代理方法
 *  4. 试用JSON解析接收到的数据
 *
 *  第三层是网络请求层，也可以换成三方的网络请求
 */

#import "TJRNetworkConnection.h"

@interface TJRNetworkConnection () <NSURLConnectionDataDelegate> {
    
    NSMutableData *_responseData; // response data
}

@property (nonatomic, copy) Callback callback;

@end

@implementation TJRNetworkConnection

#pragma mark - 发起四种请求

/**
 *  发起GET同步请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
- (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    // 发起请求
    NSError *error = nil;
    // 接收请求返回数据
    NSData *data = [NSURLConnection sendSynchronousRequest:[self configGetUrlRequestWithMethod:method parameters:parameters] returningResponse:nil error:&error];
    
    if (error) {
        
        // 如果出错，就输出错误，并回调
        NSLog(@"request did failed with error message '%@'", [error localizedDescription]);
        callback(error, nil);
    } else {
        
        // JSON解析，回调
        NSMutableDictionary *object = [self JSONObjectWithData:data];
        callback(nil, object);
    }
}

/**
 *  发起GET异步请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
- (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    self.callback = callback;
    
    [NSURLConnection connectionWithRequest:[self configGetUrlRequestWithMethod:method parameters:parameters] delegate:self];
}

/**
 *  发起POST同步请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
- (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    // 发起请求
    NSError *error = nil;
    // post参数配置(configPostURLRequestWithMethod会在后面介绍) 接收请求返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:[self configPostURLRequestWithMethod:method parameters:parameters] returningResponse:nil error:&error];
    
    if (error) {
        
        // 如果出错，就输出错误，并回调
        NSLog(@"request did failed with error message '%@'", [error localizedDescription]);
        callback(error, nil);
    } else {
        
        // JSON解析，回调
        NSMutableDictionary *object = [self JSONObjectWithData:data];
        callback(nil, object);
    }
}

/**
 *  发起POST异步请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param callback   回调方法
 */
- (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    self.callback = callback;
    
    [NSURLConnection connectionWithRequest:[self configPostURLRequestWithMethod:method parameters:parameters] delegate:self];

}

/**
 *  发起POST异步带图片请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param pictures   图片
 *  @param callback   回调方法
 */
- (void)sendPostAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters pictures:(NSDictionary *)pictures callback:(Callback)callback {
    
    self.callback = callback;

    [NSURLConnection connectionWithRequest:[self configPostRequestWithMethod:method parameters:parameters pictures:pictures] delegate:self];
}

#pragma mark - 配置GET/POST请求

/**
 *  配置GET请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *
 *  @return 配置完成的请求
 */
- (NSURLRequest *)configGetUrlRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters {
    
    // 因为GET的参数是拼接在URL地址后面的，所以将method参数copy为可变字符串
    NSMutableString *httpBodyString = [method mutableCopy];
    
    // GET请求的URL地址在参数前，需要加上?，表示参数列表开始
    [httpBodyString appendString:@"?"];
    
    // 循环将参数拼接到URL后面
    for (NSString *key in parameters) {

        [httpBodyString appendFormat:@"%@=%@&", key, [parameters objectForKey:key]];
    }
    
    // 将string转为URL
    NSURL *url = [NSURL URLWithString:httpBodyString];
    //通过url生成网络请求
    return [NSURLRequest requestWithURL:url];
}

/**
 *  配置POST请求
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *
 *  @return 配置完成的请求
 */
- (NSURLRequest *)configPostURLRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters {
    
    // POST请求的参数是放在httpbody中的，所以可以先将请求地址转为url
    NSURL *url = [NSURL URLWithString:method];
    // 需要不停地拼接参数，所以request需要是可变的
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 配置请求方法
    request.HTTPMethod = @"POST";
    // 请求超时时长
    request.timeoutInterval = 10;
    
    // 配置请求参数
    NSMutableString *httpBodyString = [NSMutableString string];
    for (NSString *key in parameters) {
        
        [httpBodyString appendFormat:@"%@=%@&", key, [parameters objectForKey:key]];
    }
    // 将参数加在httpbody中
    request.HTTPBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    return request;
}

/**
 *  配置POST带图片参数
 *
 *  @param method     网络请求地址
 *  @param parameters 参数
 *  @param pictures   图片参数
 *
 *  @return 配置完成的请求
 */
- (NSURLRequest *)configPostRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters pictures:(NSDictionary *)pictures {
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:method]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:20];
    //分界线 --AaB03x
    NSString *boundary = [NSString stringWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary = [NSString stringWithFormat:@"%@--",boundary];
    //要上传的图片
    NSString *pictureKey = [[pictures allKeys] firstObject];
    UIImage *image = [pictures objectForKey:pictureKey];
    //得到图片的data
    NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body = [NSMutableString string];
    //参数的集合的所有key的集合
    NSArray *keys = [parameters allKeys];
    
    //遍历keys
    for (int i = 0; i < [keys count]; i ++) {
        
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if (![key isEqualToString:pictureKey])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n", boundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
            //添加字段的值
            [body appendFormat:@"%@\r\n", [parameters objectForKey:key]];
        }
    }
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n", boundary];
    //声明pic字段，文件名为boris.png
    NSString *format = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"boris.png\"\r\n", pictureKey];
    [body appendFormat:@"%@", format];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end = [NSString stringWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData = [NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    return request;
}

#pragma mark - JSON解析返回数据

/**
 *  JSON解析返回数据
 *
 *  @param data 返回的数据
 *
 *  @return 解析为JSON对象
 */
- (id)JSONObjectWithData:(NSData *)data {
    
    // 如果没有数据返回，则直接不解析
    if (data.length == 0) {
        
        return nil;
    }
    
    // 初始化解析错误
    NSError *error = nil;
    
    // JSON解析
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return object;
}

#pragma mark - NSURLConnectionDataDelegate methods

/**
 *  接收到数据时的代理
 *
 *  @param connection 网络连接
 *  @param data       接收到的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    if (!_responseData) {
        
        _responseData = [[NSMutableData alloc] init];
    }
    
    // 在数据量较大时，会多次走这个方法，接收数据，需要将每次接收到的数据拼接起来
    [_responseData appendData:data];
}

/**
 *  请求完成代理
 *
 *  @param connection 网络连接
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // 关闭网络连接
    [connection cancel];
    
    // JSON解析
    id object = [self JSONObjectWithData:_responseData];
    
    // 将接收数据的参数赋空，用于下次请求继续接收新的数据
    _responseData.length = 0;
    
    // 如果有回调方法，则走回调方法
    if (_callback) {
        
        _callback(nil, object);
    }
    // 释放回调方法
    self.callback = nil;
}

/**
 *  请求出错代理
 *
 *  @param connection 网络连接
 *  @param error      错误
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    // 关闭网络连接
    [connection cancel];
    
    // 如果有回调方法，则走回调方法
    if (_callback) {
        
        _callback(error, nil);
    }
    // 释放回调方法
    self.callback = nil;
}

@end