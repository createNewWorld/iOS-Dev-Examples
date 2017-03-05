//
//  ModeChooseView.m
//  BYAlertView
//
//  Created by ft on 16/12/6.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "ModeChooseView.h"
#import <Masonry/Masonry.h>

#define kScale(x)  (x * ([UIScreen mainScreen].bounds.size.width/375.0f))

//300 * 204
@interface ModeChooseView ()

{
    CGFloat _sWidth;
    CGFloat _sHeight;
}

@property (nonatomic, strong) UIView *alphaBgView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topSeperateLineView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *onlineBtn;//线上咨询
@property (nonatomic, strong) UIButton *clinicBtn;//线下咨询

@end

@implementation ModeChooseView

- (instancetype)initWithTitle:(NSString *)title andButtonTitles:(NSArray *)btnTitles images:(NSArray *)images
{
    _sWidth = [UIScreen mainScreen].bounds.size.width;
    _sHeight = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithFrame:CGRectMake(0, 0, _sWidth, _sHeight)];
    if(self){
        [self createSubView];
        self.titleLabel.text = title;
        if(btnTitles.count >= 2){
            [self.onlineBtn setTitle:[btnTitles firstObject] forState:UIControlStateNormal];
            [self.clinicBtn setTitle:[btnTitles lastObject] forState:UIControlStateNormal];
            [self.onlineBtn setImage:[UIImage imageNamed:[images firstObject]] forState:UIControlStateNormal];
            [self.clinicBtn setImage:[UIImage imageNamed:[images lastObject]] forState:UIControlStateNormal];
        }
    }
    return self;
}

- (void)createSubView
{
    __weak ModeChooseView *weakSelf = self;
    CGFloat kContentViewWidth = 300.0f * (_sWidth / 375);
    CGFloat kContentViewHeight = 204.0f * (_sWidth / 375);;
    CGFloat kImageWidth = kScale(45.0f);
    self.alphaBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _sWidth, _sHeight)];
    self.alphaBgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    [self addSubview:self.alphaBgView];
    [self.alphaBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.leading.equalTo(weakSelf);
        make.trailing.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewClicked:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.alphaBgView addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithRed:(247/255.0f) green:(249/255.0f) blue:(248/255.0f) alpha:1.0f];
    [self addSubview:self.contentView];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(kContentViewWidth, kContentViewHeight));
    }];
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.topView];
    NSNumber *topViewHeight = [NSNumber numberWithFloat:(51.0f * (_sWidth / 375.0f))];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(topViewHeight);
    }];
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:(247/255.0f) green:(249/255.0f) blue:(248/255.0f) alpha:1.0f];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView.mas_bottom);
        make.leading.equalTo(weakSelf.topView);
        make.trailing.equalTo(weakSelf.topView);
        make.bottom.equalTo(weakSelf.contentView);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    
    if(_sWidth >= 375.0f){
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }else{
        self.titleLabel.font = [UIFont boldSystemFontOfSize:13.5f];
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.preferredMaxLayoutWidth = kContentViewWidth - 20;
    [self.titleLabel sizeToFit];
    [self.topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.topView);
        make.leading.equalTo(weakSelf.topView).offset(10);
        make.trailing.equalTo(weakSelf.topView).offset(-10);
    }];
    
    CGFloat fontSize = 14.0f;
    if(_sWidth >= 375.0f){
        fontSize = 14.0f;
    }else{
        fontSize = 12.0f;
    }
    self.onlineBtn = [[UIButton alloc] init];
    self.onlineBtn.tag = 1000;
    self.onlineBtn.backgroundColor = [UIColor whiteColor];
    [self.onlineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.onlineBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.bottomView addSubview:self.onlineBtn];
    
    self.clinicBtn = [[UIButton alloc] init];
    self.clinicBtn.tag = 1001;
    self.clinicBtn.backgroundColor = [UIColor whiteColor];
    [self.clinicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.clinicBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.bottomView addSubview:self.clinicBtn];
    
    [self.onlineBtn addTarget:self action:@selector(modelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.clinicBtn addTarget:self action:@selector(modelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    int padding = 8.0f;
    [self.onlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.bottomView.mas_centerY);
        make.leading.equalTo(weakSelf.bottomView.mas_leading).offset(padding);
        make.trailing.equalTo(weakSelf.clinicBtn.mas_leading).offset(-padding);
        make.width.equalTo(weakSelf.clinicBtn);
        make.top.equalTo(weakSelf.bottomView.mas_top).offset(padding);
        make.bottom.equalTo(weakSelf.bottomView.mas_bottom).offset(-padding);
    }];
    [self.clinicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.bottomView.mas_centerY);
        make.leading.equalTo(weakSelf.onlineBtn.mas_trailing).offset(padding);
        make.trailing.equalTo(weakSelf.bottomView.mas_trailing).offset(-padding);
        make.width.equalTo(weakSelf.onlineBtn);
        make.top.equalTo(weakSelf.bottomView.mas_top).offset(padding);
        make.bottom.equalTo(weakSelf.bottomView.mas_bottom).offset(-padding);
    }];
    [self layoutIfNeeded];
    [self setNeedsUpdateConstraints];
    CGFloat btnWidth = self.onlineBtn.frame.size.width;
   
    self.onlineBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.clinicBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.onlineBtn setImageEdgeInsets:UIEdgeInsetsMake(kScale(32) , (btnWidth - kImageWidth)*0.5, kScale(60), (btnWidth - kImageWidth)*0.5)];
    [self.clinicBtn setImageEdgeInsets:UIEdgeInsetsMake(kScale(32), (btnWidth - kImageWidth)*0.5, kScale(60), (btnWidth - kImageWidth)*0.5)];
    
    [self.onlineBtn setTitleEdgeInsets:UIEdgeInsetsMake(kScale(86), -kImageWidth, kScale(35), 0)];
    [self.clinicBtn setTitleEdgeInsets:UIEdgeInsetsMake(kScale(86), -kImageWidth , kScale(35), 0)];//
    
    self.onlineBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    self.clinicBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.masksToBounds = YES;
}

- (void)complectionBlock:(ButtonBlock)buttonBlock
{
    _buttonBlock = buttonBlock;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(window);
        make.leading.equalTo(window);
        make.trailing.equalTo(window);
        make.bottom.equalTo(window);
    }];
    __weak typeof(self) weakSelf = self;
    self.alphaBgView.alpha = 0.2;
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
        weakSelf.alphaBgView.alpha = 1.0;
        weakSelf.contentView.transform = CGAffineTransformScale(weakSelf.contentView.transform, 1.05, 1.05);
    } completion:^(BOOL finished) {
        weakSelf.alphaBgView.alpha = 1.0;
        weakSelf.contentView.transform = CGAffineTransformIdentity;
    }];
}

- (void)backgroundViewClicked:(id)sender
{
    //隐藏视图
    [self removeFromSuperview];
}

- (void)modelBtnClicked:(UIButton *)sender
{
    NSLog(@"sender.tag = %d", sender.tag);
    if(_buttonBlock){
        _buttonBlock(sender.tag - 1000);
    }
    [self removeFromSuperview];
}


@end
