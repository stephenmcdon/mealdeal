//
//  SMAddItemViewController.m
//  MealDeal
//
//  Created by Stephen McDonald on 2/9/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "Meal.h"
#import "SMAddItemViewController.h"
#import "SMDataManager.h"
#import "SMDateUtil.h"

@interface SMAddItemViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mealTextField;
@property (strong, nonatomic) IBOutlet UITextField *vendorTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *daySegmentedControl;

@end

@implementation SMAddItemViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.addButton setEnabled:NO];
    [self setupTextFieldDelegates];
    [self.daySegmentedControl setSelectedSegmentIndex:[[SMDateUtil sharedInstance] currentDay]];
}

#pragma mark - View Lifecycle Helpers

- (void)setupTextFieldDelegates {
    self.mealTextField.delegate = self;
    self.priceTextField.delegate = self;
    self.vendorTextField.delegate = self;
}

- (void)resignAllFirstResponders {
    [self.priceTextField resignFirstResponder];
    [self.mealTextField resignFirstResponder];
    [self.vendorTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([self isAllTextFieldsPopulated]) {
        [self.addButton setEnabled:YES];
    } else {
        [self.addButton setEnabled:NO];
    }
    return YES;
}

- (BOOL)isAllTextFieldsPopulated {
    return self.mealTextField.text.length > 0 && self.vendorTextField.text.length > 0 && self.priceTextField.text.length > 0;
}

#pragma mark - IBActions

- (IBAction)cancelButtonTapped:(id)sender {
    [self resignAllFirstResponders];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonTapped:(id)sender {
    [self resignAllFirstResponders];
    [self addMeal];
}

- (IBAction)handleTapGesture:(id)sender {
    [self resignAllFirstResponders];
}


#pragma mark - Core Data
- (void)addMeal {
    BOOL successful = [[SMDataManager sharedInstance] addMeal:self.mealTextField.text
                                                        price:self.priceTextField.text
                                                       vendor:self.vendorTextField.text
                                                      weekDay:self.daySegmentedControl.selectedSegmentIndex];
    if(successful) {
        [self resignAllFirstResponders];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
