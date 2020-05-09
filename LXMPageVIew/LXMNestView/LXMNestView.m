//
//  LXMNestTableView.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMNestView.h"
#import "LXMNestTableView.h"

@interface LXMNestView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LXMNestTableView* tableView;

@end

@implementation LXMNestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    _tableView = [[LXMNestTableView alloc] initWithFrame:self.bounds];
    [self addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.canNestTableViewScroll = YES;
}
-(void)setHeaderView:(UIView *)headerView{
    if (_headerView == headerView) {
           return;
       }
   _headerView = headerView;
   if (_tableView) {
       _tableView.tableHeaderView = headerView;
   }
   
   [self resizeContentViewHeight];
   [_tableView reloadData];
    
}
//必须在footer，header，segment之后，最后做这一步
- (void)setContentView:(UIView *)contentView {
    
    if (_contentView == contentView) {
        return;
    }
    _contentView = contentView;
    
    [self resizeContentViewHeight];
    [_tableView reloadData];
}


//设置Cell上的ContentView的高度
- (void)resizeContentViewHeight {
    
    if (!_contentView) {
        return;
    }
    
//    CGFloat contentHeight = CGRectGetHeight(self.bounds) - [self segmentViewHeight] - [self edgeInsetUpSegmentView] - [self contentInsetBottom] - [self footerViewHeight];
//    NSLog(@"hhhcontentHeight:%f", contentHeight);
//     NSLog(@"hhhsegmentViewHeight:%f", [self segmentViewHeight]);
//     NSLog(@"hhhcontentInsetTop:%f", [self edgeInsetUpSegmentView]);
//     NSLog(@"hhhcontentInsetBottom:%f", [self contentInsetBottom]);
//     NSLog(@"hhhfooterViewHeight:%f", [self footerViewHeight]);
//    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1000);
    _contentView.frame = self.bounds;
}

//footerView高度即LXMNestTableView的FooterView的高度
- (CGFloat)footerViewHeight {
    return _footerView ? CGRectGetHeight(_footerView.bounds) : 0;
}

//segmentView上方的safeArea高度 + navi的高度
-(CGFloat)edgeInsetUpSegmentView{
    return TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT;
}
//下方的safeArea高度
-(CGFloat)contentInsetBottom{
    return BOTTOM_SAFE_ARRA_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _segmentViewHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (_contentView) {
        UIView *view = cell.contentView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [view addSubview:_contentView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_contentView) {
        return 0;
    }
    
    return CGRectGetHeight(_contentView.bounds);
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor blueColor];
    return view;
//    return [_segmentView];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_footerView) {
        return _footerView;
    } else {
        return [[UIView alloc] init];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [self footerViewHeight];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
}

-(void)setAllowGestureEventPassViews:(NSArray *)allowGestureEventPassViews{
    _allowGestureEventPassViews = allowGestureEventPassViews;
    
    if (_tableView) {
        [_tableView setAllowGestureEventPassViews:allowGestureEventPassViews];
    }
}

- (CGFloat)offsetHeightForScrollViewThatCannotScroll{
    
    if (_tableView && _tableView.tableHeaderView) {
        NSLog(@"----height%f---%f", CGRectGetHeight(_tableView.tableHeaderView.frame), TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT);
        return CGRectGetHeight(_tableView.tableHeaderView.frame) - (TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT);
    } else {
        return 0;
    }
}

//想想为什么不直接
/*
 if (scrollView.contentOffset.y >= contentOffset) {
 scrollView.contentOffset = CGPointMake(0, contentOffset);
 如果按照上面的写法会有一个抖动，特别是在修改headersection的高度的时候
 */
float lastY = 0;

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffset = [self offsetHeightForScrollViewThatCannotScroll];
    
    if (!_canNestTableViewScroll) {
        // 这里通过固定contentOffset的值，来实现不滚动
        
        scrollView.contentOffset = CGPointMake(0, contentOffset);
        
    } else if (scrollView.contentOffset.y >= contentOffset) {//当scrollView滑到大于contentOffset的位置的时候
        scrollView.contentOffset = CGPointMake(0, contentOffset);
        self.canNestTableViewScroll = NO;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(nestViewInnerScrollViewCanScroll:)]) {
            [self.delegate nestViewInnerScrollViewCanScroll:self];
        }
    }
    
    CGPoint vel = [scrollView.panGestureRecognizer velocityInView:scrollView];
    if (vel.y < -5) {
        NSLog(@"向上拖");
    }else if (vel.y > 5) {
        NSLog(@"向下拖");
    }else if (vel.y == 0) {
        vel.y = lastY;
    }
    lastY = vel.y;
    
    NSLog(@"scrollView:%@, translate:%F, lastY:%f", NSStringFromCGPoint(scrollView.contentOffset), vel.y, lastY);
    
    //97.5====  _header.view.frame.size.height - statusbarheight - navibarheight
    
    if (scrollView.contentOffset.y < _headerView.frame.size.height - (TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT) && vel.y > 5) {//从顶部往下拖
        if (self.segmentViewHeight != 40) {
            lastY = scrollView.contentOffset.y;
            
            self.segmentViewHeight = 40;
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            //            [self.nestTableView.tableView setContentOffset:CGPointMake(0, 90.0)];
        }
    }
    
    if (scrollView.contentOffset.y >= _headerView.frame.size.height - (TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT) && vel.y < -5){//往上拖
        if (self.segmentViewHeight != 20){
            lastY = scrollView.contentOffset.y;
            self.segmentViewHeight = 20;
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }
        
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(nestViewDidScroll:)]) {
        [self.delegate nestViewDidScroll:_tableView];
    }
    
    //        NSLog(@"canscroll:%d", _canScroll);
    //        scrollView.showsVerticalScrollIndicator = _canScroll;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
