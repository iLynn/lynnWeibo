//
//  LYAccountTool.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#define LYAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "LYAccountTool.h"
#import "LYSinaAccount.h"

@implementation LYAccountTool

+(void)saveAccount:(LYSinaAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:LYAccountFilepath];
}

+(LYSinaAccount *)account
{
    LYSinaAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:LYAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate * now = [NSDate date];
    
    // 过期:now > expires_time
    if ([now compare:account.expires_time] != NSOrderedAscending)
    {
        account = nil;
    }
    
    return account;
}

@end
