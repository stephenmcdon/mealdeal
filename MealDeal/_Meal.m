// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Meal.m instead.

#import "_Meal.h"

const struct MealAttributes MealAttributes = {
	.day = @"day",
	.meal = @"meal",
	.price = @"price",
	.vendor = @"vendor",
};

const struct MealRelationships MealRelationships = {
};

const struct MealFetchedProperties MealFetchedProperties = {
};

@implementation MealID
@end

@implementation _Meal

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Meal";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Meal" inManagedObjectContext:moc_];
}

- (MealID*)objectID {
	return (MealID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"dayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"day"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic day;



- (int16_t)dayValue {
	NSNumber *result = [self day];
	return [result shortValue];
}

- (void)setDayValue:(int16_t)value_ {
	[self setDay:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDayValue {
	NSNumber *result = [self primitiveDay];
	return [result shortValue];
}

- (void)setPrimitiveDayValue:(int16_t)value_ {
	[self setPrimitiveDay:[NSNumber numberWithShort:value_]];
}





@dynamic meal;






@dynamic price;






@dynamic vendor;











@end
