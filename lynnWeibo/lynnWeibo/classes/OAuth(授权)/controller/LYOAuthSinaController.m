//
//  LYOAuthSinaController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/9.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYOAuthSinaController.h"
#import "MBProgressHUD+LY.h"
#import "AFNetworking.h"
#import "LYControllerTool.h"
#import "LYAccountTool.h"
#import "LYSinaAccount.h"

@interface LYOAuthSinaController ()<UIWebViewDelegate>

@end

@implementation LYOAuthSinaController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.加载登录页面
    NSString * urlStr = [NSString stringWithFormat:@"%@authorize?client_id=%@&redirect_uri=%@", LYSinaAPIOAuth, LYAppKey, LYAppRedirectURI];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 3.设置代理
    webView.delegate = self;
}


#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    LYLog(@"%@", error);
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *
 *  @param request        即将发送的请求
 
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得请求地址
    NSString *url = request.URL.absoluteString;
    
    // 2.判断url是否为回调地址
#warning 新浪做了一些处理/dpool/
    NSRange range = [url rangeOfString:@"http://blog.sina.cn/dpool/blog/ilynn1990?code="];
    if (range.location != NSNotFound)
    {
        // 截取授权成功后的请求标记
        NSInteger from = range.location + range.length;
        NSString * code = [url substringFromIndex:from];
        
        LYLog(@"%@, %@", url, code);
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}


/**
 *  根据code获得一个accessToken(发送一个POST请求)
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = LYAppKey;
    params[@"client_secret"] = LYAppSecret;
    params[@"redirect_uri"] = LYAppRedirectURI;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    
    // 3.发送POST请求
    NSString * postUrlStr = [NSString stringWithFormat:@"%@access_token", LYSinaAPIOAuth];
    [manager POST:postUrlStr parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        LYLog(@"请求成功--%@", responseObject);
        
        // 3.1.存储授权成功的帐号信息
        // 3.1.1.字典转成模型
        LYSinaAccount * account = [LYSinaAccount sinaAccountWithDict:responseObject];
        
        // 3.1.2存储帐号模型
        [LYAccountTool saveAccount:account];
       
        // 3.2.切换控制器
        [LYControllerTool chooseRootViewController];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        LYLog(@"请求失败--%@", error);
    }];
    
}



@end
