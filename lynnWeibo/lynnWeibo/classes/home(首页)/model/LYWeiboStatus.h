//
//  LYWeiboStatus.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYStatusUser;
@class LYWeiboStatus;

@interface LYWeiboStatus : NSObject

/** 微博创建时间 */
@property (nonatomic, copy) NSString * created_at;

/** 字符串型的微博ID */
@property (nonatomic, copy) NSString * idstr;

/** 微博信息内容 */
@property (nonatomic, copy) NSString * text;

/** 微博来源 */
@property (nonatomic, copy) NSString * source;

/** 微博作者的用户信息字段，是一个完整的对象 */
@property (nonatomic, strong) LYStatusUser *user;

/** 被转发的原微博信息字段，当该微博为转发微博时返回，是一个完整的对象 */
@property (nonatomic, strong) LYWeiboStatus *retweeted_status;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;

/** 评论数 */
@property (nonatomic, assign) int comments_count;

/** 点赞数 */
@property (nonatomic, assign) int attitudes_count;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是LYStatusPhoto模型 */
@property (nonatomic, strong) NSArray * pic_urls;

@end
