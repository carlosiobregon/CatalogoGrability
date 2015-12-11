//
//  COElement.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import UIKit;;

@class COSubcategory;

NS_ASSUME_NONNULL_BEGIN

@interface COElement : NSManagedObject

+(instancetype)COElementWithName:(NSString *)name
                         summary:(NSString *)summary
                            icon:(NSData *)icon
                     subcategory:(COSubcategory *)subcategory
                         context:(NSManagedObjectContext *)context;

+(BOOL)elementAlreadyExists:(NSString *)nameElement
                            context:(NSManagedObjectContext*)context;

+(NSArray *)elementForSubcategories:(NSString *)nameSubcategory
                            context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "COElement+CoreDataProperties.h"
