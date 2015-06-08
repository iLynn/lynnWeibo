//
//  NSArray+chinese.m
//  OC-day7
//
//  Created by qianfeng on 15-4-10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSArray+ChineseExt.h"

@implementation NSArray (ChineseExt)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString * str = [NSMutableString string];
    [str appendString:@"(\n"];
    
    for (id obj in self)
    {
        [str appendFormat:@"\t%@,\n", obj];
    }
    [str appendFormat:@")"];
    
    return str;
}

@end
