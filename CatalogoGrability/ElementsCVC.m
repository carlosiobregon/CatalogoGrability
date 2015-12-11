//
//  ElementsCVC.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "ElementsCVC.h"
#import "SummaryVC.h"
#import "COElement.h"
#import "AGTColors.h"
#import "LoadData.h"
#import "LoadModels.h"


#define TITLE_VIEW @"Elementos"

@interface ElementsCVC ()
@property (nonatomic, strong) NSString *nameSubcategoria;
@property (nonatomic, strong) NSArray *modelElements;
@end

@implementation ElementsCVC

static NSString * const reuseIdentifier = @"Cell";

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
                  nameSubcategory:(NSString *)nameSubcategory{
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        _nameSubcategoria = nameSubcategory;
        self.title = TITLE_VIEW;
        [self loadModel];
    }
    return self;
}

#pragma mark - Load Model
-(void)loadModel{
    LoadModels *modelElements = [[LoadModels alloc] init];
    self.modelElements = [modelElements loadElements:self.nameSubcategoria];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Data Source
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return [self.modelElements count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    COElement *element = [self.modelElements objectAtIndex:indexPath.row];
    
    CGRect lblFrame = CGRectMake(0, 250, 300 , 50);
    UILabel *lblName = [[UILabel alloc] initWithFrame:lblFrame];
    lblName.textColor = [UIColor blackColor];
    lblName.text = [NSString stringWithFormat:@"%@", element.name];
    lblName.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:lblName];
    
    CGRect iconFrame = CGRectMake(30, 30, 200 , 200);
    UIImageView *icon = [[UIImageView alloc] initWithFrame:iconFrame];
    icon.image = [UIImage imageWithData:element.icon];
    [cell addSubview:icon];
    
    return cell;
    
}

#pragma mark -  Delegate
-(void) collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    COElement *element = [self.modelElements objectAtIndex:indexPath.row];
    
    // Crear el controlador
    SummaryVC *summaryElement = [[SummaryVC alloc] initWithElement:element];
    
    // Hacer un push
    [self.navigationController pushViewController:summaryElement animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(260, 260);
}

@end
