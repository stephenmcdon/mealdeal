//
//  SMViewController.m
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "FoodItemCollectionViewCell.h"
#import "Meal.h"
#import "SMDataManager.h"
#import "SMDateUtil.h"
#import "SMViewController.h"

#define kNoRowShowingDeleteButton -1

@interface SMViewController () <UICollectionViewDataSource, UICollectionViewDelegate, FoodItemCollectionViewCellDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *daySegmentedControl;
@property (strong, nonatomic) IBOutlet UISearchBar *mealSearchBar;

@property (nonatomic, assign) WeekDay currentDay;
@property (strong, nonatomic) NSArray *dealsArray;
@property (nonatomic, assign) NSInteger currentRowShowingDeleteButton;

@end

@implementation SMViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCurrentDay];
    [self setupDaySegmentControl];
	[self registerNibForCollectionViewCell];
    self.currentRowShowingDeleteButton = kNoRowShowingDeleteButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self retrieveMealsForCurrentDay];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - NIBs

- (void)registerNibForCollectionViewCell {
    UINib *nib = [UINib nibWithNibName:@"FoodItemCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([FoodItemCollectionViewCell class])];
}

#pragma mark - View Lifecycle Helpers

- (void)setupDaySegmentControl {
    [self.daySegmentedControl addTarget:self action:@selector(daySegmentedControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.daySegmentedControl setSelectedSegmentIndex:self.currentDay];
}

- (void)setupCurrentDay {
    self.currentDay = [[SMDateUtil sharedInstance] currentDay];
}

#pragma mark - SegmentedControl

- (void)daySegmentedControlValueChanged {
    self.currentDay = self.daySegmentedControl.selectedSegmentIndex;
    self.mealSearchBar.text = @"";
    [self.mealSearchBar resignFirstResponder];
    [self retrieveMealsForCurrentDay];
}

#pragma mark - UICollectionView methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.dealsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FoodItemCollectionViewCell class]) forIndexPath:indexPath];
    Meal *meal = [self.dealsArray objectAtIndex:indexPath.row];
    [cell setupCellWithVendor:meal.vendor menuItem:meal.meal price:meal.price];
    cell.delegate = self;
    [self addSwipeGestureRecognizerToCell:cell];
    return cell;
}

- (void)addSwipeGestureRecognizerToCell:(UICollectionViewCell *)cell {
    
    UISwipeGestureRecognizer *leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [leftGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:leftGestureRecognizer];
    
    UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [rightGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:rightGestureRecognizer];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentRowShowingDeleteButton != indexPath.row) {
        [self hideCurrentRowShowingDeleteButton];
    }
    [self.mealSearchBar resignFirstResponder];
}

#pragma mark - UIScrollView methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideCurrentRowShowingDeleteButton];
    [self.mealSearchBar resignFirstResponder];
}

#pragma mark - Data Retrieval

- (void)retrieveMealsForCurrentDay {
    self.dealsArray = [[SMDataManager sharedInstance] allMealsForWeekDay:self.currentDay];
    [self.collectionView reloadData];
}

- (void)updateMealsWithText:(NSString *)searchText {
    self.dealsArray = [[SMDataManager sharedInstance] allMealsForWeekDay:self.currentDay containingMealText:searchText];
    [self.collectionView reloadData];
}

#pragma mark - Cell Swipe Gestures

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)sender {
    FoodItemCollectionViewCell *cell = (FoodItemCollectionViewCell *)sender.view;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if(indexPath.row != self.currentRowShowingDeleteButton) {
        [self hideCurrentRowShowingDeleteButton];
    }
    [self showDeleteButtonForCell:cell];
    [self.mealSearchBar resignFirstResponder];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)sender {
    FoodItemCollectionViewCell *cell = (FoodItemCollectionViewCell *)sender.view;
    [self hideDeleteButtonForCell:cell];
    [self.mealSearchBar resignFirstResponder];
}

#pragma mark - Cell showing/hiding Delete Button

- (void)showDeleteButtonForCell:(FoodItemCollectionViewCell *)cell {
    [self setCellAsCurrentShowingDelete:cell];
    [cell showDeleteButton];
}

- (void)setCellAsCurrentShowingDelete:(FoodItemCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    self.currentRowShowingDeleteButton = indexPath.row;
}

- (void)hideCurrentRowShowingDeleteButton {
    if (self.currentRowShowingDeleteButton >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentRowShowingDeleteButton inSection:0];
        FoodItemCollectionViewCell *cell =(FoodItemCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [self hideDeleteButtonForCell:cell];
    }
}

- (void)hideDeleteButtonForCell:(FoodItemCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if(self.currentRowShowingDeleteButton == indexPath.row) {
        self.currentRowShowingDeleteButton = kNoRowShowingDeleteButton;
    }
    [cell hideDeleteButton];
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length > 0) {
        [self updateMealsWithText:searchText];
    } else {
        [self retrieveMealsForCurrentDay];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self hideCurrentRowShowingDeleteButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Called.");
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.mealSearchBar isFirstResponder] && [touch view] != self.mealSearchBar)
    {
        [self.mealSearchBar resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - FoodItemCollectionViewCellDelegate methods

- (void)deleteButtonPressedForCell:(FoodItemCollectionViewCell *)cell {
    NSIndexPath *indexPathForCell = [self.collectionView indexPathForCell:cell];
    Meal *meal = [self.dealsArray objectAtIndex:indexPathForCell.row];
    BOOL isSuccessfullyDeleted = [[SMDataManager sharedInstance] deleteMeal:meal.meal
                                                     price:meal.price
                                                    vendor:meal.vendor
                                                   weekDay:[meal.day integerValue]];
    if(isSuccessfullyDeleted) {
        self.mealSearchBar.text = @"";
        [self retrieveMealsForCurrentDay];
    }
}

@end
