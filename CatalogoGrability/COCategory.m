//
//  COCategory.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "COCategory.h"
#import "COSubcategory.h"

@implementation COCategory

+(instancetype)COCategoryWithName:(NSString *)name
                             icon:(NSData *)icon
                          context:(NSManagedObjectContext *)context{
    
    COCategory *categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
    
    categoria.name = name;
    categoria.icon = icon; //UIImagePNGRepresentation(icon);
    
    return categoria;
    
}

+(NSArray *)AllCategories:(NSManagedObjectContext *)context{
    
    NSMutableArray *categories = [ NSMutableArray array];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Category" inManagedObjectContext:context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        for (int i=0; i < [array count]; i++) {
            COCategory *categoria = [array objectAtIndex:i];
            
            [categories addObject:categoria];
        }
        return categories;
    }
    
    return nil;
    
}

+(instancetype)categoriaAlreadyExists:(NSString *)nameCategoria
                                 context:(NSManagedObjectContext*)context{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Category"];
    
    NSPredicate *predicate;
    
    predicate = [NSPredicate predicateWithFormat:@"name == %@ ", nameCategoria];
    
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [context  executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        COCategory *categoria = [array objectAtIndex:0];
        return categoria;
    }
    
    return nil;
}

@end
