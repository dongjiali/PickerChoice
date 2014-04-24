//
//  HNAPickerCollectionViewCell.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HNAPickerCollectionViewCell.h"
#import "HNAPickerMacro.h"
@implementation HNAPickerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        self.cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        self.cellLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.cellLabel.textAlignment = NSTextAlignmentCenter;
        self.cellLabel.font = [UIFont systemFontOfSize:17.0];
        self.cellLabel.backgroundColor = [UIColor clearColor];
        self.cellLabel.textColor = TEXT_COLOR;
        self.selected = NO;
        [self.contentView addSubview:self.cellLabel];
    }
    return self;
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
