//
//  CustomLayer.h
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void (^CreateNewArrowBlock)(NSInteger times);
typedef void (^EndAnimationBlock)(void);

@interface CustomLayer : CAShapeLayer

@property (nonatomic, assign) NSTimeInterval animationTime;
@property (nonatomic, copy) CreateNewArrowBlock createNewBlock;
@property (nonatomic, copy) EndAnimationBlock endAnimationBlock;

- (instancetype)initWithRect:(CGRect)rect;

- (void)startDropAnimationTimes:(NSInteger)times
                      fromValue:(CGFloat)fromValue
                        toValue:(CGFloat)toValue
          withEndAnimationBlock:(EndAnimationBlock)block;

@end
