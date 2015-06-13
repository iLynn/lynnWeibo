//
//  LYStatusCell.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYStatusCell.h"
#import "LYStatusDetailView.h"
#import "LYStatusToolbarView.h"
#import "LYStatusFrame.h"

@interface LYStatusCell()

@property (nonatomic, weak) LYStatusDetailView * detailView;

@property (nonatomic, weak) LYStatusToolbarView * toolbarView;

@end

@implementation LYStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    LYStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[LYStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //1.添加微博详细区
        LYStatusDetailView * detailView = [[LYStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        
        self.detailView = detailView;
        
        
        //2.添加toolbar区
        LYStatusToolbarView * toolbar = [[LYStatusToolbarView alloc] init];
        [self.contentView addSubview:toolbar];
        
        self.toolbarView = toolbar;
    }
    
    return self;
}

- (void)setCellFrame:(LYStatusFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 1.微博具体内容的frame数据
    self.detailView.detailFrame = cellFrame.detailFrame;
    
    // 2.底部工具条的frame数据
    self.toolbarView.frame = cellFrame.toolbarFrame;
    
}


@end
