//
//  LYStatusDetailFrame.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYStatusDetailFrame.h"
#import "LYDetailOriginalFrame.h"
#import "LYDetailRetweetFrame.h"
#import "LYStatus.h"

@implementation LYStatusDetailFrame

-(void)setStatus:(LYStatus *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    LYDetailOriginalFrame * originalFrame = [[LYDetailOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status)
    {
        LYDetailRetweetFrame * retweetedFrame = [[LYDetailRetweetFrame alloc] init];
        retweetedFrame.retweetStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
        
    }
    else
    {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = LYCellMargin;
    CGFloat w = LYScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end
