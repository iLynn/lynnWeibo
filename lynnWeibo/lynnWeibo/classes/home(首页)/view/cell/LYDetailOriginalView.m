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

@end

@implementation LYDetailOriginalView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.昵称
        UILabel * name = [[UILabel alloc] init];
        name.font = LYCustomFontSize;
        [self addSubview:name];
        
        self.nameLab = name;
        
        //2.时间
        UILabel * time = [[UILabel alloc] init];
        time.font = LYCustomFontSize;
        [self addSubview:time];
        
        self.timeLab = time;
        
        //3.来源
        UILabel * source = [[UILabel alloc] init];
        source.font = LYCustomFontSize;
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
    
    //2.时间
    self.timeLab.text = originalStatus.created_at;
    self.timeLab.frame = originalFrame.timeFrame;
    
    //3.来源
    self.sourceLab.text = originalStatus.source;
    self.sourceLab.frame = originalFrame.sourceFrame;
    
    //4.正文
    self.contentLab.text = originalStatus.text;
    self.contentLab.frame = originalFrame.contentFrame;
    
    //5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    

}

@end
