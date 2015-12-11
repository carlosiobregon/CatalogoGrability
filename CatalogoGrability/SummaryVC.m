//
//  SummaryVC.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 11/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "SummaryVC.h"
#import "COElement.h"



@interface SummaryVC ()
@property (nonatomic, strong) COElement *element;
@end

@implementation SummaryVC

-(id) initWithElement:(COElement *)element{
    if (self = [super init]) {
        _element = element;
        self.title = element.name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewWillAppear:YES];
    
    int positionWidth = (self.view.frame.size.width);
    int positionHeigth = (self.view.frame.size.height);
    
    UIDevice *device = [UIDevice currentDevice];
    
    
    CGRect lblTitle, textViewFrame;
    if ([[device model] isEqualToString:DEVICE_IPAD]) {
        lblTitle = CGRectMake(1, 70, positionWidth , 20);
        textViewFrame = CGRectMake(1, 90, positionWidth, positionHeigth - 2);
    }
    else{
        lblTitle = CGRectMake(1, 70, positionHeigth , 19);
        textViewFrame = CGRectMake(1, 90, positionHeigth, positionWidth - 2);
    }
    
    UILabel *lblt = [[UILabel alloc] initWithFrame:lblTitle];
    lblt.textColor = [UIColor blackColor];
    lblt.text = @"Resumen";
    lblt.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblt];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    textView.backgroundColor = [UIColor whiteColor];
    NSString *summary = [NSString stringWithFormat:(@"%@"),self.element.summary];
    textView.text = summary;
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
