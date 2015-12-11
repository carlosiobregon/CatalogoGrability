//
//  COElement+CoreDataProperties.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "COElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface COElement (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *icon;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) COSubcategory *subcategory;

@end

NS_ASSUME_NONNULL_END
