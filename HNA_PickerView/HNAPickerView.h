//
//  HNAPickerView.h
//  HNA_PickerView
//
//  Created by Curry on 14-4-3.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PieckerViewDoneBlock)(NSArray *selectedArray);
@interface HNAPickerView : UIViewController

/**
 *  picker的item数组
 *  设置nil 显示日期选择器
 *  设置nsarray ,二维@[@[],@[],....] 显示几列的自定义数据模型
 */
@property (nonatomic,strong)NSArray *itemsArray;
//显示pickerView
- (void)showDatePickerView;
////设置添加到父试图
- (void)addPreaSuperView:(UIView *)preaSuperView;
//反回数据
- (void)requestDate:(PieckerViewDoneBlock)block;
@end

