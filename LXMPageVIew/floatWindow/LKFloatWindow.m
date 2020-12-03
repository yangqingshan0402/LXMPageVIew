//
//  LKFloatWindow.m
//  LXMPageVIew
//
//  Created by jason on 2020/12/3.
//  Copyright © 2020 jason. All rights reserved.
//

#import "LKFloatWindow.h"

#import "LXM-PrefixHeader.pch"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface LKFloatWindow()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

@end

@implementation LKFloatWindow
-(LKFloatWindowViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LKFloatWindowViewModel alloc] init];
    }
    return _viewModel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert;
        [self makeKeyAndVisible];
        _iconImageView = [[UIImageView alloc]initWithFrame:(CGRect){0, 0,frame.size.width, frame.size.height}];
        _iconImageView.image = [UIImage imageNamed:self.viewModel.imageName];
//        _imageView.alpha = 0.3;
        [self addSubview:_iconImageView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
//        [self initbutton];
        [self setRootViewController:[UIViewController new]];
        self.currentOrientation = UIInterfaceOrientationPortrait;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
//        if (@available(iOS 13.0, *)) {
//            self.windowScene = [[UIWindowScene alloc] init];
//        }
    }
    return self;
}
#define KDEAISellDegreesToRadians(degrees) (degrees * M_PI / 180)
- (void)statusBarOrientationChange:(NSNotification*)notification{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [self setTransform:[self transformForOrientation:orientation]];
    self.currentOrientation = orientation;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        self.frame = CGRectMake(KDEAISellFloatWindowHeight+KDEAISellFloatWindowBottomSpace, screenWidth - KDEAISellFloatWindowWidth , KDEAISellFloatWindowWidth, KDEAISellFloatWindowHeight);
    }else{
        self.frame = CGRectMake(screenWidth - KDEAISellFloatWindowWidth, screenHeight - KDEAISellFloatWindowHeight - KDEAISellFloatWindowBottomSpace , KDEAISellFloatWindowWidth, KDEAISellFloatWindowHeight);
    }
}

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    
    switch (orientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(-KDEAISellDegreesToRadians(90));
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(KDEAISellDegreesToRadians(90));
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(KDEAISellDegreesToRadians(180));
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformMakeRotation(KDEAISellDegreesToRadians(0));
    }
}
//改变位置
//横屏之后的坐标系变为左下角坐标系，其中x轴向上，y轴向右，在这样的坐标系中计算即可
-(void)locationChange:(UIPanGestureRecognizer*)pan
{
    if (self.floatType == KDEAISellFloatWindowTypeNormal) {//如果是普通的则不可滑动
        return;
    }
    
    if  (self.currentOrientation == UIInterfaceOrientationLandscapeRight || self.currentOrientation == UIInterfaceOrientationLandscapeLeft) {//如果是横屏
        
        if (self.floatType & KDEAISellFloatWindowTypeSupportLandscapeSpringToBounds) {//横屏弹到边框效果
            [self springToBoundsOnLandscape:pan];

        } else if (self.floatType & KDEAISellFloatWindowTypeSupportLandscapePan){//横屏的拖动
            [self landscapePan:pan];
        }

    } else{ //如果是竖屏
        if (self.floatType & KDEAISellFloatWindowTypeSupportPortraitPan) {//竖屏拖动
            
            [self portraitPan:pan];
        }else if (self.floatType & KDEAISellFloatWindowTypeSupportPortraitSpringToBounds) {//竖屏弹到边框
            [self springToBoundsOnPortrait:pan];
        }
    }

    
    //    touchpoint=self.frame.origin;
}
- (void)portraitPan:(UIPanGestureRecognizer*)panGesture{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [[UIApplication sharedApplication] keyWindow];
    CGPoint panPoint = [panGesture locationInView:[[UIApplication sharedApplication] windows][0]];
    if(panGesture.state == UIGestureRecognizerStateBegan)
       {
           [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
           _iconImageView.alpha = 0.8;
       } else if (panGesture.state == UIGestureRecognizerStateChanged)
       {
           if (panPoint.x < WIDTH/2) {
               panPoint.x = WIDTH/2;
           } else if (panPoint.x > screenWidth - WIDTH/2) {
               panPoint.x = screenWidth - WIDTH/2;
           }
           if (panPoint.y < STATUS_BAR_HEIGHT + HEIGHT/2) {
               panPoint.y = STATUS_BAR_HEIGHT + HEIGHT/2;
           } else if (panPoint.y > screenHeight - HEIGHT/2) {
               panPoint.y = screenHeight - HEIGHT/2;
           }
           self.center = CGPointMake(panPoint.x,  panPoint.y);
       } else if(panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
       {
           _iconImageView.alpha = 1.0;
       }
}

- (void)landscapePan:(UIPanGestureRecognizer*)panGesture{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [[UIApplication sharedApplication] keyWindow];
    CGPoint panPoint = [panGesture locationInView:[[UIApplication sharedApplication] windows][0]];
    panPoint = CGPointMake(screenHeight - panPoint.y, panPoint.x);
    
    if(panGesture.state == UIGestureRecognizerStateBegan)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
        _iconImageView.alpha = 0.8;
    } else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        if (panPoint.x < HEIGHT/2) {
            panPoint.x = HEIGHT/2;
        } else if (panPoint.x > screenHeight - HEIGHT/2) {
            panPoint.x = screenHeight - HEIGHT/2;
        }
        if (panPoint.y < STATUS_BAR_HEIGHT + WIDTH/2) {
            panPoint.y = STATUS_BAR_HEIGHT + WIDTH/2;
        } else if (panPoint.y > screenWidth - WIDTH/2) {
            panPoint.y = screenWidth - WIDTH/2;
        }
        self.center = CGPointMake(panPoint.x,  panPoint.y);
    } else if(panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
    {
        _iconImageView.alpha = 1.0;
    }
}

- (void)springToBoundsOnPortrait:(UIPanGestureRecognizer*)panGesture{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [[UIApplication sharedApplication] keyWindow];
    CGPoint panPoint = [panGesture locationInView:[[UIApplication sharedApplication] windows][0]];
    if(panGesture.state == UIGestureRecognizerStateBegan)
       {
//           [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
           _iconImageView.alpha = 0.8;
       } else if (panGesture.state == UIGestureRecognizerStateChanged)
       {
           self.center = CGPointMake(panPoint.x,  panPoint.y);
       } else if(panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
       {
           _iconImageView.alpha = 1.0;
      
           NSLog(@"ss");
           if(panPoint.x <= screenWidth/2)
           {
               if(panPoint.y >= screenHeight-HEIGHT/2-40 )//左下边界判断
               {
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(WIDTH/2, screenHeight-HEIGHT/2);
                   }];
                   
               } else if (panPoint.y < (HEIGHT/2 + STATUS_BAR_HEIGHT)) {
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(WIDTH/2, HEIGHT/2 + STATUS_BAR_HEIGHT);
                       
                   }];
               } else{
                   //                        CGFloat pointy = panPoint.y < (HEIGHT/2 + LXMSTATUS_BAR_HEIGHT)? (HEIGHT/2 + LXMSTATUS_BAR_HEIGHT) :panPoint.y;//左上边界与正常拖动
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(WIDTH/2, panPoint.y);
                   }];
               }
           }
           else if(panPoint.x > screenWidth/2)
           {
               if(panPoint.y <= (HEIGHT/2 + STATUS_BAR_HEIGHT))//向右越过上边界
               {
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(screenWidth-WIDTH/2, HEIGHT/2 + STATUS_BAR_HEIGHT);
                   }];
                   
               }
               else if (panPoint.y > screenHeight-HEIGHT/2) {//右下边界
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(screenWidth-WIDTH/2, screenHeight-HEIGHT/2);
                   }];
                   
               }else{//正常拖动
                   [UIView animateWithDuration:0.2 animations:^{
                       self.center = CGPointMake(screenWidth-WIDTH/2, panPoint.y);
                   }];
                   
               }
           }
       }
    
}

- (void)springToBoundsOnLandscape:(UIPanGestureRecognizer*)panGesture{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    [[UIApplication sharedApplication] keyWindow];
    CGPoint panPoint = [panGesture locationInView:[[UIApplication sharedApplication] windows][0]];
    
    panPoint = CGPointMake(screenHeight - panPoint.y, panPoint.x);
    
    
    NSLog(@"screenWidth:%f, panPoint:%@", screenWidth, NSStringFromCGPoint(panPoint));
    
    if(panGesture.state == UIGestureRecognizerStateBegan)
    {
        _iconImageView.alpha = 0.8;
    } else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x,  panPoint.y);
        
    } else if(panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
    {
        _iconImageView.alpha = 1.0;
        if(panPoint.y <= screenWidth/2)
        {
            if (panPoint.x <= HEIGHT/2 + STATUS_BAR_HEIGHT) {
                [UIView animateWithDuration:0.2 animations:^{//左下角
                    self.center = CGPointMake(WIDTH/2, HEIGHT/2 + STATUS_BAR_HEIGHT);
                }];
            }else if (panPoint.x >= screenHeight - HEIGHT/2){//左上角
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(screenHeight - HEIGHT/2, HEIGHT/2 + STATUS_BAR_HEIGHT);
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2 + STATUS_BAR_HEIGHT);
                }];
                
            }
        }
        else if(panPoint.y > screenWidth/2)
        {
            if (panPoint.x <= HEIGHT/2) {//右下角
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(HEIGHT/2,  screenWidth - WIDTH/2);
                }];
            }else if (panPoint.x >= screenHeight - HEIGHT/2){//右上角
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(screenHeight - HEIGHT/2, screenWidth - WIDTH/2);
                }];
            }else{
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x , screenWidth - WIDTH/2);
                }];
            }
            
        }
    }
    
}

//点击事件
-(void)click:(UITapGestureRecognizer*)t
{
    _iconImageView.alpha = 0.8;
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.iconImageView.alpha = 1.0;
        self.userInteractionEnabled = YES;
    });
    if (self.clickAction) {
        self.clickAction();
    }
//    [self buttonchange];
//    [self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
}
-(void)changeColor
{
    [UIView animateWithDuration:2.0 animations:^{
        self.iconImageView.alpha = 0.3;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
