//
//  FoodItemCollectionViewCell.m
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import "FoodItemCollectionViewCell.h"

@interface FoodItemCollectionViewCell ()

@property (strong,nonatomic) IBOutlet UILabel *vendorLabel;
@property (strong,nonatomic) IBOutlet UILabel *menuItemLabel;
@property (strong,nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation FoodItemCollectionViewCell

- (void)setupCellWithVendor:(NSString *)vendor menuItem:(NSString *)menuItem price:(NSString *)price {
    _vendorLabel.text = vendor;
    _menuItemLabel.text = menuItem;
    _priceLabel.text = price;
}


@end
