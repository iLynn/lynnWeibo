//
//  LYStatusCell.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYStatusFrame;

@interface LYStatusCell : UITableViewCell

@property (nonatomic, strong) LYStatusFrame * cellFrame;

/** 创建一个cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
