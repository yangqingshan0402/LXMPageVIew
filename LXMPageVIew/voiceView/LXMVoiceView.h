//
//  LXMVoiceView.h
//  LXMPageVIew
//
//  Created by jason on 2020/7/28.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMVoiceView : UIImageView

@property (nonatomic, strong) UIImage* dynamicImage;
@property (nonatomic, strong) UIImage* staticImage;

- (void)setImageStatic;
- (void)updateDynamicPercentage:(CGFloat)percentage;

@end

NS_ASSUME_NONNULL_END
