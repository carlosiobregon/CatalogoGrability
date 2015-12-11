//
//  COSubcategory.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "COSubcategory.h"
#import "COCategory.h"
#import "COElement.h"

@implementation COSubcategory

+(instancetype)COSubcategoryWithName:(NSString *)name
                            category:(COCategory *)category
                             context:(NSManagedObjectContext *)context{
    
    COSubcategory *subcategoria = [NSEntityDescription insertNewObjectForEntityForName:@"Subcategory"
                                                                inManagedObjectContext:context];
    
    subcategoria.name = name;
    subcategoria.category = category;
    
    return subcategoria;
    
}

+(instancetype)subcategoriaAlreadyExists:(NSString *)nameSubCategoria
                                 context:(NSManagedObjectContext*)context{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Subcategory"];
    
    NSPredicate *predicate;
    
    predicate = [NSPredicate predicateWithFormat:@"name == %@ ", nameSubCategoria];
    
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [context  executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        COSubcategory *subcategoria = [array objectAtIndex:0];
        return subcategoria;
    }
    
    return nil;
}

+(NSArray *)subcategoriesForCategory:(NSString *)nameCategory
                             context:(NSManagedObjectContext *)context{
    
    NSMutableArray *subcategorias = [ NSMutableArray array];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Category" inManagedObjectContext:context]];
    
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"name == %@ ", nameCategory];
    [request setPredicate:predicate];

    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        for (int i=0; i < [array count]; i++) {
            COCategory *categoria = [array objectAtIndex:i];
            
            for (id object in categoria.subcategories) {
                COSubcategory *subcategoria = object;
                [subcategorias addObject:subcategoria];
            }
            
            
        }
        return subcategorias;
    }
    
    return nil;
    
}

@end
