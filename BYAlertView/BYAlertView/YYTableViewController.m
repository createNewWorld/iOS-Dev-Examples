//
//  TableViewController.m
//  BYAlertView
//
//  Created by ft on 17/1/20.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "YYTableViewController.h"
#import "TableViewCell.h"

@interface YYTableViewController ()

@end

@implementation YYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil]  forCellReuseIdentifier:@"tableViewCell"];
    self.tableView.rowHeight = 80.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    NSLog(@"dtn = %@", cell.downloadBtn);
    return cell;
}


@end
