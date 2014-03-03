//
//  SMDateUtil.m
//  MealDeal
//
//  Created by Stephen McDonald on 2014-03-02.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "SMDateUtil.h"

static SMDateUtil *instance;

@implementation SMDateUtil

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SMDateUtil new];
    });
    return instance;
}

- (WeekDay)currentDay {
    NSDate *today = [NSDate date];
    NSDateFormatter *todayNumberDateFormatter = [[NSDateFormatter alloc] init];
    [todayNumberDateFormatter setDateFormat:@"c"];
    NSString *todayString = [todayNumberDateFormatter stringFromDate:today];
    NSInteger todayInt = [self adjustTodayIntToMondayIfNeeded:[todayString integerValue]];
    return todayInt;
}

- (NSInteger)adjustTodayIntToMondayIfNeeded:(NSInteger)todayInt {
    
    todayInt -= 2;  //offset so Monday now = 0
    
    if(todayInt < WeekDay_Monday || todayInt > WeekDay_Friday) {
        todayInt = WeekDay_Wednesday;
    }
    return todayInt;
}


@end
