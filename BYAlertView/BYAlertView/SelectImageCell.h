//
//  SelectImageCell.h
//  BYAlertView
//
//  Created by ft on 17/1/18.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DeleteImageBlock)(NSInteger indexPathRow);

@interface SelectImageCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger cellIndex; /* require set */
@property (nonatomic, copy) DeleteImageBlock deleteBlock;

- (void)deleteImageWithBlock:(DeleteImageBlock)deleteBlock;

@end
