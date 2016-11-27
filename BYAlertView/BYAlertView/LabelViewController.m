//
//  LabelViewController.m
//  BYAlertView
//
//  Created by 包勇 on 16/11/17.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "LabelViewController.h"

@interface LabelViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@end

@implementation LabelViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 30;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.label.text = self.inputTF.text;
    [self.view layoutIfNeeded];
    [self.view setNeedsUpdateConstraints];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.inputTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
