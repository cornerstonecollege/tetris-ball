//
//  Stars.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-06-02.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Stars.h"

@implementation Stars

+ (instancetype) starDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color
{
    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(90, 31)];
    [starPath addLineToPoint: CGPointMake(98.11, 42.06)];
    [starPath addLineToPoint: CGPointMake(111.87, 45.86)];
    [starPath addLineToPoint: CGPointMake(103.12, 56.49)];
    [starPath addLineToPoint: CGPointMake(103.52, 69.89)];
    [starPath addLineToPoint: CGPointMake(90, 65.4)];
    [starPath addLineToPoint: CGPointMake(76.48, 69.89)];
    [starPath addLineToPoint: CGPointMake(76.88, 56.49)];
    [starPath addLineToPoint: CGPointMake(68.13, 45.86)];
    [starPath addLineToPoint: CGPointMake(81.89, 42.06)];
    [starPath closePath];
    Stars *starDefault = [[Stars alloc] initWithPath:(CGMutablePathRef)starPath.CGPath andParent:parent];
    if (starDefault)
    {
        starDefault.fillColor = color;
        [starDefault initialize];
    }
    
    
    return starDefault;
}

- (void) initialize
{
    self.xScale = 0.8;
    self.yScale = 0.8;
    
    self.physicsBody.categoryBitMask = STAR_MASK;
    self.physicsBody.contactTestBitMask = BALL_MASK;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    
    SKAction *action1 = [SKAction moveByX:0 y:-30 duration:0.7];
    SKAction *action2 = [SKAction moveByX:0 y:30 duration:0.7];
    SKAction *actionRotation = [SKAction repeatActionForever:[SKAction sequence:@[action1, action2]]];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:0.7];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:0.7];
    [self runAction:actionRotation];
    SKAction *fadeRotation = [SKAction repeatActionForever:[SKAction sequence:@[fadeOut, fadeIn]]];
    [self runAction:fadeRotation];
}

@end
