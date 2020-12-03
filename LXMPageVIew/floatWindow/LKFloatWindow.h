//
//  LKFloatWindow.h
//  LXMPageVIew
//
//  Created by jason on 2020/12/3.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKFloatWindowViewModel.h"
NS_ASSUME_NONNULL_BEGIN

#define KDEAISellFloatWindowWidth 74.0f
#define KDEAISellFloatWindowHeight 74.0f
#define KDEAISellFloatWindowBottomSpace 70.0f
#define KDEAISellFloatWindowRightSpace 0

typedef NS_OPTIONS(NSUInteger, KDEAISellFloatWindowType) {
    KDEAISellFloatWindowTypeNormal = 1 << 0,//仅悬浮
    KDEAISellFloatWindowTypeSupportPortraitPan = 1 << 1,//支持竖屏滑动
    KDEAISellFloatWindowTypeSupportLandscapePan = 1 << 2,//支持横屏滑动
    KDEAISellFloatWindowTypeSupportPortraitSpringToBounds = 1 << 3, //支持竖屏弹至边框
    KDEAISellFloatWindowTypeSupportLandscapeSpringToBounds = 1 << 4, //支持横屏弹至边框
};
@interface LKFloatWindow : UIWindow

@property (nonatomic, strong) LKFloatWindowViewModel *viewModel;


@property (nonatomic, assign) KDEAISellFloatWindowType floatType;

@property (nonatomic, copy) void(^clickAction)(void);

@end

NS_ASSUME_NONNULL_END
