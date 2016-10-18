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
#import "FTWaterImageView.h"
#import "CirleProgressView.h"

@interface ConsultNewViewController ()

{
    int _duration;
    NSString *displayPushDrugs;
    CGFloat _toolViewHeight;
    BOOL _isShowToolView;
}
//提示view
@property (strong, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ajustPhoneViewHeight;

//推药详情视图
@property (nonatomic, strong) UIView *pushDrugDetailsView;
@property (nonatomic, strong) UILabel *pushDrugLabel;

//医生头像视图
@property (strong, nonatomic) IBOutlet UIView *doctorAvatarView;
@property (weak, nonatomic) IBOutlet FTWaterImageView *rippleView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;

//视频咨询视图
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *mySelfView;

@property (nonatomic, strong) NSTimer *timingTimer; //计时器

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
    
    [self showTip:@"connss daljf  afddal  afldf a safds  asfdas " duration:10];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.rippleView stopAnimating];
    [self.rippleView stopRippleEffec];
}

#pragma mark - init Subviews
- (void)initSubview
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOrShowToolView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    //添加头部视图
    NSNumber *topOrBottomViewHeight = @210;
    _toolViewHeight = 210;
    CGFloat avatarOrginY = 144;
    if([UIScreen mainScreen].bounds.size.width <= 320){
        topOrBottomViewHeight = @180;
        avatarOrginY = 114;
        self.ajustPhoneViewHeight.constant = 104;
        _toolViewHeight = 180;
    }
    //医生头像
    self.avatarView.layer.cornerRadius = 60.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.doctorAvatarView];
    [self.view addSubview:self.rippleView];
    [self.view addSubview:self.avatarView];
    NSNumber *avatarWidth = [NSNumber numberWithInteger:120];
    [self.doctorAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(avatarOrginY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.rippleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(avatarOrginY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(avatarOrginY);
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
    
    
    [self.view addSubview:self.topStatuView];
    [self.topStatuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(topOrBottomViewHeight);
    }];
    
    //添加工具视图
    [self.view addSubview:self.toolView];
    self.toolView.backgroundColor = [UIColor clearColor];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(topOrBottomViewHeight);
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

- (void)showPushDrug
{
    if(!self.pushDrugDetailsView){
        UIView * pushDrugDetailsView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 120)];
        pushDrugDetailsView.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
        pushDrugDetailsView.layer.borderColor=[[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3]CGColor];
        pushDrugDetailsView.layer.borderWidth=1;
        pushDrugDetailsView.layer.cornerRadius=10;
        pushDrugDetailsView.layer.masksToBounds=YES;
        self.pushDrugDetailsView = pushDrugDetailsView;
    }
    [self.view addSubview:self.pushDrugDetailsView];
    [self.pushDrugDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.toolView.mas_top);
        make.centerX.equalTo(self.toolView.mas_centerX);
        make.leading.equalTo(self.toolView.mas_leading).offset(8);
        make.trailing.equalTo(self.toolView.mas_trailing).offset(-8);
        make.height.equalTo(@120);
    }];
    self.pushDrugDetailsView.alpha = 1;
    if (!self.pushDrugLabel) {
        UILabel *pushDrugLabel=[[UILabel alloc] init];
        pushDrugLabel.font=[UIFont systemFontOfSize:13];
        pushDrugLabel.textColor=[UIColor whiteColor];
        pushDrugLabel.numberOfLines=5;
        self.pushDrugLabel = pushDrugLabel;
    }
    [self.pushDrugDetailsView addSubview:self.pushDrugLabel];
    [self.pushDrugDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pushDrugDetailsView.mas_top).offset(-20);
        make.leading.equalTo(self.pushDrugDetailsView.mas_leading).offset(8);
        make.trailing.equalTo(self.pushDrugDetailsView.mas_trailing).offset(-8);
        make.top.equalTo(self.pushDrugDetailsView.mas_top).offset(20);
    }];
    self.pushDrugLabel.text=displayPushDrugs;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pushDrugDetailsView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showOrHidePushDrugView:(BOOL)isShow{
    if (isShow) {
        int time=0;
        if (_isShowToolView==NO) {
            [self showToolView];
            time=0.6;
        }
        if(self && [self respondsToSelector:@selector(showPushDrug)]){
            [self performSelector:@selector(showPushDrug) withObject:nil afterDelay:time];
        }
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            self.pushDrugDetailsView.alpha=0;
        } completion:^(BOOL finished) {
            [self.pushDrugDetailsView removeFromSuperview];
            self.pushDrugDetailsView=nil;
        }];
    }
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

//显示或者隐藏工具栏
- (void)hideOrShowToolView
{
    [self.view layoutIfNeeded];
    
    __block CGFloat offset = _toolViewHeight;
    self.toolViewIsShow = !self.toolViewIsShow;
    offset = self.toolViewIsShow ? 0 : _toolViewHeight;
    _isShowToolView = offset == 0 ? NO : YES;
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(offset);
        }];
        [self.view layoutIfNeeded];
    }];
}
//显示工具栏目
- (void)showToolView
{
    _isShowToolView = YES;
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(_toolViewHeight);
        }];
        [self.view layoutIfNeeded];
    }];
}
//更新计时器
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

//翻转动画
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

//设置推药 数目标签
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

- (void)showTip:(NSString *)tip duration:(NSTimeInterval)duration
{
    if(!tip || tip.length <= 0){
    }else{
        self.tipLabel.text = tip;
        
        CGSize size = [tip boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 104, 90)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
        
        [self.view addSubview:self.tipView];
        NSNumber *width = [NSNumber numberWithFloat:([UIScreen mainScreen].bounds.size.width - 80)];
        NSNumber *height = [NSNumber numberWithFloat:(size.height + 40)];
        
        [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(width);
            make.height.equalTo(height);
            make.top.equalTo(self.avatarView.mas_bottom).offset(60);
            make.centerX.equalTo(self.avatarView.mas_centerX);
        }];
        [self.view bringSubviewToFront:self.tipView];
        
        [UIView animateWithDuration:0.35 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{

            self.tipView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self.tipView removeFromSuperview];
            self.tipView = nil;
        }];
    }
}

@end
