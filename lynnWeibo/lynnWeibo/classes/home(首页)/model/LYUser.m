//
//  LYStatusUser.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYUser.h"

@implementation LYUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
    
}

@end
