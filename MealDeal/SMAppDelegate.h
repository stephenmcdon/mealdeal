//
//  SMAppDelegate.h
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end
