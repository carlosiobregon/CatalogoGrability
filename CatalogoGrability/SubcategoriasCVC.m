//
//  SubcategoriasCVC.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "SubcategoriasCVC.h"
#import "ElementsCVC.h"
#import "COSubcategory.h"
#import "AGTColors.h"
#import "LoadData.h"
#import "LoadModels.h"

#define TITLE_VIEW @"Subcategorias"

@interface SubcategoriasCVC ()
@property (nonatomic, strong) NSArray *modelSubCat;
@property (nonatomic, strong) NSString *nameCategory;
@property (nonatomic, strong) AGTColors *colors;
@end

@implementation SubcategoriasCVC

static NSString * const reuseIdentifier = @"CellSubcategory";

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
                     nameCategory:(NSString *)nameCategory{
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _nameCategory = nameCategory;
        self.title = TITLE_VIEW;
        _colors = [AGTColors new];
        [self loadModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark - Load Model
-(void)loadModel{
    LoadModels *modelSubC = [[LoadModels alloc] init];
    self.modelSubCat = [modelSubC loadSubcategories:self.nameCategory];
}

#pragma mark - Data Source
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return [self.modelSubCat count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    cell.backgroundColor = [self.colors randomColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    
    COSubcategory *subcategoria = [self.modelSubCat objectAtIndex:indexPath.row];
    
    CGRect lblFrame = CGRectMake(0, 80, 200 , 40);
    UILabel *lblName = [[UILabel alloc] initWithFrame:lblFrame];
    lblName.textColor = [UIColor blackColor];
    lblName.text = [NSString stringWithFormat:@"%@ (%u)", subcategoria.name, subcategoria.elements.count];
    lblName.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:lblName];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}

#pragma mark collection view cell layout / size
//- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return [self getCellSize:indexPath];  // will be w120xh100 or w190x100
//    // if the width is higher, only one image will be shown in a line
//}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(40, 40, 40, 40); // top, left, bottom, right
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 5.0;
//}

#pragma mark -  Delegate
-(void) collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    COSubcategory *subcategoria = [self.modelSubCat objectAtIndex:indexPath.row];
    
    // Crear el controlador
    ElementsCVC *elemento = [[ElementsCVC alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]
                                                              nameSubcategory:subcategoria.name];
    
    // Hacer un push
    [self.navigationController pushViewController:elemento animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
