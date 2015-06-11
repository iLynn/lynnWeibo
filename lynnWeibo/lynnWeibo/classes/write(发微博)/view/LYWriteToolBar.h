//
//  LYWriteToolBar.h
//  lynnWeibo
//
//  Created by Lynn on 15/6/11.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYWriteToolBar;

typedef enum {
    LYWriteToolBarButtonTypeCamera, // 照相机
    LYWriteToolBarButtonTypePicture, // 相册
    LYWriteToolBarButtonTypeMention, // 提到@
    LYWriteToolBarButtonTypeTrend, // 话题
    LYWriteToolBarButtonTypeEmotion // 表情
} LYWriteToolBarButtonType;


@protocol LYWriteToolBarDelegate <NSObject>

@optional

- (void)composeTool:(LYWriteToolBar *)toolbar didClickedButton:(LYWriteToolBarButtonType)buttonType;

@end

@interface LYWriteToolBar : UIView
@property (nonatomic, weak) id<LYWriteToolBarDelegate> delegate;

@end
