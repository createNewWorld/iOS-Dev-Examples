//
//  CustomLayer.m
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "CustomLayer.h"
#import <UIKit/UIKit.h>

@interface CustomLayer () <CAAnimationDelegate>

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation CustomLayer

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if(self){
        _rect = rect;
       // self.backgroundColor = [UIColor lightGrayColor].CGColor;
        self.frame = _rect;
        self.fillColor = [UIColor blueColor].CGColor;
        self.strokeColor = [UIColor redColor].CGColor;
        [self createShape];
    }
    return self;
}

- (void)createShape{
    
    UIBezierPath *path = [UIBezierPath new];
    CGFloat ctxWidth = CGRectGetWidth(self.bounds);
    CGFloat ctxHeight = CGRectGetHeight(self.bounds);
    
    [path moveToPoint:[self realPointWithPoint:CGPointMake(ctxWidth/4.0, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth*3.0f/4.0, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth*3.0f/4.0, ctxHeight/2.0f)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth, ctxHeight/2.0f)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth/2.0, ctxHeight)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(0, ctxHeight/2.0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth/4.0, ctxHeight/2.0)]];
    [path closePath];
    
    self.path = path.CGPath;
}

- (CGPoint)realPointWithPoint:(CGPoint)point
{
    return CGPointMake(point.x, point.y);
}

- (void)startDropAnimationTimes:(NSInteger)times
                      fromValue:(CGFloat)fromValue
                        toValue:(CGFloat)toValue
          withEndAnimationBlock:(EndAnimationBlock)block
{
    self.time = times;
    CABasicAnimation* animation = [CABasicAnimation animation];
    animation.keyPath=@"position.y";
    animation.fromValue = @(fromValue);//该属性开始的值 self.position.y +
    animation.toValue = @(toValue);//结束的值
    animation.repeatCount = times;
    
    NSTimeInterval calucteDuration = (toValue - fromValue)/(self.bounds.size.height+5) * self.animationTime;
    animation.duration= calucteDuration;//持续时间
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//结束函数
    animation.fillMode= kCAFillModeForwards;//停在动画结束处
    animation.delegate = self;
    animation.additive = YES;
    [self addAnimation:animation forKey:nil];//添加动画
    
    if(block)
        self.endAnimationBlock = block;
}

#pragma mark - <CAAnimationDelegate>
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始下落动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag){
    
      if(self.time == 1){
          [self removeAllAnimations];
          [self removeFromSuperlayer];
      }
        if(self.endAnimationBlock){
            self.endAnimationBlock();
        }
    }
}

- (NSTimeInterval)animationTime
{
    if(!_animationTime){
        _animationTime = 1.5f;
    }
    return _animationTime;
}

@end
