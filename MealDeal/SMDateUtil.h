//
//  SMDateUtil.h
//  MealDeal
//
//  Created by Stephen McDonald on 2014-03-02.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMDateUtil : NSObject

+ (instancetype)sharedInstance;

- (WeekDay)currentDay;

@end
