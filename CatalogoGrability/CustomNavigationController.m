//
//  CustomNavigationController.m
//  CatalogoGrability
//
//  Created by Carlos Obregon on 3/12/15.
//  Copyright © 2015 wi-mobile. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:DEVICE_IPHONE]) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
    
}
@end
