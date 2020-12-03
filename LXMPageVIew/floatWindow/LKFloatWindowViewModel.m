//
//  LKFloatWindowViewModel.m
//  LXMPageVIew
//
//  Created by jason on 2020/12/3.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LKFloatWindowViewModel.h"

@implementation LKFloatWindowViewModel

-(NSString *)imageName{
    if (!_imageName) {
        _imageName = @"float_icon";
    }
    return _imageName;
}

@end
