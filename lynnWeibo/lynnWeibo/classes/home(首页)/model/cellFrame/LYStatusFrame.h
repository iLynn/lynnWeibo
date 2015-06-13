//
//  LYStatusFrame.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYStatus, LYStatusDetailFrame;

@interface LYStatusFrame : NSObject

/** 微博内容区域frame */
@property (nonatomic, strong) LYStatusDetailFrame * detailFrame;

/** toolbar区域frame */
@property (nonatomic, assign) CGRect toolbarFrame;

/** 自己的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


/**
 *  根据LYStatus的数据，计算frame
 */
@property (nonatomic, strong) LYStatus * status;

@end
