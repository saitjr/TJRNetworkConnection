//
//  Article.h
//  TJRNetworkConnectionDemo
//
//  Created by tangjr on 7/19/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (copy, nonatomic) NSNumber *userId;
@property (copy, nonatomic) NSNumber *postId;
@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *title;

+ (instancetype)articleWithDic:(NSDictionary *)dic;

@end