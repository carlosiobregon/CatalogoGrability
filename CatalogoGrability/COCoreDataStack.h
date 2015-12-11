//
//  WMBCoreDataStack.h
//  WM POAMM
//
//  Created by Carlos Obregon on 22/01/15.
//  Copyright (c) 2015 WM Wireless & mobile. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface COCoreDataStack : NSObject

// Properties
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Methods
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
