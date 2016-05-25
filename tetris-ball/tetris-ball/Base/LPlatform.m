//
//  LPlatform.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "LPlatform.h"

@implementation LPlatform

- (instancetype)initWithParent:(SKScene *)parent
{
    matrixPlatform matrix;
    matrix[1][0] = true;
    matrix[1][1] = true;
    matrix[1][2] = true;
    matrix[2][2] = true;
    
    self = [super initWithMatrix:matrix andParent:parent];
    return self;
}


@end
