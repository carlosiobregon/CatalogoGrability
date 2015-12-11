//
//  LoadModels.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "LoadModels.h"
#import "AppDelegate.h"
#import "COCategory.h"
#import "COSubcategory.h"
#import "COElement.h"

@interface LoadModels()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation LoadModels

-(id) init{
    if (self = [super init]) {
        [self assignContext];
    }
    return self;
}

-(void)assignContext{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _context = appDelegate.context;
}

-(NSArray *)loadCategories{
    
    NSArray *categories = [COCategory AllCategories:self.context];
    
    return categories;
}

-(NSArray *)loadSubcategories:(NSString *)nameCategory{
    
    NSArray *subcategories = [COSubcategory subcategoriesForCategory:nameCategory context:self.context];
    
    return subcategories;
    
}

-(NSArray *)loadElements:(NSString *)nameSubcategory{
    
    NSArray *elements = [COElement elementForSubcategories:nameSubcategory context:self.context];
    
    return elements;
    
}

@end
