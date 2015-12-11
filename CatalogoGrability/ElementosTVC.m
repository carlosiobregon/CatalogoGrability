//
//  ElementosTVC.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "ElementosTVC.h"
#import "SummaryVC.h"
#import "LoadModels.h"
#import "COElement.h"


#define TITLE_VIEW @"Elementos"

@interface ElementosTVC ()
@property (nonatomic, strong) NSString *nameSubcategoria;
@property (nonatomic, strong) NSArray *modelElements;
@end

@implementation ElementosTVC

-(id) initWithSubcategory:(NSString *)nameSubcategory
                 andStyle:(UITableViewStyle)style{
    
    if (self = [super initWithStyle:style]) {
        _nameSubcategoria = nameSubcategory;
        self.title  = TITLE_VIEW;
        [self loadModel];
    }
    
    return self;
    
}

-(void)loadModel{
    LoadModels *modelSubC = [[LoadModels alloc] init];
    self.modelElements = [modelSubC loadElements:self.nameSubcategoria];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.modelElements count];
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
    
    COElement *element = [self.modelElements objectAtIndex:indexPath.row];
    
    
    //long elements = element.elements.count;
    //itemCell.textLabel.text = [NSString stringWithFormat:@"(%lu) %@", n, [docType wmdestdo]];
    
    tag1.text = [NSString stringWithFormat:@"%@", [element name]];
    iconDoc = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[element icon]]];
    
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
    
    COElement *element = [self.modelElements objectAtIndex:indexPath.row];
    
    SummaryVC *vcSummary = [[SummaryVC alloc] initWithElement:element];
    [self.navigationController pushViewController:vcSummary animated:YES];
    
}


@end
