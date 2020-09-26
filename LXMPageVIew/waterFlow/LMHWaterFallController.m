//
//  LMHWaterFallController.m
//  WaterFallDemo
//
//  Created by 刘梦桦 on 2017/5/20.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "LMHWaterFallController.h"
#import "LMHWaterFallLayout.h"
#import "LMHShop.h"
#import "LMHShopCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

static NSString * const LMHShopId = @"shop";

@interface LMHWaterFallController ()<UICollectionViewDataSource, LMHWaterFallLayoutDeleaget>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray  * shops;

/** <#name#> */
@property (nonatomic, weak) UICollectionView * collectionView;

/** 列数 */
@property (nonatomic, assign) NSUInteger columnCount;


@end

@implementation LMHWaterFallController
#pragma mark - 懒加载
- (NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    
    [self setupLayoutAndCollectionView];
    
    [self setupRefresh];
}

/**
 * 初始化
 */
- (void)initialize{
    
    self.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];

}

/**
 * 创建布局和collectionView
 */
- (void)setupLayoutAndCollectionView{
    
    // 创建布局
    LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
    waterFallLayout.delegate = self;
    
    // 创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterFallLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LMHShopCell class]) bundle:nil] forCellWithReuseIdentifier:LMHShopId];
    
    self.collectionView = collectionView;
}

/**
 * 刷新控件
 */
- (void)setupRefresh{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_header.backgroundColor = [UIColor yellowColor];
    [self.collectionView.mj_header beginRefreshing];
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.mj_footer.backgroundColor = [UIColor yellowColor];
    self.collectionView.mj_footer.hidden = YES;
}

/**
 * 加载新的商品
 */
- (void)loadNewShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray * shops = [LMHShop mj_objectArrayWithFilename:@"shop.plist"];
        
        [self.shops removeAllObjects];
        
        [self.shops addObjectsFromArray:shops];
        
        // 刷新表格
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
}

/**
 * 加载更多商品
 */
- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray * shops = [LMHShop mj_objectArrayWithFilename:@"shop.plist"];
        
        
        [self.shops addObjectsFromArray:shops];
        
        // 刷新表格
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
    
}

/**
 * 分段控件的点击事件
 */
- (void)segmentClick: (UISegmentedControl *)segment{
    
    NSInteger index = segment.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            self.columnCount = 2;
            
            break;
            
        case 1:
            self.columnCount = 3;
            break;
        default:
            break;
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.mj_footer.hidden = self.shops.count == 0;
    
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LMHShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LMHShopId forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}



#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    LMHShop * shop = self.shops[indexPath];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 20;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 2;
    
}




@end
