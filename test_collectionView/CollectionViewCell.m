//
//  CollectionViewCell.m
//  test_collectionView
//
//  Created by williamzhang on 9/23/15.
//  Copyright © 2015 williamzhang. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CommonMacro.h"

#define delIconWidth 20
#define cellHight 100

@implementation CollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //设置图片位置
        self.profilePhoto = [[UIImageView alloc]initWithFrame:CGRectMake(delIconWidth/4, delIconWidth/4, getItemWidthFormula(fDeviceWidth,collectionViewItemsInLine,collectionViewItemGap)-delIconWidth/2, cellHight-delIconWidth/4)];
        
        //设置关闭按钮位置
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(getItemWidthFormula(fDeviceWidth,collectionViewItemsInLine,collectionViewItemGap)-delIconWidth, 0, delIconWidth, delIconWidth)];

        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"delIcon"] forState:UIControlStateNormal];
        
        //注意SubView的z轴图层关系
        [self addSubview:self.profilePhoto];
        [self addSubview:self.closeButton];
        

    }
    return self;
}

@end
