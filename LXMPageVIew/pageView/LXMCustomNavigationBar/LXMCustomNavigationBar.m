//
//  LXMCustomNavigationBar.m
//  LXMPageVIew
//
//  Created by jason on 2020/5/8.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMCustomNavigationBar.h"

@interface LXMCustomNavigationBar()

@property(nonatomic, strong)UIImageView* backgroundImageView;
@property(nonatomic, strong)UIImageView* navigationBarImageView;
@end

@implementation LXMCustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_backgroundImageView];
    
    self.navigationBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, NAVIGATION_BAR_HEIGHT)];
    [self addSubview:self.navigationBarImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
