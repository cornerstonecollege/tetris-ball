//
//  TPlatform.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "TPlatform.h"

@implementation TPlatform

- (instancetype)initWithParent:(SKScene *)parent
{
    matrixPlatform matrix;
    matrix[1][1] = true;
    matrix[2][0] = true;
    matrix[2][1] = true;
    matrix[2][2] = true;
    
    self = [super initWithMatrix:matrix andParent:parent];
    return self;
}

@end
