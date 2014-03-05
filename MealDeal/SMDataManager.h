//
//  SMDataManager.h
//  MealDeal
//
//  Created by Stephen McDonald on 2/24/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMDataManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)allMeals;

- (NSArray *)allMealsForWeekDay:(WeekDay)weekDay;

- (NSArray *)allMealsForWeekDay:(WeekDay)weekDay containingMealText:(NSString *)text;

- (BOOL)deleteMeal:(NSString *) meal
             price:(NSString *)price
            vendor:(NSString *)vendor
           weekDay:(WeekDay)weekDay;

- (BOOL)addMeal:(NSString *)meal
          price:(NSString *)price
         vendor:(NSString *)vendor
        weekDay:(WeekDay)weekDay;

@end
