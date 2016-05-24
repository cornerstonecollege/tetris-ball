//
//  Ball.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Ball.h"

@implementation Ball

+ (instancetype)ballDefaultWithParent:(SKScene *)parent
{
    Ball *ball = [[Ball alloc] initWithImageNamed:@"Default-Ball" position:CGPointMake(0, 0) andParentScene:parent];
    
    if (ball)
    {
        [ball initialize];
    }
    
    return ball;
}

- (void) initialize
{
    self.physicsBody.categoryBitMask = BALL_MASK;
    self.physicsBody.dynamic = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.mass = 0.02;
    [self setNewColor:[SKColor blueColor]];
}

- (void) bounce
{
    self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
    [self.physicsBody applyImpulse:CGVectorMake(0.0, 15.0)];
}

@end
