//
//  MainIphone.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "MainIphoneVC.h"
#import "SubcategoriasTVC.h"
#import "LoadData.h"
#import "LoadModels.h"
#import "COCategory.h"

#define TITLE_VIEW @"Categorias"

@interface MainIphoneVC()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *model;
@end

@implementation MainIphoneVC

#pragma mark -  Init
-(id) initWithStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        self.title = TITLE_VIEW;
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}


#pragma mark -  View Lifecycle
-(void) viewDidLoad{
    [super viewDidLoad];
    
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
    
    [self synchronizeData];
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)synchronizeData{
    
    int positionWidth = (self.view.frame.size.width)/2;
    int positionHeigth = (self.view.frame.size.height)/2;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.frame = CGRectMake(positionWidth - 40, positionHeigth - 40, 80 , 80);
    self.activityIndicator.color = [UIColor redColor];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    LoadData *obtainData = [[LoadData alloc] initWithTableViewController:self];
    [self.queue addOperation:obtainData];
    
}



#pragma mark - Load Model
-(void)loadModel{
    
    LoadModels *modelCat = [[LoadModels alloc] init];
    self.model = [modelCat loadCategories];
    [self.activityIndicator stopAnimating];
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ItemCell";
    UILabel *tag1;
    
    UIImageView *iconDoc;
    
    
    UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (itemCell == nil) {
        
        itemCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    tag1 = [[UILabel alloc] init];
    tag1.font = [UIFont fontWithName:@"Helvetica-Regular" size:18];
    tag1.textColor = [UIColor blackColor];
    tag1.frame = CGRectMake(72, 26, (self.tableView.frame.size.width), 18.0);
    [itemCell.contentView addSubview:tag1];
    
    COCategory *categoria = [self.model objectAtIndex:indexPath.row];
    
    
    long numSubcategorias = categoria.subcategories.count;
    //itemCell.textLabel.text = [NSString stringWithFormat:@"(%lu) %@", n, [docType wmdestdo]];
    
    tag1.text = [NSString stringWithFormat:@"%@ (%lu)", [categoria name], numSubcategorias];
    iconDoc = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[categoria icon]]];
    
    iconDoc.frame = CGRectMake(1, 1, 70, 70);
    [itemCell.contentView addSubview:iconDoc];
    
    return itemCell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    COCategory *category = [self.model objectAtIndex:indexPath.row];
    
    SubcategoriasTVC *tvcSubcategorias = [[SubcategoriasTVC alloc] initWithCategory:category.name
                                                                           andStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:tvcSubcategorias animated:YES];
    
}


@end
