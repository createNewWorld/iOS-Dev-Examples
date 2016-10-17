//
//  FTConsultButton.m
//  BYAlertView
//
//  Created by ft on 16/10/17.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "FTConsultButton.h"

//#1accff
#define kDefualt_SelectTitleColor [UIColor colorWithRed:(26/255.0f) green:(204/255.0f) blue:(255/255.0f) alpha:1.0f]

@interface FTConsultButton ()

{
    UIColor *_ft_selectedColor;
    UIColor *_ft_normalColor;
    UIImage *_ft_selectedImage;
    UIImage *_ft_normalImage;
    NSString *_descript;
    
    UIColor *_previousColor;
}

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *descriptLabel;

@end

@implementation FTConsultButton
@synthesize ft_normalImage = _ft_normalImage, ft_selectedImage = _ft_selectedImage, descript = _descript, selected = _selected;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpSubview
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnHeight = height * 0.7;
    self.imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, btnHeight)];
    [self.imageButton setImage:self.ft_normalImage forState:UIControlStateNormal];
    [self.imageButton setImage:self.ft_selectedImage forState:UIControlStateSelected];
    self.imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageButton.userInteractionEnabled = NO;
    [self addSubview:self.imageButton];
    
    self.descriptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight, width, 15)];
    self.descriptLabel.text = self.descript;
    self.descriptLabel.font = [UIFont systemFontOfSize:13.0f];
    self.descriptLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptLabel.textColor = self.ft_normalColor;
    [self addSubview:self.descriptLabel];
}

#pragma mark - setter and getter
- (void)setFt_selectedColor:(UIColor *)ft_selectedColor
{
    _ft_selectedColor = ft_selectedColor;
}

- (void)setFt_normalColor:(UIColor *)ft_normalColor
{
    _ft_selectedColor = ft_normalColor;
}

- (UIColor *)ft_normalColor
{
    if(!_ft_normalColor){
        return [UIColor whiteColor];
    }else{
        return _ft_normalColor;
    }
}

- (UIColor *)ft_selectedColor
{
    if(!_ft_selectedColor){
        return kDefualt_SelectTitleColor;
    }else{
        return _ft_selectedColor;
    }
}

- (UIImage *)ft_selectedImage
{
    return _ft_selectedImage;
}

- (UIImage *)ft_normalImage
{
    return _ft_normalImage;
}

- (void)setSelected:(BOOL)selected
{
    self.imageButton.selected = selected;
    self.descriptLabel.textColor = selected ? self.ft_selectedColor : self.ft_normalColor;
    _selected = selected;
}

- (BOOL)isSelected
{
    return _selected;
}

- (void)setDescript:(NSString *)descript
{
    _descript = descript;
}

- (NSString *)descript
{
    return _descript;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
    self.adjustsImageWhenHighlighted = NO;
    
//    self.imageButton.highlighted = highlighted;
//    _previousColor = self.descriptLabel.textColor;
//    if(highlighted){
//        self.descriptLabel.textColor = [UIColor lightGrayColor];
//    }else{
//        self.descriptLabel.textColor = _previousColor;
//    }
}

@end
