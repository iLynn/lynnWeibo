//
//  LYSinaAccount.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSinaAccount : NSObject<NSCoding>


/** 用于调用access_token，接口获取授权后的access token。 */
@property (nonatomic, strong) NSString * access_token;

/** access_token的生命周期，单位是秒数。 */
@property (nonatomic, strong) NSString * expires_in;

/** 当前授权用户的UID */
@property (nonatomic, strong) NSString * uid;


/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString * name;


+(id)sinaAccountWithDict:(NSDictionary *)dict;

@end
