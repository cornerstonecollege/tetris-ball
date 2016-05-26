//
//  BaseShapeObject.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseShapeObject.h"

@implementation BaseShapeObject

- (instancetype) initWithPath:(CGMutablePathRef)path andParent:(SKScene *)parent
{
    self = [super init];
    if (self)
    {
        self.path = path;
        [parent addChild:self];
    }
    
    return self;
}

- (instancetype) initWithPath:(CGMutablePathRef)path lineWidth:(CGFloat)lineWidth colorLine:(SKColor *)colorLine andParent:(SKScene *)parent
{
    self = [super init];
    if (self)
    {
        self.path = path;
        self.lineWidth = lineWidth;
        [self setStrokeColor:colorLine];
        [parent addChild:self];
    }
    
    return self;
}

@end