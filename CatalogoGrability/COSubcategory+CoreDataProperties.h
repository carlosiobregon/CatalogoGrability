//
//  COSubcategory+CoreDataProperties.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "COSubcategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface COSubcategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) COCategory *category;
@property (nullable, nonatomic, retain) NSSet<COElement *> *elements;

@end

@interface COSubcategory (CoreDataGeneratedAccessors)

- (void)addElementsObject:(COElement *)value;
- (void)removeElementsObject:(COElement *)value;
- (void)addElements:(NSSet<COElement *> *)values;
- (void)removeElements:(NSSet<COElement *> *)values;

@end

NS_ASSUME_NONNULL_END
