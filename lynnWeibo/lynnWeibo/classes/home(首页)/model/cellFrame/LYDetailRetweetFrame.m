//
//  LYDetailRetweetFrame.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYDetailRetweetFrame.h"
#import "LYStatus.h"
#import "LYUser.h"

@implementation LYDetailRetweetFrame

- (void)setRetweetStatus:(LYStatus *)retweetStatus
{
    _retweetStatus = retweetStatus;
    
    // 1.昵称
    CGFloat nameX = LYCellMargin;
    CGFloat nameY = LYCellMargin;
    NSString * name = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
    CGSize nameSize = [name sizeWithFont:LYCustomFontSize];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + LYCellMargin * 0.5;
    CGFloat maxW = LYScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    CGSize textSize = [retweetStatus.text sizeWithFont:LYCustomFontSize constrainedToSize:maxSize];
    self.contentFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = LYScreenWidth;
    CGFloat h = CGRectGetMaxY(self.contentFrame) + LYCellMargin;
    self.frame = CGRectMake(x, y, w, h);
}

@end
