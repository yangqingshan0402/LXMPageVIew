//
//  LMHShopCell.m
//  WateFallLayoutTest
//
//  Created by 刘梦桦 on 2017/5/19.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "LMHShopCell.h"
#import "LMHShop.h"
#import "UIImageView+WebCache.h"

@interface LMHShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation LMHShopCell

/**
 * 重写商品的setter方法
 */
- (void)setShop:(LMHShop *)shop{
    
    _shop = shop;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 价格
    self.priceLabel.text = shop.price;
}
@end
