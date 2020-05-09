//
//  UIScrollView+ScrollAble.h
//  LXMPageVIew
//
//  Created by jason on 2020/5/9.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (ScrollAble)

@property (nonatomic,assign) BOOL scrollAble;

-(void)scrollAbleAtContentOffet:(CGPoint)contentOffset;

@end

NS_ASSUME_NONNULL_END
