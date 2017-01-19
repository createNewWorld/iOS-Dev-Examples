//
//  CustomLayer.m
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "CustomLayer.h"
#import <UIKit/UIKit.h>

@interface CustomLayer ()

@property (nonatomic, assign) CGRect rect;

@end

@implementation CustomLayer

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if(self){
        _rect = rect;
        self.backgroundColor = [UIColor lightGrayColor].CGColor;
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

@end
