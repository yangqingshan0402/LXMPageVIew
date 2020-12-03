//
//  LKFloatWindowManager.h
//  LXMPageVIew
//
//  Created by jason on 2020/12/3.
//  Copyright © 2020 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKFloatWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKFloatWindowManager : NSObject

@property (nonatomic, strong) LKFloatWindow* floatWindow;

- (void)initFloatWindow;

+(instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
