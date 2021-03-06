//
//  FoodItemCollectionViewCell.m
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "FoodItemCollectionViewCell.h"

#define kOriginalMenuItemLabelWidth 240

@interface FoodItemCollectionViewCell ()

@property (strong,nonatomic) IBOutlet UILabel *vendorLabel;
@property (strong,nonatomic) IBOutlet UILabel *menuItemLabel;
@property (strong,nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menuItemLabelWidthLayoutConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *vendorLabelWidthLayoutConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteButtonWidthLayoutConstraint;

@end

@implementation FoodItemCollectionViewCell

- (void)setupCellWithVendor:(NSString *)vendor menuItem:(NSString *)menuItem price:(NSString *)price {
    self.vendorLabel.text = vendor;
    self.menuItemLabel.text = menuItem;
    self.priceLabel.text = price;
    [self resetWidthLayoutConstraints];
}

- (void)resetWidthLayoutConstraints {
    self.menuItemLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth;
    self.vendorLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth;
}

- (void)showDeleteButton {
    [self adjustMenuAndVendorLabelWidthToShowDeleteButton];
}

- (void)adjustMenuAndVendorLabelWidthToShowDeleteButton {
    [UIView animateWithDuration:0.4f animations:^ {
        self.menuItemLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth - self.deleteButtonWidthLayoutConstraint.constant;
        self.vendorLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth - self.deleteButtonWidthLayoutConstraint.constant;
        [self layoutIfNeeded];
    }];
}

- (void)hideDeleteButton {
    [UIView animateWithDuration:0.4f animations:^{
        self.menuItemLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth;
        self.vendorLabelWidthLayoutConstraint.constant = kOriginalMenuItemLabelWidth;
        [self layoutIfNeeded];
    }];
}

- (IBAction)deleteButtonPressed:(id)sender {
    [self.delegate deleteButtonPressedForCell:self];
}

@end