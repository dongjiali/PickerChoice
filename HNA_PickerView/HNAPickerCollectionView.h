//
//  HNAPickerCollectionView.h
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNAPickerCollectionView : UICollectionView<UICollectionViewDataSource>

@property (nonatomic,strong)NSArray *cellItemArray;
@property (nonatomic,assign)NSInteger selectedItemTag;
- (void)highlightCellWithIndexPathRow:(NSUInteger)indexPathRow;
@end
