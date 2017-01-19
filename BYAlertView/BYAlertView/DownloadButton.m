//
//  DownloadButton.m
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "DownloadButton.h"
#import "CustomLayer.h"
#import "ReceiveLayer.h"

@interface DownloadButton ()

{
    CustomLayer *_layer;
    ReceiveLayer *_layer2;
}


@end

@implementation DownloadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _layer = [[CustomLayer alloc] initWithRect:CGRectMake(frame.size.width/4.0f, 5, frame.size.width*0.5, frame.size.height * 5/8.0)];
        [self.layer insertSublayer:_layer above:self.layer];
        
        CAShapeLayer *layer1 =[[CAShapeLayer alloc] init];
        layer1.frame = CGRectMake(0,( 0.6/ 8.0f) *frame.size.height, frame.size.width, frame.size.height*3/8.0f);
        layer1.backgroundColor = [UIColor whiteColor].CGColor;
        [self.layer insertSublayer:layer1 above:self.layer];
        
        _layer2 = [[ReceiveLayer alloc] initWithRect:CGRectMake(frame.size.width/16.0f, frame.size.height*5/8.0f, frame.size.width*7/8.0f, frame.size.height*3/8.0f)];
        [self.layer insertSublayer:_layer2 above:self.layer];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setDownloadGraphicalProgress:(CGFloat)progress ForState:(DownloadControlState)state
{
    if(state == DownloadControlStateNormal){
        
    }else if (state == DownloadControlStateDownloading){
        
        [self addDownloadAnimation];
    }else if (state == DownloadControlStateComplete){
        
    }
}

- (void)addDownloadAnimation
{
    CABasicAnimation* animation = [CABasicAnimation animation];
    animation.keyPath=@"position.y";//KVC的方式来访问属性
    animation.fromValue= @(_layer.position.y);//该属性开始的值
    animation.toValue= @(_layer.position.y+ 90 * 0.375);//结束的值
    animation.repeatCount = 10;
    animation.duration= 5;//持续时间
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//结束函数
    animation.fillMode= kCAFillModeForwards;//停在动画结束处
    
    [_layer addAnimation:animation forKey:@"basic"];//添加动画
}


@end
