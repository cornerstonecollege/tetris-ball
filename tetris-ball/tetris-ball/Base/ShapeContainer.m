//
//  ShapeContainer.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-26.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShapeContainer.h"

@implementation ShapeContainer

+ (instancetype) containerDefaultWithParent:(SKScene *)parent andNode:(SKNode *)node
{
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGRect rect = CGRectMake(0, 0, 120, 75);
    CGPathAddRoundedRect(pathToDraw, NULL, rect, 10, 10);
    ShapeContainer *shapeDefault = [[ShapeContainer alloc] initWithPath:pathToDraw lineWidth:2.0 colorLine:[SKColor blackColor] andParent:parent];
    
    if (shapeDefault)
    {
        node.position = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        [shapeDefault addChild:node];
    }
    
    return shapeDefault;
}

@end
