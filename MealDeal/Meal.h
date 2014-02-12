//
//  Meal.h
//  MealDeal
//
//  Created by Stephen McDonald on 2/11/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Meal : NSManagedObject

@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * vendor;
@property (nonatomic, retain) NSString * meal;
@property (nonatomic, retain) NSNumber * day;

@end
