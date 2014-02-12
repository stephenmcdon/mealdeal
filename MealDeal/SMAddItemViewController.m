//
//  SMAddItemViewController.m
//  MealDeal
//
//  Created by Stephen McDonald on 2/9/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "SMAddItemViewController.h"
#import "Meal.h"

@interface SMAddItemViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mealTextField;
@property (strong, nonatomic) IBOutlet UITextField *vendorTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation SMAddItemViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.addButton setEnabled:NO];
    [self setupTextFieldDelegates];
}

#pragma mark - View Lifecycle Helpers

- (void)setupTextFieldDelegates {
    self.mealTextField.delegate = self;
    self.priceTextField.delegate = self;
    self.vendorTextField.delegate = self;
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
    [self createNewManagedObject];
}

- (void)resignAllFirstResponders {
    [self.priceTextField resignFirstResponder];
    [self.mealTextField resignFirstResponder];
    [self.vendorTextField resignFirstResponder];
}

#pragma mark - Tap Gesture
- (IBAction)handleTapGesture:(id)sender {
    [self resignAllFirstResponders];
}

#pragma mark - Core Data
- (void)createNewManagedObject {
    Meal *meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:[self managedObjectContext]];
    meal.price = self.priceTextField.text;
    meal.meal = self.mealTextField.text;
    meal.vendor = self.vendorTextField.text;
    meal.day = WeekDays_Monday;
    NSError *error;
    [meal.managedObjectContext save:&error];
    if(!error) {
        [self resignAllFirstResponders];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    return [[(id)[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
