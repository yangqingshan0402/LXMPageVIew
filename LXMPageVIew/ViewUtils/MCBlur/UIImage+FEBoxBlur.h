//
//  UIImage+FEBoxBlur.h
//  MCBlur
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 machao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (FEBoxBlur)

/**
 *  vImage模糊图片
 *
 *  @param image 原始图片
 *  @param blur  模糊数值(0-1)0 
 *
 *  @return 重新绘制的新图片
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
