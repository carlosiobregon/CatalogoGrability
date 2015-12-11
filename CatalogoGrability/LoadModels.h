//
//  LoadModels.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//


@class COCategory, COSubcategory;
@interface LoadModels : NSObject

-(NSArray *)loadCategories;
-(NSArray *)loadSubcategories:(NSString *)nameCategory;
-(NSArray *)loadElements:(NSString *)nameSubcategory;

@end
