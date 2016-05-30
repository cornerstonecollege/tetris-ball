//
//  Ball.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Ball.h"

@implementation Ball

- (instancetype)initWithPath:(CGMutablePathRef)path andParent:(SKScene *)parent
{
    self = [super initWithPath:path andParent:parent];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithPath:(CGMutablePathRef)path lineWidth:(CGFloat)lineWidth colorLine:(UIColor *)colorLine andParent:(SKScene *)parent
{
    self = [super initWithPath:path lineWidth:lineWidth colorLine:colorLine andParent:parent];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

+ (instancetype) ballDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color
{
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathAddArc(pathToDraw, NULL, 0,0, 15, 0, M_PI*2, YES);
    Ball *playerDefault = [[Ball alloc] initWithPath:pathToDraw andParent:parent];
    playerDefault.fillColor = color;
    
    return playerDefault;
}

- (void) initialize
{
    self.physicsBody.categoryBitMask = BALL_MASK;
    self.physicsBody.collisionBitMask = PLATFORM_MASK;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.dynamic = YES;
    self.physicsBody.mass = 0.02;
}

- (void) applyAccelerometerForce:(double)forceX
{
    self.physicsBody.velocity = CGVectorMake(0.0, self.physicsBody.velocity.dy);
    [self.physicsBody applyForce:CGVectorMake(1000.0 * forceX, 0.0)];
}

- (void) bounce
{
    self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
    [self.physicsBody applyImpulse:CGVectorMake(0.0, 15.0)];
}

- (void) bounceHorizontally
{
    self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
    [self.physicsBody applyImpulse:CGVectorMake(5.0, 10.0)];
}

@end
