//
//  RoundLabel.m
//  UIAppearanceExample2
//
//  Created by southpeak on 15/7/18.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import "RoundLabel.h"
#import <objc/runtime.h>

@implementation RoundLabel

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.borderWidth = _borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    _cornerRadius = cornerRadius;
}

- (void)setRectColor:(UIColor *)rectColor {
    
    _borderColor = rectColor;
}

@end
