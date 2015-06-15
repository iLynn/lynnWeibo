//
//  LYHomeTableController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/6.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYHomeTableController.h"
#import "LYTitleButton.h"
#import "LYPopMenuView.h"
#import "LYSinaAccount.h"
#import "LYAccountTool.h"
#import "MBProgressHUD+LY.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "LYStatus.h"
#import "LYUser.h"
#import "LYLoadMoreFooterView.h"
#import "LYHttpTool.h"
#import "LYStatusCell.h"
#import "LYStatusFrame.h"


@interface LYHomeTableController ()<LYPopMenuViewDelegate>

/**
 *  微博Frame数组(存放着所有的微博frame数据)
 */
@property (nonatomic, strong) NSMutableArray * statusFrames;

@property (nonatomic, weak) LYLoadMoreFooterView *footer;

@property (nonatomic, weak) LYTitleButton * titleButton;

@end

@implementation LYHomeTableController

//懒加载

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil)
    {
        _statusFrames = [NSMutableArray array];
    }
    
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //cell的间隔
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    LYLog(@"LYHomeTableController--viewDidLoad");
    
    //1.添加导航
    [self setUpNavigationBar];
    
    //2.添加下拉、上拉刷新控件
    [self setupRefresh];
    
    //3.加载用户信息
    [self setupUserInfo];
    
}


/**
 *  获得用户信息
 */
- (void)setupUserInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    params[@"uid"] = [LYAccountTool account].uid;
    
    //2.发送请求
    [LYHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObj) {
         // 字典转模型
         LYUser * user = [LYUser objectWithKeyValues:responseObj];

         // 设置用户的昵称为标题
         [self.titleButton setTitle:user.name forState:UIControlStateNormal];

         // 存储帐号信息
         LYSinaAccount * account = [LYAccountTool account];
         account.name = user.name;

        LYLog(@"model:%@",account.name);
        
         [LYAccountTool saveAccount:account];

    } failure:^(NSError * error) {
        
        LYLog(@"请求失败-------%@", error);
        
    }];
}


/**
 *  添加下拉、上拉刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.手动加载一次数据
    [self refreshControlStateChange:refreshControl];
    
    // 5.给tableView添加一个footer
    LYLoadMoreFooterView * footer = [LYLoadMoreFooterView footer];
    self.tableView.tableFooterView = footer;
    
    LYLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    LYLog(@"%@", NSStringFromCGRect(self.tableView.tableFooterView.frame));
    
    self.footer = footer;

}

/**
 *  当下拉刷新控件进入刷新状态的时候会自动调用此方法，加载数据
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
    
}

#pragma mark - 刷新

- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue)
    {
        // 转圈圈
        [self.refreshControl beginRefreshing];
        
        // 刷新数据
        [self loadNewStatuses:self.refreshControl];
        
    }
    else if (fromSelf)
    {
        // 让表格回到最顶部
        NSIndexPath * firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray * frames = [NSMutableArray array];
    for (LYStatus * status in statuses)
    {
        LYStatusFrame * frame = [[LYStatusFrame alloc] init];
        
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - 加载微博数据

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    LYStatusFrame * firstFrame = [self.statusFrames firstObject];
    LYStatus * firstStatus =  firstFrame.status;
    if (firstStatus)
    {
        params[@"since_id"] = firstStatus.idstr;
    }
    
    //2.发送请求
    [LYHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
        
         // 微博字典数组
         NSArray * statusDictArray = responseObj[@"statuses"];
         // 微博字典数组 ---> 微博模型数组
         NSArray * newStatuses = [LYStatus objectArrayWithKeyValuesArray:statusDictArray];
        
         // 获得最新的微博frame数组
         NSArray * newFrames = [self statusFramesWithStatuses:newStatuses];
        
         //self.statusFrames = newFrames;

         // 将新数据插入到旧数据的最前面
         NSRange range = NSMakeRange(0, newFrames.count);
         NSIndexSet * indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
         [self.statusFrames insertObjects:newFrames atIndexes:indexSet];

         // 重新刷新表格
         [self.tableView reloadData];

         // 让刷新控件停止刷新（恢复默认的状态）
         [refreshControl endRefreshing];
         
         // 提示用户最新的微博数量
         [self showNewStatusesCount:newFrames.count];
        
    } failure:^(NSError * error) {
        
         LYLog(@"请求失败--%@", error);

         // 让刷新控件停止刷新（恢复默认的状态）
         [refreshControl endRefreshing];
        
    }];

}



/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(NSInteger)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count)
    {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据", count];
    } else
    {
        label.text = @"没有最新的微博数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  添加导航栏，并响应导航的数据
 */
-(void)setUpNavigationBar
{
    //1.添加左右两边的导航按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_friendsearch" andSelectedImageName:@"navigationbar_friendsearch_highlighted" andTarget:self andAction:@selector(searchFriend)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"navigationbar_pop" andSelectedImageName:@"navigationbar_pop_highlighted" andTarget:self andAction:@selector(pop)];
    
    
    //2.添加中间的导航标题
    
    // 设置导航栏中间的标题按钮
    LYTitleButton * titleView = [LYTitleButton titleButton];
    // 设置尺寸
    titleView.height = 35;
    // 设置文字
    NSString *name = [LYAccountTool account].name;
    LYLog(@"%@", name);
    
    [titleView setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    // 设置图标
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景
    [titleView setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];

    
    //3.监听标题的点击事件
    [titleView addTarget:self action:@selector(titleButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton = titleView;
    self.navigationItem.titleView = titleView;
    
}

-(void)titleButtonTouch:(LYTitleButton *)titleView
{
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor lightGrayColor];
    
    LYPopMenuView * menuView = [[LYPopMenuView alloc] initWithContentView:button];
    menuView.delegate = self;
    menuView.dimBackground = YES;
    menuView.arrowPosition = LYPopMenuViewArrowPositionCenter;
    [menuView showViewInRect:CGRectMake(self.view.width/2 - 100, 64, 200, 300)];
    
}

-(void)searchFriend
{
    LYLog(@"%s", __func__);
}

-(void)pop
{
    LYLog(@"%s", __func__);
}


#pragma mark - 自定义弹出menuView的代理方法

- (void)popMenuViewDidDismissed:(LYPopMenuView *)popMenuView
{
    LYTitleButton * titleButton = (LYTitleButton *)self.navigationItem.titleView;
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //没有数据时，隐藏footer
    self.footer.hidden = self.statusFrames.count == 0;
    
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYStatusCell * cell = [LYStatusCell cellWithTableView:tableView];
    
    cell.cellFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYStatusFrame * frame = self.statusFrames[indexPath.row];
    
    return frame.cellHeight;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * newVC = [[UIViewController alloc] init];
    newVC.view.backgroundColor = LYRandomColor;
    newVC.title = @"newVC";
    
    //LYHomeTableController是LYNavigationController的rootViewController，所以它可以使用nav的push功能进行页面跳转
    [self.navigationController pushViewController:newVC animated:YES];
    
}


#pragma mark - 下拉刷新最新的数据、上拉加载更多的数据

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 没有数据或正在刷新数据，不响应
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    
    // 刚好能完整看到footer时的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0))
    {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        //开一个线程，加载更多数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    LYStatusFrame * lastFrame = [self.statusFrames lastObject];
    LYStatus * lastStatus =  lastFrame.status;
    if (lastStatus)
    {
        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
    }
    
    //2.发送请求
    [LYHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
        
         // 微博字典数组
         NSArray *statusDictArray = responseObj[@"statuses"];
         // 微博字典数组 ---> 微博模型数组
         NSArray *newStatuses = [LYStatus objectArrayWithKeyValuesArray:statusDictArray];
        
         // 获得最新的微博frame数组
         NSArray * newFrames = [self statusFramesWithStatuses:newStatuses];

         // 将新数据插入到旧数据的最后面
         [self.statusFrames addObjectsFromArray:newFrames];

         // 重新刷新表格
         [self.tableView reloadData];

         // 让刷新控件停止刷新（恢复默认的状态）
         [self.footer endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:newStatuses.count];
        
    } failure:^(NSError * error) {
        
         LYLog(@"请求失败--%@", error);
        
         // 让刷新控件停止刷新（恢复默认的状态）
         [self.footer endRefreshing];
        
    }];

}



@end
