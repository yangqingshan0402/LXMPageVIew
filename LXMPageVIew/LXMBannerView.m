//
//  LXMBannerView.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/12.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMBannerView.h"
#import "LXMBannerCollectionViewCell.h"

@interface LXMBannerView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;
@property (nonatomic, strong) NSTimer*  timer;
@property (nonatomic, assign) NSInteger innerIndex;

@end

@implementation LXMBannerView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    NSLog(@"willMoveToSuperview%@", newSuperview);

    if (!newSuperview) {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
    }else{
        
    }
}

-(void)beginMove{
    _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(moveTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)moveTimerAction{
    _innerIndex++;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//    NSLog(@"---->%ld", self.index);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    dispatch_suspend(_timer);
//    dispatch_source_cancel(_timer);
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
//    NSLog(@"挂起");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        CGFloat offset = scrollView.contentOffset.x;
        NSInteger pageNum = round(offset / CGRectGetWidth(self.frame));
//    NSLog(@"pagebefore:%d", pageNum, _innerIndex);
//        _innerIndex = pageNum;
//    NSLog(@"pageafter:%d", pageNum, _innerIndex);

    //    NSLog(@"启动:%d", _innerIndex);
    //    dispatch_resume(_timer);
    _innerIndex = pageNum;
    if (!_timer) {
            [self beginMove];
        }
//    NSLog(@"启动");


}

//-(NSInteger)index{
//    return _innerIndex%_imageArray.count;
//}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30000;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   LXMBannerCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LXMBannerCollectionViewCell class]) forIndexPath:indexPath];
    self.index = indexPath.row%_imageArray.count;
    cell.label.text = [NSString stringWithFormat:@"%d", self.index];
    
    NSLog(@"index%d inner:%d", self.index, self.innerIndex);

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath.row);
}
-(void)commonInit{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.0;
    _flowLayout.minimumInteritemSpacing = 0.0;
    _innerIndex = 15000;
    
    //设置item尺寸
    CGFloat itemW = CGRectGetWidth(self.frame);
    CGFloat itemH = CGRectGetHeight(self.frame);
    _flowLayout.itemSize = CGSizeMake(itemW, itemH);
    
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置水平滚动方向
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:_flowLayout];
    [self addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    
    [_collectionView registerClass:[LXMBannerCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LXMBannerCollectionViewCell class])];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_innerIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//    [self beginMove];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
