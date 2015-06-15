//
//  LYStatusRetweetView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYDeatilRetweetView.h"
#import "LYDetailRetweetFrame.h"
#import "LYStatus.h"
#import "LYUser.h"

@interface LYDeatilRetweetView()

/** 昵称 */
@property (nonatomic, weak) UILabel * nameLab;

/** 正文 */
@property (nonatomic, weak) UILabel * contentLab;

@end

@implementation LYDeatilRetweetView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置背景
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        //1.昵称
        UILabel * name = [[UILabel alloc] init];
        name.font = LYCustomFontSize;
        name.textColor = LYRetweetFontColor;
        [self addSubview:name];
        
        self.nameLab = name;
        
        //2.正文
        UILabel * content = [[UILabel alloc] init];
        content.font = LYCustomFontSize;
        content.numberOfLines = 0;
        [self addSubview:content];
        
        self.contentLab = content;
    }
    
    return self;
}

- (void)setRetweetFrame:(LYDetailRetweetFrame *)retweetFrame
{
    _retweetFrame = retweetFrame;
    
    self.frame = retweetFrame.frame;
    
    //微博数据与用户数据
    LYStatus * retweetStatus = retweetFrame.retweetStatus;
    LYUser * user = retweetStatus.user;
    
    //1.昵称
    self.nameLab.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLab.frame = retweetFrame.nameFrame;
    
    //2.正文
    self.contentLab.text = retweetStatus.text;
    self.contentLab.frame = retweetFrame.contentFrame;
    
    
}


@end
