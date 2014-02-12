//
//  SMViewController.m
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "SMViewController.h"
#import "FoodItemCollectionViewCell.h"
#import "Meal.h"

#import <CoreData/CoreData.h>

@interface SMViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *daySegmentedControl;

@property (nonatomic,assign) NSInteger currentDay;
@property (strong, nonatomic) NSArray *dealsArray;

@end

@implementation SMViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCurrentDay];
    [self setupDaySegmentControl];
	[self registerNibForCollectionViewCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self retrieveMealsForCurrentDay];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - SegmentedControl

- (void)daySegmentedControlValueChanged {
    self.currentDay = self.daySegmentedControl.selectedSegmentIndex;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dealsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FoodItemCollectionViewCell class]) forIndexPath:indexPath];
    Meal *meal = [self.dealsArray objectAtIndex:indexPath.row];
    [cell setupCellWithVendor:meal.vendor menuItem:meal.meal price:meal.price];
    return cell;
}

#pragma mark - NIBs
- (void)registerNibForCollectionViewCell {
    UINib *nib = [UINib nibWithNibName:@"FoodItemCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([FoodItemCollectionViewCell class])];
    
}

#pragma mark - Additional View Setup
- (void)setupDaySegmentControl {
    [self.daySegmentedControl addTarget:self action:@selector(daySegmentedControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.daySegmentedControl setSelectedSegmentIndex:self.currentDay];
}

- (void)setupCurrentDay {
    NSDate *today = [NSDate date];
    NSDateFormatter *todayNumberDateFormatter = [[NSDateFormatter alloc] init];
    [todayNumberDateFormatter setDateFormat:@"c"];
    NSString *todayString = [todayNumberDateFormatter stringFromDate:today];
    NSInteger todayInt = [self adjustTodayIntToMondayIfNeeded:[todayString integerValue]];
    self.currentDay = todayInt;
}

- (NSInteger)adjustTodayIntToMondayIfNeeded:(NSInteger)todayInt {
    
    todayInt -= 2;  //offset so Monday now = 0
    
    if(todayInt < WeekDays_Monday || todayInt > WeekDays_Friday) {
        todayInt = WeekDays_Monday;
    }
    return todayInt;
}

#pragma mark - Core Data Calls

- (void)retrieveMealsForCurrentDay {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entityDescription =  [NSEntityDescription
                                               entityForName:@"Meal"
                                               inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    
    self.dealsArray = [managedObjectContext executeFetchRequest:request error:&error];
    
    if(error) {
        NSLog(@"Error fetching");
    } else {
        NSLog(@"No error");
    }
    [self.collectionView reloadData];
}

- (NSManagedObjectContext *)managedObjectContext {
    return [[(id)[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
