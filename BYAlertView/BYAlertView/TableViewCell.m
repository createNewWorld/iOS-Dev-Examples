//
//  TableViewCell.m
//  BYAlertView
//
//  Created by ft on 17/1/20.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "TableViewCell.h"
#import "DownloadButton.h"

@interface TableViewCell ()

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.downloadBtn = [[DownloadButton alloc] initWithFrame:CGRectMake(screenWidth - 90, 20, 40, 40)];
    [self.downloadBtn addTarget:self action:@selector(downloadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.downloadBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)downloadBtnClicked:(DownloadButton *)sender
{
    [sender setDownloadGraphicalProgress:0.0 ForState:DownloadControlStateNormal];
}

@end
