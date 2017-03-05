//
//  ViewController.m
//  BYAlertView
//
//  Created by ft on 16/8/17.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "ViewController.h"
#import "FTPopOverMenu.h"
#import "WaterViewController.h"
#import "ConsultNewViewController.h"
#import "LabelViewController.h"
#import "CustomNumberKeyboardViewController.h"
#import "ButtonTouchActionViewController.h"
#import "YYTableViewController.h"
#import "TimeAxisTableViewController.h"

#import "ModeChooseView.h"
#import <testRepo/UIImage+testRepo.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation ViewController

static NSString *cellId = @"NormalCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BYAlertView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    UIImage *image = [UIImage new];
    UIImage *newImage = [image imageWithColor:[UIColor orangeColor] size:CGSizeMake(20, 20)];
    
}

- (void)loadImage
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    [cell configeWithModel:dataSource[indexPath.row]];
//    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.frame = CGRectMake(0, 0, 30, 30);
    cell.imageView.backgroundColor = [UIColor orangeColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"第一种弹窗";
            break;
        case 1:
            cell.textLabel.text = @"第二种弹窗";
            break;
        case 2:
            cell.textLabel.text = @"第三种弹窗";
            break;
        case 3:
            cell.textLabel.text = @"跟随子视图扩张label";
            break;
        case 4:
            cell.textLabel.text = @"自定义键盘，显示光标";
            break;
            
        case 5:
            cell.textLabel.text = @"ModelChooseView";
            break;
        case 6:
            cell.textLabel.text = @"ButtonAction";
            break;
            
        case 7:
            cell.textLabel.text = @"TableViewController";
            break;
        case 8:
            cell.textLabel.text = @"时间轴";
            break;
            
        default:
            break;
    }
    
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//        
//        NSString *urlStr = @"http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg";
//        NSURL *url = [NSURL URLWithString:urlStr];
//        NSError *error = nil;
//        NSData *imageData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
//        UIImage *image = [UIImage imageWithData:imageData];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = image;
//        });
//    });

    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001f)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.001f)];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
////    UIView *sender = self.navigationController.navigationItem.titleView;
//    UIView *sender = cell.textLabel;
//    [FTPopOverMenu showForSender:sender withMenu:@[@"测试1",@"测试2",@"测试1",@"测试2",@"测试1",@"测试2",@"测试1",@"测试2",@"测试1",@"测试2",@"测试1",@"测试2",@"测试1",@"测试2"] doneBlock:^(NSInteger selectedIndex) {
//        
//    } dismissBlock:^{
//        
//    }];
//    if(indexPath.row == 0){
//        ConsultNewViewController *vc = [[ConsultNewViewController alloc] init];
//        vc.needPushDrug = NO;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (indexPath.row == 1){
//        
//        ConsultNewViewController *vc = [[ConsultNewViewController alloc] init];
//        vc.needPushDrug = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if(indexPath.row == 2){
//        WaterViewController *vc = [[WaterViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if(indexPath.row == 3){
//        LabelViewController *lb = [[LabelViewController alloc] init];
//        [self.navigationController pushViewController:lb animated:YES];
//    }else if(indexPath.row == 4){
//        CustomNumberKeyboardViewController *cvc = [[CustomNumberKeyboardViewController alloc] init];
//        [self.navigationController pushViewController:cvc animated:YES];
//    }
   
}




@end
