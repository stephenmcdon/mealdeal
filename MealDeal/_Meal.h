// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Meal.h instead.

#import <CoreData/CoreData.h>


extern const struct MealAttributes {
	__unsafe_unretained NSString *day;
	__unsafe_unretained NSString *meal;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *vendor;
} MealAttributes;

extern const struct MealRelationships {
} MealRelationships;

extern const struct MealFetchedProperties {
} MealFetchedProperties;







@interface MealID : NSManagedObjectID {}
@end

@interface _Meal : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MealID*)objectID;





@property (nonatomic, strong) NSNumber* day;



@property int16_t dayValue;
- (int16_t)dayValue;
- (void)setDayValue:(int16_t)value_;

//- (BOOL)validateDay:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* meal;



//- (BOOL)validateMeal:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* price;



//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* vendor;



//- (BOOL)validateVendor:(id*)value_ error:(NSError**)error_;






@end

@interface _Meal (CoreDataGeneratedAccessors)

@end

@interface _Meal (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDay;
- (void)setPrimitiveDay:(NSNumber*)value;

- (int16_t)primitiveDayValue;
- (void)setPrimitiveDayValue:(int16_t)value_;




- (NSString*)primitiveMeal;
- (void)setPrimitiveMeal:(NSString*)value;




- (NSString*)primitivePrice;
- (void)setPrimitivePrice:(NSString*)value;




- (NSString*)primitiveVendor;
- (void)setPrimitiveVendor:(NSString*)value;




@end
