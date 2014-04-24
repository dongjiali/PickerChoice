//
//  HNAPickerCollectionView.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HNAPickerCollectionView.h"
#import "HNAPickerCollectionViewCell.h"
#import "HNAPickerMacro.h"


//Editable constants
@implementation HNAPickerCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        [self registerClass:[HNAPickerCollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
        [self setContentInset:UIEdgeInsetsMake(BAR_SEL_ORIGIN_Y, 0, BAR_SEL_ORIGIN_Y, 0)];
        self.backgroundColor = [UIColor clearColor];
        [self setScrollEnabled:YES];
        [self setShowsVerticalScrollIndicator:NO];
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HNAPickerCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    if (indexPath) {
        cell.cellLabel.text = self.cellItemArray[indexPath.row];
        [cell.cellLabel setTextColor:indexPath.row == _selectedItemTag?WHITE_COLOR:TEXT_COLOR];
    }
    return cell;
}

- (void)highlightCellWithIndexPathRow:(NSUInteger)indexPathRow
{
    self.selectedItemTag = indexPathRow;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
