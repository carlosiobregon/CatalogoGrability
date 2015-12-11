//
//  MainIpad.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "MainIpadCVC.h"
#import "SubcategoriasCVC.h"
#import "LoadData.h"
#import "LoadModels.h"
#import "COCategory.h"

#define TITLE_VIEW @"Categorias"

@interface MainIpadCVC ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *modelCat;
@property (nonatomic) BOOL isSync;
@end

@implementation MainIpadCVC

#pragma mark - Class methods
static NSString * const reuseIdentifier = @"CellCategory";

#pragma mark - Init
-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout*)layout{
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _queue = [[NSOperationQueue alloc] init];
        self.title = TITLE_VIEW;
        _isSync = NO;
    }
    return self;
}


#pragma mark - Load Model
-(void)loadModel{
    
    LoadModels *modelCat = [[LoadModels alloc] init];
    self.modelCat = [modelCat loadCategories];
    
}


#pragma mark - View lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self registerCell];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"syncicon"];
    @try{
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    @catch (NSException *exception){
    }
    
    UIBarButtonItem *syncBtnItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(synchronizeData)];
    
    self.navigationItem.rightBarButtonItem = syncBtnItem;
    
    if (self.modelCat == nil) {
        [self synchronizeData];
    }
    
}

-(void)registerCell{
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier: reuseIdentifier];
}


#pragma mark - Sync Data
- (void)syncModel{
    
    [self loadModel];
    
    [self.collectionView reloadData];
    [self.activityIndicator stopAnimating];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.isSync = NO;
}

- (void)synchronizeData{
    
    if (!self.isSync) {
        int positionWidth = (self.view.frame.size.width)/2;
        int positionHeigth = (self.view.frame.size.height)/2;
        
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityIndicator.frame = CGRectMake(positionWidth - 40, positionHeigth - 40, 80 , 80);
        self.activityIndicator.color = [UIColor redColor];
        self.activityIndicator.hidesWhenStopped = YES;
        [self.activityIndicator startAnimating];
        [self.view addSubview:self.activityIndicator];
        
        LoadData *obtainData = [[LoadData alloc] initWithCollectionViewController:self];
        [self.queue addOperation:obtainData];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.isSync = YES;
    }
    
    
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
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    COCategory *categoria = [self.modelCat objectAtIndex:indexPath.row];
    
    CGRect lblFrame = CGRectMake(0, 250, 300 , 50);
    UILabel *lblName = [[UILabel alloc] initWithFrame:lblFrame];
    lblName.textColor = [UIColor blackColor];
    lblName.text = [NSString stringWithFormat:@"%@ (%u)", categoria.name, categoria.subcategories.count];
    lblName.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:lblName];
    
    CGRect iconFrame = CGRectMake(50, 50, 200 , 200);
    UIImageView *icon = [[UIImageView alloc] initWithFrame:iconFrame];
    icon.image = [UIImage imageWithData:categoria.icon];
    [cell addSubview:icon];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(300, 300);
}


#pragma mark -  Delegate
-(void) collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (!self.isSync) {
        // Obtener el objeto
        COCategory *categoria = [self.modelCat objectAtIndex:indexPath.row];
        
        // Crear el controlador
        SubcategoriasCVC *subcategorias = [[SubcategoriasCVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new] nameCategory:categoria.name];
        
        // Hacer un push
        [self.navigationController pushViewController:subcategorias animated:YES];
    }
    

}


#pragma mark - Memory management
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
