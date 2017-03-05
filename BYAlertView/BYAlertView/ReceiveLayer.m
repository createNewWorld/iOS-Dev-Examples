//
//  ReceiveLayer.m
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "ReceiveLayer.h"
#import <UIKit/UIKit.h>

@interface ReceiveLayer ()

@property (nonatomic, assign) CGRect rect;

@end

@implementation ReceiveLayer

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if(self){
        _rect = rect;
        self.backgroundColor = [UIColor clearColor].CGColor;
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
    
    [path moveToPoint:[self realPointWithPoint:CGPointMake(0, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth/8.0, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth/8.0, ctxHeight*4/8.0f)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth*7/8.0, ctxHeight*2/4.0f)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth*7/8.0, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth, 0)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(ctxWidth, ctxHeight*6/8.0f)]];
    [path addLineToPoint:[self realPointWithPoint:CGPointMake(0, ctxHeight*6/8.0f)]];
    [path closePath];
    
    self.path = path.CGPath;
}

- (CGPoint)realPointWithPoint:(CGPoint)point
{
    return CGPointMake(point.x, point.y);
}

@end
