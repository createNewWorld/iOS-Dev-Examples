//
//  CollectionViewController.m
//  BYAlertView
//
//  Created by ft on 17/1/18.
//  Copyright © 2017年 BaoYong. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
//use UICollectionViewDelegateFlowLayout or customCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

static NSString *cellIdentifier = @"normalCell";
- (void)initCollectionView
{
    //dataSource
    
    //create view xib awakFromNib
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    [self.collectionView registerClass:[SideCell class] forCellWithReuseIdentifier:timeCell];
    
    //by Code create
    //        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //        _ncollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) collectionViewLayout:layout];
    //        _ncollectionView.delegate = self;
    //        _ncollectionView.dataSource = self;
    //        [self addSubview:_ncollectionView];
}



#pragma mark - <UICollectionViewDataSource>
//定义展示Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView /*option*/
{
    return 1;
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//定义展示Cell显示的内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //CustomCell
    id model = [self.dataSource objectAtIndex:indexPath.row];
    //根据model显示cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //confige cell
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//定义选择后 事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //choose image
    //end set dataSource
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100 , 44);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0f;
}



@end
