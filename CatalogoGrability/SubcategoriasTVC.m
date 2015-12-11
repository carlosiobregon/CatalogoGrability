//
//  SubcategoriasTVC.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "SubcategoriasTVC.h"
#import "ElementosTVC.h"
#import "LoadModels.h"
#import "COCategory.h"
#import "COSubcategory.h"

#define TITLE_VIEW @"Subcategorias"
#define VALUE1_LABEL_TAG 1

@interface SubcategoriasTVC ()
@property (nonatomic, strong) NSString *nameCategory;
@property (nonatomic, strong) NSArray *modelSubCat;
@end

@implementation SubcategoriasTVC

-(id) initWithCategory:(NSString *)nameCategory andStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        _nameCategory = nameCategory;
        self.title = TITLE_VIEW;
        [self loadModel];
    }
    
    return self;
}

-(void)loadModel{
    LoadModels *modelSubC = [[LoadModels alloc] init];
    self.modelSubCat = [modelSubC loadSubcategories:self.nameCategory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.modelSubCat count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ItemCell";
    UILabel *tag1;
    
    
    UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (itemCell == nil) {
        
        itemCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        tag1 = [[UILabel alloc] init];
        tag1.font = [UIFont fontWithName:@"Helvetica-Regular" size:18];
        tag1.textColor = [UIColor blackColor];
        tag1.frame = CGRectMake(12, 26, (self.tableView.frame.size.width), 18.0);
        tag1.tag = VALUE1_LABEL_TAG;
    }
    else{
        tag1 = (UILabel *)[itemCell.contentView viewWithTag:VALUE1_LABEL_TAG];
    }
    
    
    [itemCell.contentView addSubview:tag1];
    
    COSubcategory *subcategoria = [self.modelSubCat objectAtIndex:indexPath.row];
    
    long elements = subcategoria.elements.count;
    
    tag1.text = [NSString stringWithFormat:@"%@ (%lu)", [subcategoria name], elements];
    tag1.textAlignment = NSTextAlignmentCenter;

    
    return itemCell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    COSubcategory *subcategory = [self.modelSubCat objectAtIndex:indexPath.row];
    
    ElementosTVC *tcvElements = [[ElementosTVC alloc] initWithSubcategory:subcategory.name andStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:tcvElements animated:YES];
    
}


@end
