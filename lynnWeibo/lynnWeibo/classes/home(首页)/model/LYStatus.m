//
//  LYWeiboStatus.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYStatus.h"
#import "LYStatusPhoto.h"
#import "MJExtension.h"

@implementation LYStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [LYStatusPhoto class]};
}

@end
