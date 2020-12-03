//
//  LKFloatWindowManager.m
//  LXMPageVIew
//
//  Created by jason on 2020/12/3.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LKFloatWindowManager.h"

@implementation LKFloatWindowManager

+(instancetype)shareManager{
    static LKFloatWindowManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LKFloatWindowManager alloc] init];
    });
    return manager;
}

- (void)initFloatWindow{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.floatWindow = [[LKFloatWindow alloc] initWithFrame:CGRectMake(screenWidth - KDEAISellFloatWindowWidth, screenHeight - KDEAISellFloatWindowHeight - KDEAISellFloatWindowBottomSpace , KDEAISellFloatWindowWidth, KDEAISellFloatWindowHeight)];
//    self.floatWindow.hidden = NO;
    self.floatWindow.floatType = KDEAISellFloatWindowTypeSupportPortraitPan;
    __weak typeof(self) weak_self = self;
    self.floatWindow.clickAction = ^{
        weak_self.floatWindow.hidden = YES;
        
    };
    if (@available(iOS 13.0, *)) {
        NSSet* windowScene = [UIApplication sharedApplication].connectedScenes;
        self.floatWindow.windowScene = windowScene.anyObject;
    }
}

@end
