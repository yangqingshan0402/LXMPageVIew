//
//  LXMNestTableView.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMNestTableView.h"
#import <WebKit/WebKit.h>

@implementation LXMNestTableView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - private methods

- (void) commonInit {
    // 在某些情况下，contentView中的点击事件会被panGestureRecognizer拦截，导致不能响应，
    // 这里设置cancelsTouchesInView表示不拦截
    self.panGestureRecognizer.cancelsTouchesInView = NO;
}

#pragma mark - UIGestureRecognizerDelegate

// 返回YES表示可以继续传递触摸事件，这样两个嵌套的scrollView才能同时滚动
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    id view = otherGestureRecognizer.view;
    
    if (@available(iOS 12.0, *)) {
        if ([[view superview] isKindOfClass:[WKWebView class]]) {
               view = [view superview];
           }
    }else{
        if ([[view superview] isKindOfClass:[UIWebView class]]) {
            view = [view superview];
        }
    }

    
    if (_allowGestureEventPassViews && [_allowGestureEventPassViews containsObject:view]) {
        return YES;
    } else {
        return NO;
    }
}

@end
