//
//  LYWriteViewController.m
//  lynnWeibo
//
//  Created by Lynn on 15/6/8.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "LYWriteViewController.h"
#import "LYTextView.h"
#import "LYWriteToolbar.h"
#import "LYWritePhotosView.h"
#import "AFNetworking.h"
#import "LYAccountTool.h"
#import "LYSinaAccount.h"
#import "MBProgressHUD+LY.h"


@interface LYWriteViewController ()<LYWriteToolBarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)LYTextView * textView;
@property (nonatomic, weak) LYWriteToolBar * toolbar;
@property (nonatomic, weak) LYWritePhotosView * photosView;

@end

@implementation LYWriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.添加导航
    [self setupNavBar];
    
    //2.添加文本框
    [self setupTextView];
    
    //3.添加工具条
    [self setupToolBar];
    
    //4.添加显示图片的相册控件
    [self setupPhotosView];
    
    LYLog(@"LYMessageTableController--viewDidLoad");
    
}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    LYWritePhotosView * photosView = [[LYWritePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}

// 添加工具条
- (void)setupToolBar
{
    // 1.创建
    LYWriteToolBar * toolbar = [[LYWriteToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    toolbar.height = 44;
    self.toolbar = toolbar;
    
    // 2.显示
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    
}

// 设置导航条内容
- (void)setupNavBar
{
    self.navigationItem.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //appearence已经设置好了
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //最初设置为不可发送
#warning 此处颜色有点问题，不知原因
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    LYTextView * textView = [[LYTextView alloc] init];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"分享新鲜事...";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

/**
 *  取消
 */
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
-(void)send
{
    // 1.发表微博
    if (self.photosView.images.count)
    {
        [self sendStatusWithImage];
    }
    else
    {
        [self sendStatusWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}



/**
 *  发表有图片的微博
 */
- (void)sendStatusWithImage
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送POST请求
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
#warning 目前新浪开放的发微博接口 最多 只能上传一张图片
        UIImage * image = [self.photosView.images firstObject];
        
        NSData * data = UIImageJPEGRepresentation(image, 1.0);
        
        // 拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
        
        [MBProgressHUD showSuccess:@"发表成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"发表失败"];
        
    }];
}


/**
 *  发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送POST请求
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
          
          [MBProgressHUD showSuccess:@"发表成功"];
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          [MBProgressHUD showError:@"发表失败"];
          
      }];
}

#pragma mark - 键盘处理

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.transform = CGAffineTransformIdentity;
        
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
        
    }];
}

#pragma mark - UITextViewDelegate

/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(LYWriteToolBar *)toolbar didClickedButton:(LYWriteToolBarButtonType)buttonType
{
    switch (buttonType) {
        case LYWriteToolBarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case LYWriteToolBarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case LYWriteToolBarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
    
}


@end
