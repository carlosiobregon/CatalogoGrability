//
//  AGTColors.m
//  CollectionViewPlayground
//
//  Created by Fernando Rodríguez Romero on 02/05/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "AGTColors.h"


@implementation AGTColors


-(UIColor *) randomColor{
    
    return [UIColor colorWithHue:[self randomFloat]
                      saturation:1.0
                      brightness:[self randomFloat]
                           alpha:[self randomFloat]];
}

-(float) randomFloat{
    
    return (arc4random() % 255) / 255.0f;
}
@end
