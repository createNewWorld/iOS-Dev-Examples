//
//  DownloadButton.h
//  BYAlertView
//
//  Created by ft on 17/1/19.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DownloadControlState) {
    
    DownloadControlStateNormal = 0,
    DownloadControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
    DownloadControlStateDisabled     = 1 << 1,
    DownloadControlStateSelected     = 1 << 2,                  // flag usable by app (see below)
    DownloadControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 3, // Applicable only when the screen supports focus
    DownloadControlStateDownloading = 2 << 0, // additional flags available for download opreation
    DownloadControlStateComplete = 2 << 1,
    DownloadControlStateApplication  = 0x00FF0000,              // additional flags available for application use
    DownloadControlStateReserved     = 0xFF000000               // flags reserved for internal framework use
};

typedef void (^OpenFileBlock)(void);

@interface DownloadButton : UIButton

@property (nonatomic, copy) OpenFileBlock openBlock;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setDownloadGraphicalProgress:(CGFloat)progress ForState:(DownloadControlState)state;

@end
