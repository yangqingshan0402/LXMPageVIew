//
//  LXMArrowView.m
//  LXMPageVIew
//
//  Created by jason on 2020/9/23.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMArrowView.h"

@interface LXMArrowView()

@property (nonatomic, strong) UIBezierPath* bezierPath;
@property (nonatomic, strong) CAShapeLayer* shapeLayer;

@end

@implementation LXMArrowView
//画一个---------------^------------这样的箭头
- (void)drawLineAndRectanglePositionAtX:(CGFloat)x{
    
    if (self.bezierPath) {
        [self.shapeLayer removeFromSuperlayer];
    }
    self.bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 0, 0) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeZero];
    [self.bezierPath moveToPoint:CGPointZero];
    [self.bezierPath addLineToPoint:CGPointMake(self.frame.size.width*x - 10, 0)];
    [self.bezierPath addLineToPoint:CGPointMake(self.frame.size.width*x, -5)];
    [self.bezierPath addLineToPoint:CGPointMake(self.frame.size.width*x + 10, 0)];
    [self.bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    
    self.shapeLayer = [CAShapeLayer new];
    self.shapeLayer.fillColor = [UIColor blueColor].CGColor;
    self.shapeLayer.lineWidth = 1.0;
    self.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:self.shapeLayer];
    self.shapeLayer.path = self.bezierPath.CGPath;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
