//
//  LYDetailOriginalFrame.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYStatus;

@interface LYDetailOriginalFrame : NSObject

/** 昵称Frame */
@property (nonatomic, assign) CGRect nameFrame;

/** 时间Frame */
@property (nonatomic, assign) CGRect timeFrame;

/** 来源Frame */
@property (nonatomic, assign) CGRect sourceFrame;

/** 正文Frame */
@property (nonatomic, assign) CGRect contentFrame;

/** 头像Frame */
@property (nonatomic, assign) CGRect iconFrame;

/** 整个detail区域frame */
@property (nonatomic, assign) CGRect frame;


/** 根据内容，填充计算 */
@property (nonatomic, strong) LYStatus * status;


@end
