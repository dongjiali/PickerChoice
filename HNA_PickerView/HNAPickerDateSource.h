//
//  HNAPickerDateSource.h
//  HNA_PickerView
//
//  Created by Curry on 14-4-8.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNAPickerDateSource : NSObject
@property(nonatomic,strong) NSCalendar    *calendar;
@property(nonatomic,strong) NSTimeZone    *timeZone;
@property(nonatomic,strong) NSDateComponents *components;

- (NSMutableArray*)getYears:(NSMutableArray *)resultDate;

- (NSMutableArray* )getMonths;

- (NSMutableArray* )getDaysInMonth:(NSDate*)date;

- (NSDate*)convertToDateDay:(int)day month:(int)month year:(int)year;
@end
