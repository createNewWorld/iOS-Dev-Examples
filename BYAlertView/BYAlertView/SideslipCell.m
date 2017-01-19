//
//  SideslipCell.m
//  BYAlertView
//
//  Created by ft on 16/12/28.
//  Copyright © 2016年 BaoYong. All rights reserved.
//

#import "SideslipCell.h"

@interface SideslipCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    NSArray *_dataSource;
    UICollectionView *_ncollectionView;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SideslipCell
static NSString *timeCell = @"kTimeCell";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _ncollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) collectionViewLayout:layout];
//        _ncollectionView.delegate = self;
//        _ncollectionView.dataSource = self;
//        [self addSubview:_ncollectionView];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerClass:[SideCell class] forCellWithReuseIdentifier:timeCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configeDataWithArray:(NSArray *)array
{
    if(!array) return ;
    if(array.count > 0){
        _dataSource = array;
    }else{
        _dataSource = [[NSArray alloc] init];
    }
    [self.collectionView reloadData];
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
    return _dataSource.count;
}

//定义展示Cell显示的内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SideCell *cell = (SideCell *)[collectionView dequeueReusableCellWithReuseIdentifier:timeCell forIndexPath:indexPath];
    NSString *text = [_dataSource objectAtIndex:indexPath.row];
    [cell configeDataWithText:text];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//定义选择后 事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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

@interface SideCell ()

@property (nonatomic, strong) UIButton *timeBtn;

@end

@implementation SideCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor orangeColor];
        self.timeBtn = [[UIButton alloc] init];
        self.timeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.timeBtn];
        
        //水平方向上，timeBtn左侧与父视图左侧对齐，右侧与父视图右侧对齐
        NSArray* hConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[timeBtn]-0-|"
                                                                            options:0 metrics:nil
                                                                              views:@{@"timeBtn":self.timeBtn}];
        [NSLayoutConstraint activateConstraints:hConstraintArray];
        
        //垂直方向上，timeBtn顶部与父视图顶部对齐
        NSArray* vConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[timeBtn]-0-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"timeBtn": self.timeBtn}];
        [NSLayoutConstraint activateConstraints:vConstraintArray];
        
        [self.timeBtn addTarget:self action:@selector(timeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //timeBtn高度为父视图高度一半
//        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:self.timeBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0.0f];
//        heightConstraint.active = YES;
        
        self.timeBtn.layer.cornerRadius = self.frame.size.height/2.0f;
        self.timeBtn.layer.masksToBounds = YES;
        //2265D9
        UIColor *blueColor = [UIColor colorWithRed:(34/255.0f) green:(101/255.0f) blue:(217/255.0f) alpha:1.0f];
        self.timeBtn.layer.borderColor = blueColor.CGColor;
        self.timeBtn.layer.borderWidth = 0.5f;
    }
    return self;
}

- (void)prepareForReuse
{
    NSLog(@"prepareForReuse");
}

- (void)configeDataWithText:(NSString *)text
{
    [self.timeBtn setTitle:text forState:UIControlStateNormal];
    [self.timeBtn setTitle:text forState:UIControlStateSelected];
}

- (void)timeBtnClicked:(UIButton *)sender
{
    
}

@end
