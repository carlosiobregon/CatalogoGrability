//
//  COSubcategory.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class COCategory, COElement;

NS_ASSUME_NONNULL_BEGIN

@interface COSubcategory : NSManagedObject

+(instancetype)COSubcategoryWithName:(NSString *)name
                            category:(COCategory *)category
                             context:(NSManagedObjectContext *)context;

+(instancetype)subcategoriaAlreadyExists:(NSString *)nameSubCategoria
                    context:(NSManagedObjectContext*)context;

+(NSArray *)subcategoriesForCategory:(NSString *)nameCategory
                             context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "COSubcategory+CoreDataProperties.h"
