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

@interface ConsultNewViewController ()

//顶部视图
@property (strong, nonatomic) IBOutlet UIView *topStatuView;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

//底部视图
@property (nonatomic) BOOL toolViewIsShow;
@property (strong, nonatomic) IBOutlet UIView *toolView;
@property (strong, nonatomic) IBOutlet UIView *menuView;

//医生头像视图
@property (strong, nonatomic) IBOutlet UIView *doctorAvatarView;
@property (weak, nonatomic) IBOutlet TPImageView *rippleView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;


@end

@implementation ConsultNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.rippleView stopAnimating];
    [self.rippleView startRippleEffec];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initSubview
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOrShowToolView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
    
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
    
    //医生头像
    self.avatarView.layer.cornerRadius = 60.0f;
    self.avatarView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.doctorAvatarView];
    [self.view addSubview:self.rippleView];
    [self.view addSubview:self.avatarView];
    NSNumber *avatarWidth = [NSNumber numberWithInteger:120];
    [self.doctorAvatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(114);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.rippleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(114);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(114);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(avatarWidth);
        make.height.equalTo(avatarWidth);
    }];
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
            [view addSubview:ftConsultBtn];
            
            [ftConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(view.mas_top);
                make.bottom.equalTo(view.mas_bottom);
                make.centerX.equalTo(view.mas_centerX);
                make.width.equalTo(@50);
            }];
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
}

- (void)consultBtnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
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


@end
