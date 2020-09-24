//
//  LXMPageView.h
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXMPageView;

@protocol LXMPageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInPageView:(LXMPageView *)pageView;
- (UIView *)pageView:(LXMPageView *)pageView pageAtIndex:(NSUInteger)index;

@end

@protocol LXMPageViewDelegate <NSObject>

- (void)pageView:(LXMPageView *)pageView didScrollToIndex:(NSUInteger)index;

@end

@interface LXMPageView : UIView

@property (nonatomic,weak) id<LXMPageViewDataSource> dataSource;
@property (nonatomic,weak) id<LXMPageViewDelegate> delegate;
@property (nonatomic,assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
