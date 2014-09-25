//
//  TJRNetworkConnection.m
//  TJRNetworkConnectionDemo
//
//  Created by TangJR on 14-9-25.
//  Copyright (c) 2014年 tangjr. All rights reserved.
//

#import "TJRNetworkConnection.h"

@interface TJRNetworkConnection () <NSURLConnectionDataDelegate> {
    
    NSMutableData *_responseData; // response data
}

@property (nonatomic, copy) Callback callback;

@end

@implementation TJRNetworkConnection

- (id)init {
    
    if (self = [super init]) {
        
        _responseData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)sendGetSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    // 发起请求
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:[self configGetUrlRequestWithMethod:method parameters:parameters] returningResponse:nil error:&error];
    
    if (error) {
        
        NSLog(@"request did failed with error message '%@'", [error localizedDescription]);
        callback(error, nil);
    } else {
        
        NSMutableDictionary *object = [self JSONObjectWithData:data];
        callback(nil, object);
    }
}

- (void)sendGetAsynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    self.callback = callback;
    
    [NSURLConnection connectionWithRequest:[self configPostURLRequestWithMethod:method parameters:parameters] delegate:self];
}

- (void)sendPostSynchronizeRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    // 发起请求
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:[self configPostURLRequestWithMethod:method parameters:parameters] returningResponse:nil error:&error];
    
    if (error) {
        
        NSLog(@"request did failed with error message '%@'", [error localizedDescription]);
        callback(error, nil);
    } else {
        
        NSMutableDictionary *object = [self JSONObjectWithData:data];
        callback(nil, object);
    }
}

- (NSURLRequest *)configGetUrlRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters {
    
    NSMutableString *httpBodyString = [method mutableCopy];
    [httpBodyString appendString:@"?"];
    for (NSString *key in parameters) {

        [httpBodyString appendFormat:@"%@=%@&", key, [parameters objectForKey:key]];
    }
    NSURL *url = [NSURL URLWithString:httpBodyString];
    return [NSURLRequest requestWithURL:url];
}

- (NSURLRequest *)configPostURLRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters {
    
    NSURL *url = [NSURL URLWithString:method];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    
    // if post data is not nil, set http body
    if (parameters) {
        
        // initialize httpBodyString
        NSMutableString *httpBodyString = [NSMutableString string];
        for (NSString *key in parameters) {
            
            [httpBodyString appendFormat:@"%@=%@&", key, [parameters objectForKey:key]];
        }
        request.HTTPBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    }
    return request;
}

- (id)JSONObjectWithData:(NSData *)data {
    
    if (data.length == 0) {
        
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return object;
}

#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // initialize data buffer zone
    if (!_responseData) {
        
        _responseData = [[NSMutableData alloc] init];
    }
    // append data
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [connection cancel];
    
    id object = [self JSONObjectWithData:_responseData];
    _responseData.length = 0;
    if (_callback) {
        
        _callback(nil, object);
    }
    self.callback = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [connection cancel];
    if (_callback) {
        
        _callback(error, nil);
    }
    self.callback = nil;
}

@end