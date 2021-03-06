//
//  LYStatusUser.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUser : NSObject

/** 显示名称 */
@property (nonatomic, copy) NSString * name;

/** 用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString * profile_image_url;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

@property (nonatomic, assign, getter = isVip, readonly) BOOL vip;

@end
