//
//  SMDataManager.m
//  MealDeal
//
//  Created by Stephen McDonald on 2/24/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "SMDataManager.h"
#import "Meal.h"
#import <CoreData/CoreData.h>

static SMDataManager *instance;

@interface SMDataManager ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation SMDataManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SMDataManager new];
        instance.managedObjectContext = [[(id)[UIApplication sharedApplication] delegate] managedObjectContext];
    });
    return instance;
}

#pragma mark - Meals

- (NSArray *)allMeals {
    NSFetchRequest *request = [self fetchRequestForEntityName:@"Meal"];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    return results;
}

- (NSArray *)allMealsForWeekDay:(WeekDay)weekDay {
    NSFetchRequest *request = [self fetchRequestForEntityName:@"Meal"];
    
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"day == %d", weekDay];
    [request setPredicate:dayPredicate];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    return results;
}

- (BOOL)addMeal:(NSString *)meal
          price:(NSString *)price
         vendor:(NSString *)vendor
        weekDay:(WeekDay)weekDay {
    
    Meal *newMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal"
                                                  inManagedObjectContext:self.managedObjectContext];
    newMeal.meal = meal;
    newMeal.price = price;
    newMeal.vendor = vendor;
    newMeal.day = [[NSNumber alloc] initWithInt:weekDay];
    
    BOOL successfullyAdded = NO;
    NSError *error;
    
    [newMeal.managedObjectContext save:&error];
    
    if(!error) {
        successfullyAdded = YES;
    }
    
    return successfullyAdded;
}

#pragma mark - Helpers

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
                                                         inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    return fetchRequest;
}

@end
