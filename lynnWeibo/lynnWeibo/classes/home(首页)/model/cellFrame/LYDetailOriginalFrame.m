//
//  LYDetailOriginalFrame.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYDetailOriginalFrame.h"
#import "LYStatus.h"
#import "LYUser.h"

@implementation LYDetailOriginalFrame

- (void)setStatus:(LYStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = LYCellMargin;
    CGFloat iconY = LYCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + LYCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:LYCustomFontSize];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 计算会员图标的位置
    if (status.user.isVip)
    {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + LYCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
//    // 3.时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + LYCellMargin * 0.5;
//    CGSize timeSize = [status.created_at sizeWithFont:LYCustomFontSize];
//    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
//    
//    // 4.来源
//    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + LYCellMargin * 0.5;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [status.source sizeWithFont:LYCustomFontSize];
//    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + LYCellMargin;
    CGFloat maxW = LYScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:LYCustomFontSize constrainedToSize:maxSize];
    self.contentFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = LYScreenWidth;
    CGFloat h = CGRectGetMaxY(self.contentFrame) + LYCellMargin;
    self.frame = CGRectMake(x, y, w, h);
}

@end
