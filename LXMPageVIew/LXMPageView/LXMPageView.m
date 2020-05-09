//
//  LXMPageView.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMPageView.h"

@interface LXMPageView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* pageCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;

@end

@implementation LXMPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.0;
    _flowLayout.minimumInteritemSpacing = 0.0;
    
    //设置item尺寸
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    _flowLayout.itemSize = CGSizeMake(itemW, itemH);
    
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置水平滚动方向
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _pageCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:_flowLayout];
    [self addSubview:_pageCollectionView];
    _pageCollectionView.delegate = self;
    _pageCollectionView.dataSource = self;
    _pageCollectionView.pagingEnabled = YES;
    
      [_pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLXMPageViewReuseIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        return [self.dataSource numberOfPagesInPageView:self];
    }
    return 0;
}
static NSString* kLXMPageViewReuseIdentifier = @"kLXMPageViewReuseIdentifier";
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLXMPageViewReuseIdentifier forIndexPath:indexPath];
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(pageView:pageAtIndex:)]) {
        UIView *view = [self.dataSource pageView:self pageAtIndex:indexPath.row];
        [cell.contentView addSubview:view];
        view.frame = cell.bounds;
        NSLog(@"--->%@", NSStringFromCGRect(view.frame));
    }
    return cell;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger pageNum = round(offset / CGRectGetWidth(self.frame));
    _currentIndex = pageNum;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageView:didScrollToIndex:)]) {
        [self.delegate pageView:self didScrollToIndex:pageNum];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
