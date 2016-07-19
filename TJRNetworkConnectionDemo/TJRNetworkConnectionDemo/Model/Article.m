//
//  Article.m
//  TJRNetworkConnectionDemo
//
//  Created by tangjr on 7/19/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "Article.h"

@implementation Article

+ (instancetype)articleWithDic:(NSDictionary *)dic {
    Article *article = [Article new];
    article.userId = dic[@"userId"];
    article.postId = dic[@"id"];
    article.title = dic[@"title"];
    article.body = dic[@"body"];
    return article;
}

@end