//
//  LKTabbarButton.h
//  LXMPageVIew
//
//  Created by jason on 2020/11/16.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKTabbarButton : UIButton
typedef NS_ENUM(NSInteger, SLTabbarButtonType) {
    SLButtonTypeOnlyImage,  // 仅图片
    SLButtonTypeOnlyTitle,  // 仅文字
    SLButtonTypeImageLeft,       // 图片在文字左侧
    SLButtonTypeImageRight,      // 图片在文字右侧
    SLButtonTypeImageTop,        // 图片在文字上侧
    SLButtonTypeImageBottom      // 图片在文字下侧
};
@property (nonatomic, assign) SLTabbarButtonType tabbarButtonType;
// 图片和文字之间的间距
@property (nonatomic, assign) CGFloat imageTitleSpace;
// 图片区域的大小，默认为图片的大小
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat percent;// frame权重，相当于html里面flex布局的flex值.默认为0
@property (nonatomic, assign) CGFloat offsetXY; // 相对于父view的横/纵向偏移量
@end

NS_ASSUME_NONNULL_END
