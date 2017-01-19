//
//  SelectImageCell.m
//  BYAlertView
//
//  Created by ft on 17/1/18.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "SelectImageCell.h"

@implementation SelectImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)deleteImageWithBlock:(DeleteImageBlock)deleteBlock
{
    self.deleteBlock = deleteBlock;
}
- (IBAction)deleteBtnClicked:(id)sender {
    
    if(self.deleteBlock){
        self.deleteBlock(self.cellIndex);
    }
}


@end
