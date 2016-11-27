//
//  ConsultNewViewController.m
//  BYAlertView
//
//  Created by ft on 16/10/17.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "ConsultNewViewController.h"
#import <Masonry/Masonry.h>
#import "FTConsultButton.h"
#import "TPImageView.h"
#import "CirleProgressView.h"

@interface ConsultNewViewController ()

{
    int _duration;
}

//顶部视图
@property (strong, nonatomic) IBOutlet UIView *topStatuView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

//底部视图
@property (nonatomic) BOOL toolViewIsShow;
@property (strong, nonatomic) IBOutlet UIView *toolView;
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) CirleProgressView *cirleView;

//医生头像视图
@property (strong, nonatomic) IBOutlet UIView *doctorAvatarView;
@property (weak, nonatomic) IBOutlet TPImageView *rippleView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;

//视频咨询视图
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *mySelfView;

@property (nonatomic, strong) NSTimer *timingTimer; //计时器

@property (nonatomic) BOOL heart;

@property (nonatomic, strong) NSThread *myThread;

@end

@implementation ConsultNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
    
    _duration = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.rippleView stopAnimating];
    [self.rippleView startRippleEffec];
    
    //假设2秒延时后开始通话
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.timingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTiming) userInfo:nil repeats:YES];
    });
    
   
    
    self.myThread = [[NSThread alloc] initWithTarget:self selector:@selector(doDelayMethod) object:nil];
    [self.myThread start];
    
    dispatch_queue_t queue_serial = dispatch_queue_create("com.helloaction.gcdSerial", DISPATCH_QUEUE_SERIAL);
    for(int i = 0; i < 10; i ++){
        dispatch_async(queue_serial, ^{
            NSLog(@"currentThread = %@", [NSThread currentThread]);
        });
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.heart = NO;
    NSLog(@"标记子线程将结束");
    [self.myThread cancel];
}

- (void)doDelayMethod
{
    NSLog(@"现在执行子线程中的方法");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.heart = YES;
        [self delayMethod];
    });

}

- (void)delayMethod
{
    if(self.heart){
        NSLog(@"每隔3秒执行一次 心跳");
        [self performSelector:@selector(delayMethod) withObject:self afterDelay:3];
    }
}

- (void)initSubview
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOrShowToolView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    //医生头像
    self.avatarView.layer.cornerRadius = 60.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.doctorAvatarView];
    [self.view addSubview:self.rippleView];
    [self.view addSubview:self.avatarView];
    NSNumber *avatarWidth = [NSNumber numberWithInteger:120];
    [self.doctorAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(144);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.rippleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(144);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(144);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    
    [self.view addSubview:self.videoView];
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    self.videoView.hidden = YES;
    
    //添加头部视图
    [self.view addSubview:self.topStatuView];
    [self.topStatuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(@210);
    }];
    
    //添加工具视图
    [self.view addSubview:self.toolView];
    self.toolView.backgroundColor = [UIColor clearColor];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(@210);
    }];
    
    [self.toolView addSubview:self.menuView];
    self.menuView.backgroundColor = [UIColor clearColor];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toolView.mas_top).offset(30);
        make.centerX.equalTo(self.toolView.mas_centerX);
        make.width.equalTo(@300);
        make.height.equalTo(@46);
    }];
    
    [self createMenuView];
    self.toolViewIsShow = YES;
}


- (void)createMenuView
{
    NSArray *iconsSelected = @[@"consult_muteBtn_selected", @"consult_pictureBtn_selected", @"consult_pillBtn_selected", @"consult_videoBtn_selected"];
    NSArray *iconsNormal = @[@"consult_muteBtn_normal", @"consult_pictureBtn_normal", @"consult_pillBtn_normal", @"consult_videoBtn_normal"];
    NSArray *desText = @[@"Mute", @"Picture", @"Pill", @"Live"];
    
    if(self.needPushDrug){
        for(int i = 0; i < 4; i ++){
            
            UIView *view = (UIView *)[self.menuView viewWithTag:(i+100)];
            view.backgroundColor = [UIColor clearColor];
            
            FTConsultButton *ftConsultBtn = [[FTConsultButton alloc] initWithFrame:CGRectMake(0, 0, 50, 46)];
            ftConsultBtn.ft_selectedImage = [UIImage imageNamed:iconsSelected[i]];
            ftConsultBtn.ft_normalImage = [UIImage imageNamed:iconsNormal[i]];
            ftConsultBtn.descript = desText[i];
            [ftConsultBtn addTarget:self action:@selector(consultBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [ftConsultBtn setUpSubview];
            ftConsultBtn.tag = (i+1000);
            [view addSubview:ftConsultBtn];
            
            [ftConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(view.mas_top);
                make.bottom.equalTo(view.mas_bottom);
                make.centerX.equalTo(view.mas_centerX);
                make.width.equalTo(@50);
            }];
            
            if(i == 2){
                //add NumberView
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = [UIColor redColor];
                label.font = [UIFont systemFontOfSize:12.0f];
                label.layer.cornerRadius = 10;
                label.layer.masksToBounds = YES;
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
                
                self.numberLabel = label;
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(view.mas_trailing).offset(-10);
                    make.centerY.equalTo(view.mas_top).offset(0);
                    make.width.equalTo(@20);
                    make.height.equalTo(@20);
                }];
                
                [self setNumber:100];
            }
        }
    }else{
        UIView *previousView = nil;
        CGFloat menuViewWidth = 300.0f;
        CGFloat buttonWidth = 50;
        CGFloat leftMargin = 30.f;
        CGFloat marginX = (menuViewWidth - buttonWidth*3 - leftMargin*2.0)*0.5;
        for(int i = 0; i < 4; i ++){

            if(i == 2){
                //not pushDrug button
            }else{
                FTConsultButton *ftConsultBtn = [[FTConsultButton alloc] initWithFrame:CGRectMake(0, 0, 50, 46)];
                ftConsultBtn.ft_selectedImage = [UIImage imageNamed:iconsSelected[i]];
                ftConsultBtn.ft_normalImage = [UIImage imageNamed:iconsNormal[i]];
                ftConsultBtn.descript = desText[i];
                [ftConsultBtn addTarget:self action:@selector(consultBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [ftConsultBtn setUpSubview];
                ftConsultBtn.tag = (i+1000);
                [self.menuView addSubview:ftConsultBtn];
                
                CGFloat btnOrginX = leftMargin;
                if(!previousView){
                    btnOrginX = leftMargin;
                }else{
                    btnOrginX = CGRectGetMaxX(previousView.frame) + marginX;
                }
                
                [ftConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.menuView.mas_top);
                    make.leading.equalTo(self.menuView.mas_leading).offset(btnOrginX);
                    make.bottom.equalTo(self.menuView.mas_bottom);
                    make.width.equalTo(@50);
                }];
                [self.menuView layoutIfNeeded];
                previousView = ftConsultBtn;
            }
        }
    }
    
    FTConsultButton *picBtn = [self.menuView viewWithTag:(1+1000)];
    if(picBtn){
        CirleProgressView *circle = [[CirleProgressView alloc] initWithFrame:CGRectMake(0, 0, picBtn.frame.size.width, picBtn.frame.size.height - 14)];
        circle.totalCount = 5;
        circle.currentCount = 0;
        [picBtn addSubview:circle];
        self.cirleView = circle;
        self.cirleView.hidden = YES;
    }
}


- (void)hideOrShowToolView
{
    [self.view layoutIfNeeded];
  
    __block CGFloat offset = 210;
    self.toolViewIsShow = !self.toolViewIsShow;
    offset = self.toolViewIsShow ? 0 : 210;
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(offset);
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
    }];
}

#pragma mark - UIResponder 
- (void)consultBtnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    NSInteger index = sender.tag - 1000;
    switch (index) {
        case 0:{ //mute button
            
        }
            break;
        case 1:{ //picture button
            
        }
            break;
        case 2:{ //pin button
            
        }
            break;
        case 3:{ //video button
            [self flipAnimation];
            if(sender.selected){
                [self.rippleView stopAnimating];
                self.videoView.hidden = NO;
            }else{
                self.videoView.hidden = YES;
            }
        }
            break;
            
        default:
            break;
    }
}

//挂断操作
- (IBAction)doHangUp:(id)sender {
    
    [self.rippleView stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.timingTimer invalidate];
    self.timingTimer = nil;
}

- (void)updateTiming
{
    _duration ++;
    int minute = (int)_duration/60;
    int second = _duration - (int)(minute*60);
    self.statusLabel.text = [NSString stringWithFormat:@"%02d:%02d", minute, second];
    
    
    self.cirleView.hidden = NO;
    int count = (int)_duration/10;
    if(count < 5){
        [self.cirleView updateCurrentCount:count];
        [self.cirleView drawProgress:(float)_duration/50.0f];
    }else{
        self.cirleView.hidden = YES;
    }
    
}

- (void)startTimingTimer
{
    [self.timingTimer setFireDate:[NSDate distantPast]];
}

- (void)endTimingTimer
{
    //关闭定时器
    [self.timingTimer setFireDate:[NSDate distantFuture]];
}


- (void)flipAnimation
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75f];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
}

- (void)animationFinished:(id)sender
{
    NSLog(@"filp animation end");
}

- (void)setNumber:(int)number
{
    NSString *str = [NSString stringWithFormat:@"%d", number];
    if(number > 99){
        str = @"99+";
    }
    self.numberLabel.text = str;
    CGSize maximumLabelSize = CGSizeMake(50, 20);//labelsize的最大值
    self.numberLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize expectSize = [self.numberLabel sizeThatFits:maximumLabelSize];
    if(expectSize.width < 20){
        expectSize.width = 20;
    }else{
        expectSize.width += 10;
    }
    [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithInteger:expectSize.width]);
    }];
    [self.numberLabel layoutIfNeeded];
}

@end
