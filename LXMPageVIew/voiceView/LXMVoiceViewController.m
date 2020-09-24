//
//  LXMVoiceViewController.m
//  LXMPageVIew
//
//  Created by jason on 2020/9/24.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMVoiceViewController.h"
#import "LXMVoiceView.h"

@interface LXMVoiceViewController ()

@end

@implementation LXMVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LXMVoiceView* voiceView = [[LXMVoiceView alloc] initWithFrame:CGRectMake(0, 60, 50, 50)];
    voiceView.dynamicImage = [UIImage imageNamed:@"bg_mesh_device_off"];
    [voiceView updateDynamicPercentage:30];
    [self.view addSubview:voiceView];
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
