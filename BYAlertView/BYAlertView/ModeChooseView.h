//
//  ModeChooseView.h
//  BYAlertView
//
//  Created by ft on 16/12/6.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock)(NSInteger index);
@interface ModeChooseView : UIView

@property (nonatomic, copy) ButtonBlock buttonBlock;

- (instancetype)initWithTitle:(NSString *)title
              andButtonTitles:(NSArray *)btnTitles
                       images:(NSArray *)images;

- (void)complectionBlock:(ButtonBlock)buttonBlock;
- (void)show;

@end
