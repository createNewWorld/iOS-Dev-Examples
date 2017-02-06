//
//  TimeAxisTableViewController.m
//  
//
//  Created by ft on 17/2/6.
//
//

#import "TimeAxisTableViewController.h"
#import "WaterHeaderView.h"

@interface TimeAxisTableViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) WaterHeaderView *headerView;

@end

@implementation TimeAxisTableViewController

static NSString *kCellId = @"normalCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"时间轴";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    [self.tableView registerClass:[WaterHeaderView class] forHeaderFooterViewReuseIdentifier:@"waterHeaderView"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.scrollEnabled = YES;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
       WaterHeaderView *kheaderView = [[WaterHeaderView alloc] initWithReuseIdentifier:@"waterHeaderView"];
        return kheaderView;
    }
    return nil;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.headerView.currentOffsetY = scrollView.contentOffset.y;
}



@end
