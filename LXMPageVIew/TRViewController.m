//
//  TRViewController.m
//  LXMPageVIew
//
//  Created by jason on 2020/9/24.
//  Copyright © 2020 jason. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)NSMutableArray* viewControllerList;

@property (nonatomic, strong)NSArray* titleArray;

@end

@implementation TRViewController

- (NSMutableArray *)viewControllerList{
    if (!_viewControllerList) {
        _viewControllerList = [@[@"LXMArrowViewController", @"LXMVoiceViewController", @"LXMPageViewController", @"LMHWaterFallController", @"LKDirectionButtonViewController", @"LKNumberOfLabelsViewController", @"LKFloatWindowViewController"] mutableCopy];
    }
    return _viewControllerList;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"贝塞尔曲线画箭头", @"声音麦克风特效", @"类似淘宝吸顶效果", @"瀑布流", @"带方向的button", @"多行label排列转行", @"悬浮窗"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewControllerList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController* viewController = [[NSClassFromString(self.viewControllerList[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
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
