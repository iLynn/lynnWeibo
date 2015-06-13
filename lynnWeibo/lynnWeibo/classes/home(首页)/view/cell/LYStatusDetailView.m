//
//  LYStatusDetailView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYStatusDetailView.h"
#import "LYDetailOriginalView.h"
#import "LYDeatilRetweetView.h"
#import "LYStatusDetailFrame.h"

@interface LYStatusDetailView()

/** 原创微博 */
@property (nonatomic, weak) LYDetailOriginalView * original;

/** 转发微博 */
@property (nonatomic, weak) LYDeatilRetweetView * retweet;

@end

@implementation LYStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.添加原创微博区
        LYDetailOriginalView * original = [[LYDetailOriginalView alloc] init];
        [self addSubview:original];
        
        self.original = original;
        
        //2.添加转发微博区
        LYDeatilRetweetView * retweet = [[LYDeatilRetweetView alloc] init];
        [self addSubview:retweet];
        
        self.retweet = retweet;
    }
    
    return self;
}

- (void)setDetailFrame:(LYStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.original.originalFrame = detailFrame.originalFrame;
    
    // 2.原创转发的frame数据
    self.retweet.retweetFrame = detailFrame.retweetFrame;
}


@end
