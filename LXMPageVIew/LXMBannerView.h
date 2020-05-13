//
//  LXMBannerView.h
//  LXMPageVIew
//
//  Created by jason on 2020/5/12.
//  Copyright © 2020 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMBannerView : UIView

@property (nonatomic,strong) NSMutableArray* imageArray;
@property (nonatomic,assign) NSInteger index;
-(void)beginMove;
@end

NS_ASSUME_NONNULL_END
