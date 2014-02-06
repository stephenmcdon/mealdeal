//
//  SMViewController.m
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "SMViewController.h"
#import "FoodItemCollectionViewCell.h"

@interface SMViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak,nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *daySegmentedControl;

@property (nonatomic,assign) NSInteger currentDay;

@end

typedef enum {
    WeekDays_Monday = 0,
    WeekDays_Tuesday,
    WeekDays_Wednesday,
    WeekDays_Thursday,
    WeekDays_Friday
}WeekDays;

@implementation SMViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCurrentDay];
    [self setupDaySegmentControl];
	[self registerNibForCollectionViewCell];
}

#pragma mark - SegmentedControl

- (void)daySegmentedControlValueChanged {
    self.currentDay = self.daySegmentedControl.selectedSegmentIndex;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5 + self.currentDay;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FoodItemCollectionViewCell class]) forIndexPath:indexPath];
    [cell setupCellWithVendor:@"Test" menuItem:@"Me" price:@"$99.99"];
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

@end
