//
//  FTWaterView.m
//  BYAlertView
//
//  Created by 包勇 on 16/10/16.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "FTWaterView.h"

@interface FTWaterView () <CAAnimationDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CALayer *waterLayer;

@end

@implementation FTWaterView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self){
//      //  [self startWaterRippleAnimation];
//      //  self.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //半径
    CGFloat radius = 60;
    //开始角度
    CGFloat startAngle = 0;
    //结束角度
    CGFloat endAngle = 2*M_PI;
    //中心点
    CGPoint point = CGPointMake(rect.size.width*0.5f, rect.size.height*0.5f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    
    //#1ac7f7  26,199,247
    shapeLayer.strokeColor = [UIColor colorWithRed:(26/255.0f) green:(199/255.0f) blue:(247/255.0f) alpha:1.0f].CGColor;
    shapeLayer.lineWidth = 1.5f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:shapeLayer];
    self.waterLayer = shapeLayer;
    self.waterLayer.position = CGPointMake(0, 0);

   // self.waterLayer.zPosition = 0.0f;
 //   self.waterLayer.anchorPoint = CGPointMake(0.5, 0);
}

- (void)startWaterRippleAnimation
{
//    if(!self.timer){
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
//    }
    [self startAnimation];
}

- (void)startAnimation{
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.scale";
//    animation.fromValue = @1.0f;
//    animation.toValue = @2.0f;
//    animation.removedOnCompletion = YES;
//    //animation.fillMode = kCAFillModeForwards;
//    animation.delegate = self;
//    //animation.repeatCount = HUGE_VALF;
//    animation.duration = 1.0f;
//    
//    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
//    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
//    opacityAnimation.removedOnCompletion = YES;
//    opacityAnimation.duration = 1.5f;
    
//    CAAnimationGroup*animaGroup = [CAAnimationGroup animation];
//    animaGroup.animations = @[animation,opacityAnimation];
//    animaGroup.duration = 3.f;
//    [self.waterLayer addAnimation:opacityAnimation forKey:@"group"];
    
 
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag){
        [self.waterLayer removeAnimationForKey:@"scale"];
    }
}

- (void)endWaterRippleAnimation
{
    
    [self.timer invalidate];
}



@end
