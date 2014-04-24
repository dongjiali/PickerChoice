//
//  HNAPickerDateSource.m
//  HNA_PickerView
//
//  Created by Curry on 14-4-8.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#import "HNAPickerDateSource.h"
#define YESTSPACEYEAR 100
#define LASTSPACEYEAR 20
long StartYear = 0;
long EndYear = 0;

@implementation HNAPickerDateSource
- (id)init
{
    if (self = [super init]) {
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        self.timeZone = [NSTimeZone systemTimeZone];
        self.components = [[NSDateComponents alloc] init];
    }
    return self;
}

- (NSMutableArray*)getYears:(NSMutableArray *)resultDate {
    
    NSMutableArray *years = [NSMutableArray array];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    self.components = [_calendar components:unitFlags fromDate:[NSDate new]];
    //初始化起始日期
    [resultDate addObject:[NSString stringWithFormat:@"%ld", (long)self.components.year]];
    [resultDate addObject:[NSString stringWithFormat:@"%ld", (long)self.components.month]];
    [resultDate addObject:[NSString stringWithFormat:@"%ld", (long)self.components.day]];
    long year = self.components.year;
    StartYear = year - YESTSPACEYEAR;
    
    EndYear = year + LASTSPACEYEAR;
    
    
    for (long i = StartYear; i <= EndYear; i++) {
        
        [years addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    
    return years;
}

- (NSMutableArray*)getMonths {
    
    NSMutableArray *months = [NSMutableArray array];
    
    for (int monthNumber = 1; monthNumber <= 12; monthNumber++) {
        
        NSString *dateString = [NSString stringWithFormat: @"%d", monthNumber];
        
        //        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        //        if (self.timeZone != nil) [dateFormatter setTimeZone:self.timeZone];
        //        [dateFormatter setLocale:self.locale];
        //        [dateFormatter setDateFormat:@"MM"];
        //        NSDate* myDate = [dateFormatter dateFromString:dateString];
        //
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        if (self.timeZone != nil) [dateFormatter setTimeZone:self.timeZone];
        //        [dateFormatter setLocale:self.locale];
        //        [formatter setDateFormat:@"MMMM"];
        //        NSString *stringFromDate = [formatter stringFromDate:myDate];
        
        [months addObject:dateString];
    }
    
    return months;
}

- (NSMutableArray*)getDates {
    
    NSMutableArray *dates = [NSMutableArray array];
    
    NSDateComponents *dateComponents = self.components;
    [dateComponents setCalendar:self.calendar];
    [dateComponents setTimeZone:self.timeZone];
    [dateComponents setDay:1];
    [dateComponents setMonth:1];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    [dateComponents setYear:StartYear];
    
    NSDate *yearMin = [dateComponents date];
    NSDate *yearMax = [NSDate date];
    
    NSInteger timestampMin = [yearMin timeIntervalSince1970];
    NSInteger timestampMax = [yearMax timeIntervalSince1970];
    
    while (timestampMin < timestampMax) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampMin];
        
        [dates addObject:date];
        
        timestampMin += (24 * 60 * 60); // + 1 day
    }
    
    return dates;
}

- (NSMutableArray*)getDaysInMonth:(NSDate*)date {
    
    if (date == nil) date = [NSDate date];
    
    NSRange daysRange = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    NSMutableArray *days = [NSMutableArray array];
    
    for (int i = 1; i <= daysRange.length; i++) {
        
        [days addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return days;
}

- (NSDate*)convertToDateDay:(int)day month:(int)month year:(int)year{
    
    NSDateComponents *dateComponents = self.components;
    
    // Date Mode :
    [dateComponents setCalendar:self.calendar];
    [dateComponents setTimeZone:self.timeZone];
    
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    return [dateComponents date];
}

@end
