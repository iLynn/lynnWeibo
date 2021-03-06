//
//  LYSinaAccount.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYSinaAccount.h"

@implementation LYSinaAccount

+(id)sinaAccountWithDict:(NSDictionary *)dict
{
    LYSinaAccount * account = [[self alloc]init];
    
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    //name是单独获取，单独赋值的
    //account.name = dict[@"name"];
    
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];

    
    return account;
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    
}


@end
