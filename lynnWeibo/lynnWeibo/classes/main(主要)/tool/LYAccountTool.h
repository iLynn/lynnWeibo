//
//  LYAccountTool.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYSinaAccount;

@interface LYAccountTool : NSObject

/**
 *  存储账号信息
 */
+(void)saveAccount:(LYSinaAccount *)account;


/**
 *  读取账号信息
 */
+(LYSinaAccount *)account;


@end
