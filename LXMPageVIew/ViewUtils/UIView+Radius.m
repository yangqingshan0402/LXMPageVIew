//
//  UIView+Radius.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/21.
//  Copyright © 2020 jason. All rights reserved.
//

#import "UIView+Radius.h"


@implementation UIView (Radius)

-(void)setCornerRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners
    cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    // 设置大小
    maskLayer.frame = self.bounds;
    // 设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
