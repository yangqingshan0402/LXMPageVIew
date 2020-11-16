//
//  LKDirectionButtonViewController.m
//  LXMPageVIew
//
//  Created by jason on 2020/11/16.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LKDirectionButtonViewController.h"
#import "LKTabbarButton.h"

@interface LKDirectionButtonViewController ()

@end

@implementation LKDirectionButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LKTabbarButton* button = [[LKTabbarButton alloc] init];
    [self.view addSubview:button];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"bg_mesh_device_off"] forState:UIControlStateNormal];
//    button.imageSize = CGSizeMake(20, 20);
    button.tabbarButtonType = SLButtonTypeImageTop;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.equalTo(@50);
    }];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
