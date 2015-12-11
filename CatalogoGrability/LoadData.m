//
//  DownloadJSON.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//


#import "LoadData.h"
#import "MainIpadCVC.h"
#import "MainIphoneVC.h"

#import "Reachability.h"
#import "AppDelegate.h"
#import "LoadModels.h"

#import "COCategory.h"
#import "COSubcategory.h"
#import "COElement.h"

#import "Utilities.h"

#define KEY_CATEGORIA @"feed"
#define KEY_ELEMENTS @"entry"


@interface LoadData()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) MainIpadCVC *cvc;
@property (nonatomic, strong) MainIphoneVC *tvc;
@property (nonatomic, strong) NSString *operation;
@end

@implementation LoadData


#pragma mark - Init
-(id) initWithTableViewController:(MainIphoneVC *)tvc{
    if (self = [super init]) {
        _tvc = tvc;
        _operation = @"updateTVC:";
        [self assignContext];
    }
    return self;
}
-(id) initWithCollectionViewController:(MainIpadCVC *)cvc{
    if (self = [super init]) {
        _cvc = cvc;
        _operation = @"updateCVC";
        [self assignContext];
    }
    return self;
}
-(void)assignContext{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = appDelegate.context;
}

#pragma mark - Operation: Download & Save data
-(void)main{
    
    
    //Comprobar conexión
    Reachability *accesible = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [accesible currentReachabilityStatus];
    if (remoteHostStatus == NotReachable) {
        [Utilities showAlertWithTitle:@"Alerta" andMessage:@"Sin conexión a internet"];
        
    } else {
        
        //Descarga JSON
        NSData * responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:JSON_SERVICES]];
        
        
        //Convierte JSON a NSDictionary
        NSError * error;
        NSDictionary * dicJson = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

        
        //Save data in model
        [self saveData:dicJson];
        
        
    }
    
    //Enviar respuesta al hilo principal
    if ([self.operation isEqualToString:@"updateCVC"]) {
        [self performSelectorOnMainThread:@selector(updateCVCWithData) withObject:nil waitUntilDone:YES];
    }
    else{
        [self performSelectorOnMainThread:@selector(updateTVCWithData) withObject:nil waitUntilDone:YES];
    }
    
    
    
}

#pragma mark - Response class delegate
-(void)updateCVCWithData{
    [self.cvc loadModel];
}
-(void)updateTVCWithData{
    [self.tvc loadModel];
}

#pragma mark - Save data in model
-(void)saveData:(NSDictionary *)dicData{
    
    __block NSArray *elements;
    
    
    [dicData enumerateKeysAndObjectsUsingBlock: ^(id key, id category, BOOL *stop) {
        
        category = [dicData objectForKey:key];
        NSString *title = [[category objectForKey:@"title"] objectForKey:@"label"];
        NSString *urlIcon = [[category objectForKey:@"icon"] objectForKey:@"label"];
        
        
        //Comprobar si la categoria existe, si existe que la asigne//
        COCategory *categoria = [COCategory categoriaAlreadyExists:title context:self.context];
        if (categoria == nil) {
            categoria = [self saveCategories:title icon:urlIcon];
        }
        
        
        //Filtrar Elementos
        elements = [category objectForKey:KEY_ELEMENTS];
        
        //Recorrer elementos y categorias
        [elements enumerateObjectsUsingBlock: ^(id element, NSUInteger indice, BOOL *stop) {
            
            element = [elements objectAtIndex:indice];
            
            //Consultar subcategoria
            NSString *nameSubCat= [[[element objectForKey:@"category"] objectForKey:@"attributes"] objectForKey:@"term"];
            
            //Comprobar que esta categoria exista, si existe que la asigne
            COSubcategory *subcategoria = [COSubcategory subcategoriaAlreadyExists:nameSubCat context:self.context];
            if (subcategoria == nil) {
                subcategoria = [self saveSubcategories:nameSubCat category:categoria];
            }
            
            NSString *nameElement = [[element objectForKey:@"im:name"] objectForKey:@"label"];
            NSString *urlIcon = [[[element objectForKey:@"im:image"] objectAtIndex:0] objectForKey:@"label"];
            NSString *summary = [[element objectForKey:@"summary"] objectForKey:@"label"];
            
            [self saveElements:nameElement summary:summary urlIcon:urlIcon subcategory:subcategoria];
        }];
    }];
    
    
}

//Save entities in model
-(void)saveElements:(NSString *)nameElement
            summary:(NSString *)summary
            urlIcon:(NSString *)urlIcon
        subcategory:(COSubcategory *)subcategory{

    NSData *icon = [self downloadImage:urlIcon];
    [COElement COElementWithName:nameElement
                         summary:summary
                            icon:icon
                     subcategory:subcategory
                         context:self.context];
}

-(COSubcategory *)saveSubcategories:(NSString *)name
                         category:(COCategory *)category{
    
    COSubcategory *subcategoria = [COSubcategory COSubcategoryWithName:name
                                                              category:category
                                                               context:self.context];
    
    return subcategoria;
}

-(COCategory *)saveCategories:(NSString *)name
                         icon:(NSString *)urlIcon{
    
    NSData *icon = [self downloadImage:urlIcon];
    COCategory *category = [COCategory COCategoryWithName:name
                                                     icon:icon context:self.context];
    
    return category;
}


//Download Icons
-(NSData *)downloadImage:(NSString *)urlImage{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlImage]];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (data != nil) {
        return data;
    }
    
    return nil;
}

@end
