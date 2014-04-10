//
//  HNAPickerView.h
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNAPickerView : UIViewController
@property (nonatomic,strong)NSArray *itemsArray;
- (void)showDatePickerView;
- (void)addPreaSuperView:(UIView *)preaSuperView;
- (id)initPickerData:(NSArray *)pickerData Section:(NSInteger)pickerSection;
@end

