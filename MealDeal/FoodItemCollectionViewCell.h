//
//  FoodItemCollectionViewCell.h
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodItemCollectionViewCell : UICollectionViewCell

- (void)setupCellWithVendor:(NSString *)vendor menuItem:(NSString *)menuItem price:(NSString *)price;

@end
