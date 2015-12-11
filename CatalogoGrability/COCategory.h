//
//  COCategory.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;

@class COSubcategory;

NS_ASSUME_NONNULL_BEGIN

@interface COCategory : NSManagedObject

+(instancetype)COCategoryWithName:(NSString *)name
                             icon:(NSData *)icon
                          context:(NSManagedObjectContext *)context;

+(instancetype)categoriaAlreadyExists:(NSString *)nameCategoria
                              context:(NSManagedObjectContext*)context;

+(NSArray *)AllCategories:(NSManagedObjectContext *)context;



@end

NS_ASSUME_NONNULL_END

#import "COCategory+CoreDataProperties.h"
