//
//  ViewController.m
//  lalal
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 Shinow. All rights reserved.
//

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#import "LKNumberOfLabelsViewController.h"

@interface LKNumberOfLabelsViewController ()
{
    NSMutableArray *_arrayM;
}
@end

@implementation LKNumberOfLabelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _arrayM = [[NSMutableArray alloc] initWithObjects:@"wodskggjkhjkhjkhjkhjklljkafsfaf",@"ainimemeda",@"lalla",@"hahha",@"ainimememda", nil];
    
    [self creatUI];
}

- (void)creatUI
{
    
    float x = 20;
    float y = 190;
    
    
    int i = 0;
    for (NSString *str in _arrayM) {
        CGSize size = CGSizeMake(320,2000); //设置一个行高上限
//        NSParagraphStyle* paragraphStyle = [NSParagraphStyle defaultParagraphStyle];
//        [paragraphStyle ];
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGSize labelsize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading   attributes:attribute context:nil].size;
        NSLog(@"size.width=%f, size.height=%f", labelsize.width, labelsize.height);
        
        if (kScreen_Width - x < labelsize.width + 40) {
            x = 20;
            y += 40;
            if (y + 60 > kScreen_Height) {
               
            }
        }
        UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(x, y, labelsize.width + 20, 30)];
        view.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:view];
        view.tag = 8000 + i;
        NSLog(@"%ld", view.tag);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 3;
        view.attributedText = [[NSMutableAttributedString alloc] initWithString:_arrayM[i] attributes:attribute];
        view.textAlignment = NSTextAlignmentCenter;
        
        
        x += view.frame.size.width + 15;
        i++;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
