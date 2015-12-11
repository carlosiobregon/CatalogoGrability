//
//  MainIpad.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//


@class AGTColors;
@interface MainIpadCVC : UICollectionViewController


@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

-(id) initWithModel:(AGTColors *) colors
             layout:(UICollectionViewLayout *) layout;
-(void)loadModel;

@end