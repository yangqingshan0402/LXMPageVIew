//
//  LXMArrowViewController.m
//  LXMPageVIew
//
//  Created by jason on 2020/9/24.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LXMArrowViewController.h"

@interface LXMArrowViewController ()

@end

@implementation LXMArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   LXMArrowView* arrowView = [[LXMArrowView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 10)];
      [self.view addSubview:arrowView];
//    arrowView.backgroundColor = [UIColor blueColor];
      [arrowView drawLineAndRectanglePositionAtX:0.5];
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
