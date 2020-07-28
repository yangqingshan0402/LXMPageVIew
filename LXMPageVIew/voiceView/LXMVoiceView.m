//
//  LXMVoiceView.m
//  LXMPageVIew
//
//  Created by jason on 2020/7/28.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMVoiceView.h"

@implementation LXMVoiceView

- (void)setImageStatic{
    self.image = self.staticImage;
}
- (void)updateDynamicPercentage:(CGFloat)percentage{
    percentage += 20;
    percentage = MAX(percentage, 0);
    percentage = MIN(100, percentage);
    CGRect rect = CGRectMake(0, 0, self.dynamicImage.size.width, self.dynamicImage.size.height);
    UIGraphicsBeginImageContextWithOptions(self.dynamicImage.size, false,  self.dynamicImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.dynamicImage drawInRect:rect];
    CGContextSetRGBFillColor(context, 26/255.0, 173/255.0, 25/255.0, 1);
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGFloat y = rect.size.height;
    rect.size.height *= percentage/100;
    rect.origin.y = y - rect.size.height;
    CGContextFillRect(context, rect);
    UIImage* resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = resImage;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
