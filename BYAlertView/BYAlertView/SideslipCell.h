//
//  SideslipCell.h
//  BYAlertView
//
//  Created by ft on 16/12/28.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideslipCell : UITableViewCell

- (void)configeDataWithArray:(NSArray *)array;

@end

@interface SideCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame;
- (void)configeDataWithText:(NSString *)text;

@end
