//
//  CollectionViewCell.h
//  test_collectionView
//
//  Created by williamzhang on 9/23/15.
//  Copyright © 2015 williamzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UIImageView *profilePhoto;

@property (strong, nonatomic) NSString *providerName;

@end
