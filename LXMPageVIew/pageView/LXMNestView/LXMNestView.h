//
//  LXMNestTableView.h
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LXMNestView;

@protocol LXMNestViewDelegate <NSObject>

@required

// 当内容可以滚动时会调用
- (void)nestViewInnerScrollViewCanScroll:(LXMNestView *)nextView;

@optional

// 当容器可以滚动时会调用
- (void)nestViewCanScroll:(LXMNestView *)nextView;

// 当容器正在滚动时调用，参数scrollView就是充当容器的tableView
- (void)nestViewDidScroll:(UIScrollView *)scrollView;


- (void)nestViewContentBeginDrag:(UIScrollView*)scrollView;

- (void)nestViewContentEndDrag:(UIScrollView*)scrollView;

@end

@interface LXMNestView : UIView
//tableView的HeaderView
@property (nonatomic,strong) UIView* headerView;
//tableView的每一个Cell, 这个Cell的高度需要用safeedgetop，navitaionheight, sectionHeader,sectionFooter,footerView的高度来确定，即nestView.height-（以上所说到的）（想想为什么不算Header的高度，因为，headerView在滑上去的时候，会隐藏）
@property (nonatomic,strong) UIView* contentView;
//tableView的sectionHeaderView
@property (nonatomic,strong) UIView* segmentView;
//tableView的footerView
@property (nonatomic,strong) UIView* footerView;
//控制tableView的sectionHeader的高度
@property (nonatomic,assign) CGFloat segmentViewHeight;

// 允许手势传递的view列表
@property (nonatomic, strong) NSArray *allowGestureEventPassViews;

@property (nonatomic,weak) id<LXMNestViewDelegate>delegate;

@property (nonatomic, assign) BOOL canNestTableViewScroll;


@end

NS_ASSUME_NONNULL_END
