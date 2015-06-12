//
//  LYHttpTool.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/12.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYHttpTool.h"
#import "AFNetworking.h"

@implementation LYHttpTool

/**
 *  封装自己的网络请求方法，如果以后不用AFNetworking，只需要修改此处的实现，整个项目的网络请求依然都能够正常使用
 *
 *  @param url     网络地址
 *  @param params  参数
 *  @param success 请求成功后做什么？
 *  @param failure 请求失败后做什么？
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [manager GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [manager POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}


@end
