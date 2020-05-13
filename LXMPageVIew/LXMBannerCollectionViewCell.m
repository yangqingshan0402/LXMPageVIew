//
//  LXMBannerCollectionViewCell.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/12.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMBannerCollectionViewCell.h"

@interface LXMBannerCollectionViewCell()


@end


@implementation LXMBannerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    _bannerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_bannerImageView];
    [_bannerImageView setImage:[UIImage imageNamed:@"img2.jpg"]];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
    [self.contentView addSubview:label];
    _label  = label;
}

@end
