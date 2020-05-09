//
//  UIScrollView+ScrollAble.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/9.
//  Copyright © 2020 jason. All rights reserved.
//

#import "UIScrollView+ScrollAble.h"
#import <objc/runtime.h>

static  const void *canScrollKey = @"canScrollKey"; //name的key


@implementation UIScrollView (ScrollAble)

//-(void)setCanScroll:(BOOL)canScroll{
//    objc_setAssociatedObject(self, &canScrollKey, [NSNumber numberWithBool:canScroll], OBJC_ASSOCIATION_ASSIGN);
//
//}

-(void)scrollAbleAtContentOffet:(CGPoint)contentOffset{
    if (!self.scrollAble) {
        // 这里通过固定contentOffset，来实现不滚动
        self.contentOffset = contentOffset;
    } else
        if (self.contentOffset.y <= 0) {
            self.contentOffset = contentOffset;
        self.scrollAble = NO;
        // 通知容器可以开始滚动
//        _nestTableView.canScroll = YES;
    }
}

-(void)setScrollAble:(BOOL)scrollAble{
    objc_setAssociatedObject(self, &canScrollKey, [NSNumber numberWithBool:scrollAble], OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)scrollAble{
    return [objc_getAssociatedObject(self, canScrollKey) boolValue];
}

@end
