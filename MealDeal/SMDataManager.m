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
    NSEntityDescription *entityDescription =  [NSEntityDescription
                                                        entityForName:@"Meal"
                                               inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(error) {
        NSLog(@"Error fetching");
    } else {
        NSLog(@"No error");
    }
    
    return results;
    
}

- (BOOL)addMeal:(NSString *)meal
          price:(NSString *)price
         vendor:(NSString *)vendor
        weekDay:(WeekDay)weekDay {
    
    Meal *newMeal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:self.managedObjectContext];
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

@end
