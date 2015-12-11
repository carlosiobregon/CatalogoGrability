//
//  DownloadJSON.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MainIphoneVC;
@class MainIpadCVC;
@interface LoadData : NSOperation

-(id) initWithTableViewController:(MainIphoneVC *)tvc;
-(id) initWithCollectionViewController:(MainIpadCVC *)cvc;

@end
