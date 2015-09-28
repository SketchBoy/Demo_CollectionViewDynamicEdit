//
//  CommonMacro.h
//  test_collectionView
//
//  Created by williamzhang on 9/28/15.
//  Copyright © 2015 williamzhang. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


#endif /* CommonMacro_h */

//统一定义UI参数

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)

#define getItemWidthFormula(W, n, x) (W/n - (n+1.0)/n*x)
#define collectionViewItemGap 5
#define collectionViewItemsInLine 2

#define MYDEBUG 1
#define degLog(x) { if(MYDEBUG)   NSLog(x); }
