//
//  ButtonTouchActionViewController.m
//  BYAlertView
//
//  Created by ft on 16/12/16.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "ButtonTouchActionViewController.h"
#import "SideslipCell.h"

@interface ButtonTouchActionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ButtonTouchActionViewController
static NSString *cellId = @"UITableViewCellId";
static NSString *sideslipCellId = @"sideslipCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"SideslipCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:sideslipCellId];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideslipCell *cell = (SideslipCell *)[tableView dequeueReusableCellWithIdentifier:sideslipCellId];
    [cell configeDataWithArray:@[@"09:10",@"10:10",@"10:10",@"10:10",@"10:10"]];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIResponder
- (IBAction)didEndOnExit:(id)sender {
    NSLog(@"didEndOnExit:");
}

- (IBAction)editingChanged:(id)sender {
    NSLog(@"editingChanged:");
}

- (IBAction)editingDidBegin:(id)sender {
    NSLog(@"editingDidBegin:");
}
- (IBAction)primaryActionTriggered:(id)sender {
    NSLog(@"primaryActionTriggered");
}
- (IBAction)touchCancel:(id)sender {
    NSLog(@"touchCancel");
}
- (IBAction)touchDown:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSLog(@"touchDown");
}
- (IBAction)touchDownRepeat:(id)sender {
    NSLog(@"touchDownRepeat");
}
- (IBAction)touchDragEnter:(id)sender {
    NSLog(@"touchDragEnter");
}
- (IBAction)touchDragExit:(id)sender {
    NSLog(@"touchDragExit");
}
- (IBAction)touchUpInside:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSLog(@"touchUpInside");
}
- (IBAction)touchUpOutside:(id)sender {
    NSLog(@"touchUpOutside");
}
- (IBAction)valueChanged:(id)sender {
    NSLog(@"valueChanged");
}


@end
