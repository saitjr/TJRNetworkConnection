//
//  RequestBase+Article.m
//  TJRNetworkConnectionDemo
//
//  Created by tangjr on 7/19/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "RequestBase+Article.h"
#import "Article.h"

@implementation RequestBase (Article)

+ (void)requestArticleWithUserId:(NSString *)userId callback:(Callback)callback {
    NSDictionary *parameters = @{@"userId" : userId};
    
    [RequestBase sendGetAsynchronizeRequestWithMethod:@"http://jsonplaceholder.typicode.com/posts" parameters:parameters callback:^(NSError *error, id result) {
        if (error) {
            callback(error, nil);
            return;
        }
        NSArray *resultArray = result;
        NSMutableArray *articles = [NSMutableArray new];
        for (NSDictionary *dic in resultArray) {
            Article *article = [Article articleWithDic:dic];
            [articles addObject:article];
        }
        callback(nil, articles);
    }];
}

@end