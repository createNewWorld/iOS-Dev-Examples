//
//  RoundLabel.h
//  UIAppearanceExample2
//
//  Created by southpeak on 15/7/18.
//  Copyright (c) 2015年 iosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundLabel : UILabel //<UIAppearanceContainer>

@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *borderColor UI_APPEARANCE_SELECTOR;

@end
