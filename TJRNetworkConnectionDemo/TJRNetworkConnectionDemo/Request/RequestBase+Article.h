//
//  RequestBase+Article.h
//  TJRNetworkConnectionDemo
//
//  Created by tangjr on 7/19/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (Article)

+ (void)requestArticleWithUserId:(NSString *)userId callback:(Callback)callback;

@end