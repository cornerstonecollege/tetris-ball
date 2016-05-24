//
//  ShapeBackground.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShapeBackground.h"

@implementation ShapeBackground

#define SPACE_LINE 15

- (instancetype)initWithColorLine:(UIColor *)colorLine andParent:(SKScene *)parent
{
    CGMutablePathRef path = [ShapeBackground initializeFormWithParent:parent];
    self = [super initWithPath:path lineWidth:1.0 colorLine:colorLine andParent:parent];
    
    if (self)
    {
    }
    
    return self;
}

+ (CGMutablePathRef) initializeFormWithParent:(SKScene*)parent
{
    CGSize size = parent.size;
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    
    for (int y = SPACE_LINE; y < size.width; y += SPACE_LINE)
    {
        CGPathMoveToPoint(pathToDraw, NULL, 0.0, y);
        CGPathAddLineToPoint(pathToDraw, NULL, size.width, y);
    }
    
    for (int x = SPACE_LINE; x < size.height; x += SPACE_LINE)
    {
        CGPathMoveToPoint(pathToDraw, NULL, x, 0.0);
        CGPathAddLineToPoint(pathToDraw, NULL, x, size.height);
    }
    
    return pathToDraw;
}

@end
