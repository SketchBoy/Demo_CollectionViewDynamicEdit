//
//  ViewController.m
//  test_collectionView
//
//  Created by williamzhang on 9/23/15.
//  Copyright © 2015 williamzhang. All rights reserved.
//


#import "ViewController.h"
#import "CollectionViewCell.h"
#import "CommonMacro.h"

NS_ENUM(NSInteger, ProviderEditingState)
{
    ProviderEditStateNormal,
    ProviderEditStateDelete
};

@interface ViewController ()

@property (nonatomic, strong)NSArray *defaultArray;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (assign) enum ProviderEditingState currentEditState;

@end

// UICollectionViewCell storyboard id
NSString *kCellID = @"cellID";

@implementation ViewController

#pragma mark -- Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self collectionView]setBackgroundColor:[UIColor whiteColor]];
    
    [self setNavi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UI Setting

- (void)setNavi
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(rightBtnClicked)];
    rightButton.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}


#pragma mark -- UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

// 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    CollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    NSString *imageName = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.profilePhoto.image = [UIImage imageNamed:imageName];
    cell.profilePhoto.tag = indexPath.row;
    
    // 单击图片手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto.userInteractionEnabled = YES;
    [cell.profilePhoto addGestureRecognizer:singleTap];
    
    cell.closeButton.tag = indexPath.row;

    // 点击编辑按钮触发事件
    if(self.currentEditState == ProviderEditStateNormal)
    {
        cell.closeButton.hidden = YES;
    }
    else
    {
        if (indexPath.row != self.dataArray.count - 1)
        {
            cell.closeButton.hidden = NO;
        }
        else
        {
            cell.closeButton.hidden = YES;
        }
    }
    
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark -- UICollectionView FlowLayout Delegate

// 定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(getItemWidthFormula(fDeviceWidth,collectionViewItemsInLine,collectionViewItemGap), 100);
}

// 定义每个Section距离上左下右的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(collectionViewItemGap, collectionViewItemGap, 30, collectionViewItemGap);
}

// 定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark -- Lazy Load

- (NSArray *)defaultArray
{
    if (!_defaultArray)
    {
        self.defaultArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
    }
    
    return _defaultArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        self.dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    }
    
    return _dataArray;
}

#pragma mark -- Navi Item Event

- (void)rightBtnClicked
{
    if (self.currentEditState == ProviderEditStateNormal)
    {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        self.currentEditState = ProviderEditStateDelete;
        
        for(CollectionViewCell *cell in self.collectionView.visibleCells)
        {
            
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            if (indexPath.row != (self.dataArray.count - 1)){
                [cell.closeButton setHidden:NO];
            }
        }
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.currentEditState = ProviderEditStateNormal;
        [self.collectionView reloadData];
    }
}

#pragma mark -- UITapGestureRecognizer Event

- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    
    NSInteger index = tableGridImage.tag;
    
    if (index == (_dataArray.count -1) )
    {
        degLog(@"添加操作");

        NSString *tempImageName = [self.defaultArray objectAtIndex:(arc4random() % [self.defaultArray count])];
        [self.dataArray insertObject:tempImageName atIndex:self.dataArray.count - 1];
        [self.collectionView reloadData];
    }
    else
    {
        degLog(@"点击图片");
    }
}

#pragma mark -- UIButton Event

- (void)deletePhoto: (UIButton *)sender
{
    degLog(@"点击删除");
    [self.dataArray removeObjectAtIndex:sender.tag];
    [self.collectionView reloadData];
}




@end
