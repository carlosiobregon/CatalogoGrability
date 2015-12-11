//
//  MainIpad.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

@import UIKit;
@class AGTColors;

@interface MainIpadVC : UICollectionViewController

@property (nonatomic, strong) NSDictionary *dicJSON;

-(id) initWithModel:(AGTColors *) colors
             layout:(UICollectionViewLayout *) layout;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
-(void)loadModel;

@end
