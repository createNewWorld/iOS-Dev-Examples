//
//  WaterHeaderView.m
//  BYAlertView
//
//  Created by ft on 17/2/6.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "WaterHeaderView.h"

@implementation WaterHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        //self.backgroundView.backgroundColor = [UIColor blueColor];
    }
    
    return self;
}

- (void)setCurrentOffsetY:(float)currentOffsetY
{
    _currentOffsetY = currentOffsetY;
    NSLog(@"currentOfsetY: %f", currentOffsetY);
}

@end
