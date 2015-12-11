//
//  COElement.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 7/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "COElement.h"
#import "COSubcategory.h"

@implementation COElement

+(instancetype)COElementWithName:(NSString *)name
                         summary:(NSString *)summary
                            icon:(NSData *)icon
                     subcategory:(COSubcategory *)subcategory
                         context:(NSManagedObjectContext *)context{
    
    COElement *elemento = [NSEntityDescription insertNewObjectForEntityForName:@"Element" inManagedObjectContext:context];
    
    elemento.name = name;
    elemento.icon = icon;
    elemento.summary = summary;
    elemento.subcategory = subcategory;
    
    return elemento;
}


+(BOOL)elementAlreadyExists:(NSString *)nameElement
                    context:(NSManagedObjectContext*)context{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Element"];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"name == %@ ", nameElement];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [context  executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        return YES;
    }
    
    return NO;
    
}

+(NSArray *)elementForSubcategories:(NSString *)nameSubcategory
                            context:(NSManagedObjectContext *)context{
    
    NSMutableArray *elements = [ NSMutableArray array];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Subcategory" inManagedObjectContext:context]];
    
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"name == %@ ", nameSubcategory];
    [request setPredicate:predicate];
    
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if ([array count] > 0)
    {
        for (int i=0; i < [array count]; i++) {
            COSubcategory *subcategoria = [array objectAtIndex:i];
            
            for (id object in subcategoria.elements) {
                COElement *element = object;
                [elements addObject:element];
            }
            
            
        }
        return elements;
    }
    
    return nil;
    
}

@end
