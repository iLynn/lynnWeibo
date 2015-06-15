//
//  LYDetailOriginalView.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYDetailOriginalView.h"
#import "LYDetailOriginalFrame.h"
#import "LYStatus.h"
#import "LYUser.h"
#import "UIImageView+WebCache.h"

@interface LYDetailOriginalView()

/** 昵称 */
@property (nonatomic, weak) UILabel * nameLab;

/** 时间 */
@property (nonatomic, weak) UILabel * timeLab;

/** 来源 */
@property (nonatomic, weak) UILabel * sourceLab;

/** 正文 */
@property (nonatomic, weak) UILabel * contentLab;

/** 头像 */
@property (nonatomic, weak) UIImageView * iconView;

/** 会员图标 */
@property (nonatomic, weak) UIImageView * vipView;

@end

@implementation LYDetailOriginalView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置背景
        self.image = [UIImage resizedImage:@"timeline_card_bottom_background"];
        
        //1.昵称
        UILabel * name = [[UILabel alloc] init];
        name.font = LYCustomFontSize;
        [self addSubview:name];
        
        self.nameLab = name;
        
        //2.时间
        UILabel * time = [[UILabel alloc] init];
        time.font = LYTimeFontSize;
        [self addSubview:time];
        
        self.timeLab = time;
        
        //3.来源
        UILabel * source = [[UILabel alloc] init];
        source.font = LYTimeFontSize;
        [self addSubview:source];
        
        self.sourceLab = source;
        
        //4.正文
        UILabel * content = [[UILabel alloc] init];
        content.font = LYCustomFontSize;
        content.numberOfLines = 0;
        [self addSubview:content];
        
        self.contentLab = content;
        
        //5.头像
        UIImageView * icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        
        self.iconView = icon;
        
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        
        self.vipView = vipView;
        
    }
    
    return self;
}

- (void)setOriginalFrame:(LYDetailOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    //数据
    LYStatus * originalStatus = originalFrame.status;
    LYUser * user = originalStatus.user;
    
    //1.昵称
    self.nameLab.text = user.name;
    self.nameLab.frame = originalFrame.nameFrame;
    
    if (user.isVip)
    {
        self.nameLab.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    }
    else
    {
        self.vipView.hidden = YES;
        self.nameLab.textColor = [UIColor blackColor];
    }
  
#warning 时间和来源的frame需要动态的计算
    //2.时间
    self.timeLab.text = originalStatus.created_at;
    CGFloat timeX = self.nameLab.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLab.frame) + LYCellMargin * 0.5;
    CGSize timeSize = [self.timeLab.text sizeWithFont:LYCustomFontSize];
    self.timeLab.frame = (CGRect){{timeX, timeY}, timeSize};
    
    //3.来源
    self.sourceLab.text = originalStatus.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLab.frame);
    CGFloat sourceY = CGRectGetMaxY(self.nameLab.frame) + LYCellMargin * 0.5;
    CGSize sourceSize = [self.sourceLab.text sizeWithFont:LYCustomFontSize];
    self.sourceLab.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //4.正文
    self.contentLab.text = originalStatus.text;
    self.contentLab.frame = originalFrame.contentFrame;
    
    //5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    

}

@end
