//
//  LYWeiboStatus.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYStatus.h"
#import "LYStatusPhoto.h"
#import "MJExtension.h"
#import "NSDate+computeExt.h"

@implementation LYStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [LYStatusPhoto class]};
}

/**
 *  重写created_at的get方法，计算符合weibo要求的时间
 *
 *  @return 符合weibo要求的时间
 */
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear)
    {
        // 如果是今天
        if (createDate.isToday)
        {
            NSDateComponents *cmps = [createDate deltaWithNow];
            
            // 判断是否是一个小时以上
            if (cmps.hour >= 1)
            {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            }
            else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        // 昨天
        else if (createDate.isYesterday)
        {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }
        else
        {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }
    // 不是今年
    else
    {
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source
{
    // 截取范围
    NSRange range;
    if ([source rangeOfString:@">"].length == 0)
    {
        _source = @"来自Lynn未知的数据源";
    }
    else
    {
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        
        // 开始截取
        NSString * subsource = nil;
        if (range.location)
        {
            subsource = [source substringWithRange:range];
        }
        
        _source = [NSString stringWithFormat:@"来自%@", subsource];
    }

}


@end
