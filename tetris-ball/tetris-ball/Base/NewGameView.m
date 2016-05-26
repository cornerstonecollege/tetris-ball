//
//  NewGameView.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "NewGameView.h"
#import "OPlatform.h"
#import "Ball.h"

@interface NewGameView () <SKPhysicsContactDelegate>

@end

@implementation NewGameView

- (instancetype)init
{
    [NSException raise:@"Wrong Initializer" format:@"Please use the sharedInstance"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
        self.arrObjects = [NSMutableArray array];
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static NewGameView *newGamePage;
    if (!newGamePage)
    {
        newGamePage = [[NewGameView alloc]initPrivate];
    }
    
    return newGamePage;
}

- (void)buildViewWithParent:(SKScene *)parent
{
    self.parent = parent;
    parent.physicsWorld.contactDelegate = self;
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    static Ball *ball;
    if (!ball)
    {
        ball = [Ball ballDefaultWithParent:self.parent];
        ball.xScale = 0.05;
        ball.yScale = 0.05;
        ball.position = CGPointMake(CGRectGetMidX(self.parent.frame),CGRectGetMidY(self.parent.frame) + 100);
    }
    
    
    static Platform *platform;
    if (!platform)
    {
        platform = [[OPlatform alloc] initWithParent:self.parent];
        platform.xScale = 0.067;
        platform.yScale = 0.067;
        platform.position = CGPointMake(CGRectGetMidX(self.parent.frame),CGRectGetMidY(self.parent.frame));
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *ballBody = nil;
    ballBody = (contact.bodyA.categoryBitMask & BALL_MASK) != 0 ? contact.bodyA : ballBody;
    ballBody = (contact.bodyB.categoryBitMask & BALL_MASK) != 0 ? contact.bodyB : ballBody;
    
    SKPhysicsBody *platformBody = nil;
    platformBody = (contact.bodyA.categoryBitMask & PLATFORM_MASK) != 0 ? contact.bodyA : platformBody;
    platformBody = (contact.bodyB.categoryBitMask & PLATFORM_MASK) != 0 ? contact.bodyB : platformBody;
    
    if (ballBody && platformBody)
    {
        [self makeBallBounce:(Ball *)ballBody.node andRotatePlatform:(Platform *)platformBody.node.parent];
    }
    
    // otherwise do nothing
}

- (void) makeBallBounce:(Ball *)ball andRotatePlatform:(Platform *)platform
{
    static BOOL isRunning;
    if (isRunning)
        return;
    
    isRunning = YES;
    
    [ball bounce];
    SKAction *action = [SKAction rotateByAngle:M_PI_2 duration:0.25];
    [platform runAction:action completion:^{
        isRunning = NO;
    }];
}

@end
