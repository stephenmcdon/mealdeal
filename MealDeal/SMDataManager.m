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

- (NSArray *)allMealsForWeekDay:(WeekDay)weekDay containingMealText:(NSString *)text {
    NSFetchRequest *request = [self fetchRequestForEntityName:@"Meal"];
    
    NSPredicate *dayAndTextPredicate = [NSPredicate predicateWithFormat:@"day == %d AND meal CONTAINS[cd] %@",weekDay,text];
    [request setPredicate:dayAndTextPredicate];
    
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
    
    BOOL isSuccessfullyAdded = NO;
    NSError *error;
    
    [newMeal.managedObjectContext save:&error];
    
    if(!error) {
        isSuccessfullyAdded = YES;
    }
    
    return isSuccessfullyAdded;
}

- (BOOL)deleteMeal:(NSString *) meal
             price:(NSString *)price
            vendor:(NSString *)vendor
           weekDay:(WeekDay)weekDay {
    
    BOOL isSuccessfullyDeleted = NO;
    NSError *error;
    
    NSManagedObject *managedObject = [self managedObjectForMeal:meal price:price vendor:vendor weekDay:weekDay];
    if(managedObject) {
        
        [self.managedObjectContext deleteObject:managedObject];
        [self.managedObjectContext save:&error];
        
        if(!error) {
            isSuccessfullyDeleted = YES;
        }
        
    }
    
    return isSuccessfullyDeleted;
}

#pragma mark - Helpers

- (NSFetchRequest *)fetchRequestForEntityName:(NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName
                                                         inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    return fetchRequest;
}

- (NSManagedObject *)managedObjectForMeal:(NSString *)meal
                                    price:(NSString *)price
                                   vendor:(NSString *)vendor
                                  weekDay:(WeekDay)weekDay{
    
    NSFetchRequest *request = [self fetchRequestForEntityName:@"Meal"];
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"meal == %@ AND price == %@ AND vendor == %@ AND day == %d", meal, price, vendor, weekDay];
    [request setPredicate:dayPredicate];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    NSManagedObject *managedObject = nil;
    
    if(results && results.count > 0) {
        managedObject = results[0];
    }
    return managedObject;
}

@end
