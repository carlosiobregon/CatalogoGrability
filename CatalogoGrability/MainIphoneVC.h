//
//  MainIphone.h
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.


@interface MainIphoneVC : UITableViewController

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
-(void)syncModel;

@end
