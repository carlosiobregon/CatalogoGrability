//
//  AppDelegate.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 26/11/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTColors.h"
#import "MainIpadVC.h"
#import "MainIphoneVC.h"
#import "COCoreDataStack.h"
#import "CustomNavigationController.h"

@interface AppDelegate()
@property (nonatomic, strong) COCoreDataStack *cdStore;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.cdStore = [[COCoreDataStack alloc] init];
    self.context = self.cdStore.managedObjectContext;
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window.backgroundColor = [UIColor whiteColor];

    
    CustomNavigationController *navCustomController;
    
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([[device model] isEqualToString:DEVICE_IPAD]) {
        MainIpadVC *mainCVC = [[MainIpadVC alloc] initWithModel:[AGTColors new] layout:[UICollectionViewFlowLayout new]];
        navCustomController = [[CustomNavigationController alloc] initWithRootViewController:mainCVC];
    }
    else if([[device model] isEqualToString:DEVICE_IPHONE])
    {
        MainIphoneVC *mainTVC = [[MainIphoneVC alloc] initWithStyle:UITableViewStylePlain];
        navCustomController = [[CustomNavigationController alloc] initWithRootViewController:mainTVC];
    }
    
    
    self.window.rootViewController =  navCustomController;
    [self.window makeKeyAndVisible];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    [self.cdStore saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.cdStore saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}



@end
