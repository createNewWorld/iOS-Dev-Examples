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
#import "ProgressTextLayer.h"

@interface DownloadButton ()

{
    CustomLayer *_layer;
    CAShapeLayer *_layer1;
    ReceiveLayer *_layer2;
    
    NSTimeInterval intervalTime; //箭头下落 时间间隔
    
    NSInteger _encounter;
    
    ProgressTextLayer *textLayer;
    NSTimer *timer;
}

@property (nonatomic, assign) DownloadControlState status;

@end

@implementation DownloadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        _encounter = 0;
        self.backgroundColor = [UIColor whiteColor];
   //     _layer = [[CustomLayer alloc] initWithRect:CGRectMake(frame.size.width/4.0f, 5, frame.size.width*0.5, frame.size.height * 5/8.0)];
    //    [self.layer insertSublayer:_layer above:self.layer];
        
    //    _layer1 =[[CAShapeLayer alloc] init];
    //    _layer1.frame = CGRectMake(0, (6/8.0f) *frame.size.height, frame.size.width, frame.size.height*3/8.0f);
   //     _layer1.backgroundColor = [UIColor whiteColor].CGColor;
   //     [self.layer insertSublayer:_layer1 above:self.layer];
        
   //     _layer2 = [[ReceiveLayer alloc] initWithRect:CGRectMake(frame.size.width/16.0f, frame.size.height*5/8.0f, frame.size.width*7/8.0f, frame.size.height*3/8.0f)];
   //     [self.layer insertSublayer:_layer2 above:self.layer];
        
  
        
        //遮罩
  //      CALayer * _layer3 = [[CAShapeLayer alloc] init];
 //       _layer3.frame = CGRectMake(0, 0, 40, 5);
  //      _layer3.backgroundColor = [UIColor whiteColor].CGColor;
 //       [self.layer insertSublayer:_layer3 above:self.layer];

 //       self.layer.borderWidth = 0.5;
 //       self.layer.borderColor = [UIColor redColor].CGColor;
  //      self.layer.masksToBounds = YES;
        
        textLayer= [[ProgressTextLayer alloc] initWithRect:self.frame];
        [self.layer insertSublayer:textLayer above:self.layer];
        
       
    }
    return self;
}

- (void)setDownloadGraphicalProgress:(CGFloat)progress ForState:(DownloadControlState)state
{
    self.status = state;
    if(state == DownloadControlStateNormal){
        NSLog(@"start download file Clicked:");
        [self setDownloadGraphicalProgress:progress ForState:DownloadControlStateDownloading];
    }else if (state == DownloadControlStateDownloading){
        
        self.userInteractionEnabled = NO;
        //and download animation
        //[NSTimer scheduledTimerWithTimeInterval: target: selector:  userInfo:nil repeats:YES];
        timer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
        NSLog(@"start download file Clicked:");

    }else if (state == DownloadControlStateComplete){
        
        //can open file
        self.userInteractionEnabled = YES;
        NSLog(@"open file Clicked:");
        
        if(self.openBlock)
            self.openBlock();
    }
}

- (void)updateProgress:(NSNotification *)noti
{
    _encounter ++;
    if(_encounter > 99){
        _encounter = 100;
    }
    if(_encounter == 100){
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             textLayer.string = @"Open";
             self.status = DownloadControlStateComplete;
         });
    }else{
       textLayer.string = [NSString stringWithFormat:@"%ld%%", _encounter];
    }
}

- (void)shapeAnimation
{
    CGFloat width = 40;
    CGFloat height = width* 5/8.0;
    [_layer startDropAnimationTimes:1 fromValue:0 toValue:height withEndAnimationBlock:nil];
    NSTimeInterval page = (40.0)/45.0f * _layer.animationTime;
    
    CustomLayer *layer1 = [[CustomLayer alloc] initWithRect:CGRectMake(width/4.0f, -height, width*0.5, height)];
    [self.layer insertSublayer:layer1 below:_layer1];
    
    [layer1 startDropAnimationTimes:HUGE_VAL fromValue:0 toValue: (height+5)*2 withEndAnimationBlock:nil];
    
    CustomLayer *layer2 = [[CustomLayer alloc] initWithRect:CGRectMake(width/4.0f, -height, width*0.5, height)];
    [self.layer insertSublayer:layer2 below:_layer1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(page * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer2 startDropAnimationTimes:HUGE_VAL fromValue:0 toValue:(height+5)*2 withEndAnimationBlock:nil];
    });
    
    
    //   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //      self.status = DownloadControlStateComplete;
    //      [self pauseLayer:layer1];
    //      [self pauseLayer:layer2];
    
    //      self.userInteractionEnabled = YES;
    // });
}

#pragma mark -
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}


- (void)dealloc
{
    NSLog(@"cell 释放");
}


@end
