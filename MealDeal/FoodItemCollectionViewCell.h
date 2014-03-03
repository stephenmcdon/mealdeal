//
//  FoodItemCollectionViewCell.h
//  MealDeal
//
//  Created by Stephen McDonald on 1/31/2014.
//  Copyright (c) 2014 Stephen McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodItemCollectionViewCell;

@protocol FoodItemCollectionViewCellDelegate <NSObject>

@required
- (void)deleteButtonPressedForCell:(FoodItemCollectionViewCell *)cell;

@end

@interface FoodItemCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) id<FoodItemCollectionViewCellDelegate> delegate;

- (void)setupCellWithVendor:(NSString *)vendor menuItem:(NSString *)menuItem price:(NSString *)price;

- (void)showDeleteButton;
- (void)hideDeleteButton;

@end