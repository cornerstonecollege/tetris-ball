//
//  ShapeBackground.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShapeBackground.h"
#import "GameScene.h"

@implementation ShapeBackground

#define SPACE_LINE 15

- (instancetype)initWithColorLine:(UIColor *)colorLine andParent:(SKScene *)parent
{
    CGMutablePathRef path = [ShapeBackground initializeFormWithParent:parent];
    self = [super initWithPath:path lineWidth:1.0 colorLine:colorLine andParent:parent];
    
    if (self)
    {
        [self removeFromParent];
        [parent insertChild:self atIndex:0];
    }
    
    return self;
}

+ (CGMutablePathRef) initializeFormWithParent:(SKScene*)parent
{
    CGSize size = parent.size;
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    
    for (int y = 0; y < size.height; y += SPACE_LINE)
    {
        CGPathMoveToPoint(pathToDraw, NULL, 0.0, y);
        CGPathAddLineToPoint(pathToDraw, NULL, size.width, y);
    }
    
    for (int x = 0; x < size.width; x += SPACE_LINE)
    {
        CGPathMoveToPoint(pathToDraw, NULL, x, 0.0);
        CGPathAddLineToPoint(pathToDraw, NULL, x, size.height);
    }
    
    return pathToDraw;
}

+ (void) moveBackgroundsWithParent:(GameScene *)parent
{
    static BOOL isRunning;
    
    if (isRunning)
        return;
    
    isRunning = YES;
    
    NSArray *arrBackground = @[parent.background, parent.background2];
    SKAction *moveBackgroundMovable = [SKAction moveByX:-parent.background.frame.size.width y:0 duration:0.02 * parent.background.frame.size.width / 2];
    SKAction *resetBackgroundMovable = [SKAction moveByX:parent.background.frame.size.width y:0 duration:0];
    SKAction *backgroundMovable = [SKAction sequence:@[moveBackgroundMovable, resetBackgroundMovable]];
    
    for (int i = 0; i < 2; i++)
    {
        ShapeBackground *background = (ShapeBackground *)arrBackground[i];
        [background runAction:backgroundMovable completion:^{
            isRunning = NO;
        }];
    }
}


@end
