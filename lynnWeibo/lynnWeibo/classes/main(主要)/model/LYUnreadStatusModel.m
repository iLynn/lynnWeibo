//
//  LYUnreadStatusModel.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/12.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYUnreadStatusModel.h"

@implementation LYUnreadStatusModel

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
