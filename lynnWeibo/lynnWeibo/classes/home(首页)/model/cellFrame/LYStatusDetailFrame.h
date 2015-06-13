//
//  LYStatusDetailFrame.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYStatus, LYDetailOriginalFrame, LYDetailRetweetFrame;

@interface LYStatusDetailFrame : NSObject

/** 原创微博区域frame */
@property (nonatomic, strong) LYDetailOriginalFrame * originalFrame;

/** 转发微博区域frame */
@property (nonatomic, strong) LYDetailRetweetFrame * retweetFrame;

/** 整个detail区域frame */
@property (nonatomic, assign) CGRect frame;


/** 根据内容，填充计算 */
@property (nonatomic, strong) LYStatus * status;

@end
