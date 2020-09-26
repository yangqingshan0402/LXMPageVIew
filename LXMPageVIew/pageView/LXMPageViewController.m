//
//  ViewController.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMPageViewController.h"
#import "LXMCustomNavigationBar.h"
#import "LXMNestView.h"
#import "LXMPageView.h"
#import <MJRefresh.h>
#import "LXMBannerView.h"
#import "SDCycleScrollView.h"
#import "LXMVoiceView.h"

@interface LXMPageViewController ()<LXMNestViewDelegate, LXMPageViewDelegate, LXMPageViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray <UIView *> *viewList;
@property (nonatomic, strong) NSMutableArray <NSArray *> *dataSource;
@property (nonatomic, strong) LXMPageView *contentView;
@property (nonatomic, strong) LXMNestView *nestView;
@property (nonatomic, strong) UIView* segmentView;

@end

@implementation LXMPageViewController

#pragma mark - LXMPageViewDelegate & LXMPageViewDataSource

- (NSUInteger)numberOfPagesInPageView:(LXMPageView *)pageView {
    
    return [_viewList count];
}

- (UIView *)pageView:(LXMPageView *)pageView pageAtIndex:(NSUInteger)index {
    
    return _viewList[index];
}

- (void)pageView:(LXMPageView *)pageView didScrollToIndex:(NSUInteger)index {
    

}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSUInteger pageIndex = tableView.tag;
    return [_dataSource[pageIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSUInteger pageIndex = tableView.tag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[pageIndex][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"subcontent:%@", NSStringFromCGSize(scrollView.contentSize));
    if (!_canContentScroll) {
        // 这里通过固定contentOffset，来实现不滚动
        scrollView.contentOffset = CGPointZero;
    } else if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
        self.canContentScroll = NO;
        // 通知容器可以开始滚动
        _nestView.canNestTableViewScroll = YES;
    }
}

#pragma mark - MFNestTableViewDelegate & MFNestTableViewDataSource

- (void)nestViewInnerScrollViewCanScroll:(LXMNestView *)nextView {
    self.canContentScroll = YES;
}


- (void)nestViewCanScroll:(LXMNestView *)nextView {

    // 当容器开始可以滚动时，将所有内容设置回到顶部
    for (id view in self.viewList) {
        UIScrollView *scrollView;
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = view;
        } else if ([view isKindOfClass:[UIWebView class]]) {
            scrollView = ((UIWebView *)view).scrollView;
        }
        if (scrollView) {
            scrollView.contentOffset = CGPointZero;
        }
    }
}
 

-(void)nestViewDidScroll:(UIScrollView *)scrollView{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    [self setupSubViews];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - private methods

- (void)initDataSource {
    
    NSArray *pageDataCount = @[@2, @10, @30];
    
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < pageDataCount.count; ++i) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int j = 0; j < [pageDataCount[i] integerValue]; ++j) {
            [array addObject:[NSString stringWithFormat:@"page - %d - row - %d", i, j]];
        }
        [_dataSource addObject:array];
    }
    
    _viewList = [[NSMutableArray alloc] init];
    
    // 添加3个tableview
    for (int i = 0; i < pageDataCount.count; ++i) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = i;
        [_viewList addObject:tableView];
        tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     
                       [tableView.mj_header endRefreshing];
                   });
        }];
//        tableView.bounces = NO;
    }
    
    // 添加ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"img1.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * image.size.height / image.size.width);
    scrollView.contentSize = imageView.frame.size;
    scrollView.alwaysBounceVertical = YES; // 设置为YES，当contentSize小于frame.size也可以滚动
    [scrollView addSubview:imageView];
    scrollView.delegate = self;  // 主要是为了在 scrollViewDidScroll: 中处理是否可以滚动
    [_viewList addObject:scrollView];
    
    // 添加webview
    UIWebView *webview = [[UIWebView alloc] init];
    webview.backgroundColor = [UIColor whiteColor];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lymanli.com/"]]];
    webview.scrollView.delegate = self;  // 主要是为了在 scrollViewDidScroll: 中处理是否可以滚动
    [_viewList addObject:webview];
}


-(void)setupSubViews{
    _nestView = [[LXMNestView alloc] initWithFrame:self.view.bounds];

    [self initHeaderView];
    [self initSegmentView];
    [self initContentView];
    
    [self.view addSubview:_nestView];

    _nestView.headerView = _headerView;
    _nestView.contentView = _contentView;
    _nestView.allowGestureEventPassViews = _viewList;
    _nestView.delegate = self;

}

-(void)initSegmentView{
    _nestView.segmentViewHeight = 40;
}

- (void)initHeaderView {
    
    // 因为将navigationBar设置了透明，所以这里设置将header的高度减少navigationBar的高度，
    // 并将header的subview向上偏移，遮挡navigationBar透明后的空白
//    CGFloat offsetTop = [self nestTableViewContentInsetTop:_nestTableView];
    
    UIImage *image = [UIImage imageNamed:@"img2.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, -STATUS_BAR_HEIGHT, CGRectGetWidth(self.view.frame), self.view.frame.size.width * image.size.height / image.size.width);
    imageView.userInteractionEnabled = YES;
    /*
    NSArray *imagesURLStrings = @[
    @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
    @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
    ];
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:imageView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"img2.jpg"]];
       
       cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//       cycleScrollView2.titlesGroup = titles;
       cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
       [imageView addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    */
    
    LXMBannerView* bannerView = [[LXMBannerView alloc] initWithFrame:imageView.bounds];
    [imageView addSubview:bannerView];
    imageView.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bannerView beginMove];
    });
    bannerView.imageArray = @[@(1), @(2), @(3)];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(imageView.frame) , CGRectGetHeight(imageView.frame)- STATUS_BAR_HEIGHT)];
    [header addSubview:imageView];
    
    NSLog(@"headerFrame%@", NSStringFromCGRect(header.frame));
    _headerView = header;
    
    
}

//这个高度应该是 screenHeight - 20(segment缩小后的高度)-(TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT)
- (void)initContentView {
    
    _contentView = [[LXMPageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 20 - (TOP_NAVIGATION_ADD_TOP_SAFE_AREA_HEIGHT))];
    _contentView.delegate = self;
    _contentView.dataSource = self;
}

@end
