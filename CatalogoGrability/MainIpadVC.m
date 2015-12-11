//
//  MainIpad.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "MainIpadVC.h"
#import "AGTColors.h"

#import "LoadData.h"
#import "LoadModels.h"
#import "COCategory.h"

#define TITLE_VIEW @"Categorias"

@interface MainIpadVC ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *modelCat;
@property (nonatomic, strong) AGTColors *model;
+(NSUInteger) maxRandomColorsToDisplay;
+(NSString *) randomColorCellId;
@end

@implementation MainIpadVC

#pragma mark - Class methods
+(NSUInteger) maxRandomColorsToDisplay{
    return 104;
}
+(NSString *) randomColorCellId{
    return @"randomColor";
}

#pragma mark - Init
-(id) initWithModel:(AGTColors *) colors
             layout:(UICollectionViewLayout *) layout{
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _model = colors;
        self.title = TITLE_VIEW;
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerRandomColorCell];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color = [UIColor redColor];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    LoadData *obtainData = [[LoadData alloc] initWithCollectionViewController:self];
    [self.queue addOperation:obtainData];
    
    
}


-(void)registerRandomColorCell{
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:[MainIpadVC randomColorCellId]];
}

#pragma mark - Load Model
-(void)loadModel{
    
    LoadModels *modelCat = [[LoadModels alloc] init];
    self.modelCat = [modelCat loadCategories];
    [self.activityIndicator stopAnimating];
    [self.collectionView reloadData];
    
}

#pragma mark - Data Source
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return [self.modelCat count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MainIpadVC randomColorCellId] forIndexPath:indexPath];
    
    cell.backgroundColor = [self.model randomColor];
    
    CGRect lblTitle = CGRectMake(1, 1, 100 , 100);
    UILabel *lblt = [[UILabel alloc] initWithFrame:lblTitle];
    lblt.textColor = [UIColor blackColor];
    lblt.text = @"Resumen";
    lblt.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblt];
    
    [cell addSubview:lblt];
    
    return cell;
    
}



#pragma mark - Memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
