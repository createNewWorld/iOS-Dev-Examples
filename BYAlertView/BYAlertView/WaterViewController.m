//
//  WaterViewController.m
//  BYAlertView
//
//  Created by 包勇 on 16/10/16.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "WaterViewController.h"
#import "WaterRipple/FTWaterView.h"
#import "FTConsultButton.h"

@interface WaterViewController ()

@property (nonatomic, strong) FTWaterView *waterView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = CGSizeMake(200, 200);
    CGFloat orginX = ([UIScreen mainScreen].bounds.size.width - size.width)/2.0f;
//    self.waterView = [[FTWaterView alloc] initWithFrame:CGRectMake(orginX, 64, size.width, size.height)];
//    [self.view addSubview:self.waterView];
  
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"stopAnimation" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(orginX, 64+size.height*2, size.width, 41);
    [self.view addSubview:button];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"startAnimation" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(orginX, CGRectGetMaxY(button.frame)+41, size.width, 41);
    [self.view addSubview:button1];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(start) userInfo:nil repeats:YES];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    FTConsultButton *ftConsultBtn = [[FTConsultButton alloc] initWithFrame:CGRectMake(0, 64, 50, 46)];
    ftConsultBtn.ft_selectedImage = [UIImage imageNamed:@"consult_muteBtn_selected"];
    ftConsultBtn.ft_normalImage = [UIImage imageNamed:@"consult_muteBtn_normal"];
    ftConsultBtn.descript = @"Mute";
    [ftConsultBtn addTarget:self action:@selector(ftConsultBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [ftConsultBtn setUpSubview];
    [self.view addSubview:ftConsultBtn];
}

- (void)ftConsultBtnClicked:(UIButton *)sender
{

    if([sender isSelected]){
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}

- (void)buttonClicked:(UIButton *)sender
{
  //  [self.waterView endWaterRippleAnimation];
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)start
{
    CGSize size = CGSizeMake(200, 200);
    CGFloat orginX = ([UIScreen mainScreen].bounds.size.width - size.width)/2.0f;
    __block FTWaterView *waterView = [[FTWaterView alloc]initWithFrame:CGRectMake(orginX, 64, size.width, size.height)];
    waterView.backgroundColor = [UIColor clearColor];
    waterView.alpha = 1.0f;
    [self.view addSubview:waterView];
    
    [UIView animateWithDuration:2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         waterView.transform = CGAffineTransformScale(waterView.transform, 2, 2);
                         waterView.alpha = 0;
                     } completion:^(BOOL finished) {
                          [waterView removeFromSuperview];
                     }];
}

- (void)button1Clicked:(UIButton *)sender
{
    [self.timer setFireDate:[NSDate distantPast]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
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
