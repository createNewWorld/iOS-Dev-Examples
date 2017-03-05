//
//  ProgressTextLayer.m
//  BYAlertView
//
//  Created by ft on 17/1/20.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "ProgressTextLayer.h"
#import <UIKit/UIKit.h>

@interface ProgressTextLayer ()

@end

@implementation ProgressTextLayer

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if(self){
        
        self.frame = CGRectMake(0, (rect.size.height - 18)*0.5, rect.size.width, 18);
        self.backgroundColor = [UIColor whiteColor].CGColor;
        self.string = @"0%";
        NSLog(@"system font name = %@", [[UIFont systemFontOfSize:14.0f] fontName]);
        self.font = (__bridge CFTypeRef _Nullable)([NSString stringWithFormat:@"%@", [[UIFont systemFontOfSize:14.0f] fontName]]);
        self.fontSize = 14.f;
        self.alignmentMode = kCAAlignmentCenter;
        self.foregroundColor = [UIColor greenColor].CGColor;
        self.borderColor = [UIColor redColor].CGColor;
        self.borderWidth = 0.5f;
    }
    return self;
}


@end
