//
//  GameScene.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import "GameScene.h"
#import "Ball.h"
#import "LandingPageView.h"
#import "Platform.h"
#import "ShapeBackground.h"
#import "ShopPageView.h"

@interface GameScene ()

@property (nonatomic) NSTimeInterval lastSentTimeInterval;
@property (nonatomic) NSTimeInterval lastSentTimeInterval1Point5;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
 //__unused LandingPageView *lp = [[LandingPageView alloc]initWithGameScene:self];
   __unused ShopPageView *lp = [[ShopPageView alloc]initWithGameScene:self];
   __unused ShapeBackground *background = [[ShapeBackground alloc ] initWithColorLine:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.1] andParent:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        static Ball *sprite;
        if (!sprite)
        {
            sprite = [Ball ballDefaultWithParent:self];
            sprite.position = location;
            sprite.xScale = 0.1;
            sprite.yScale = 0.1;
            
            SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
            [sprite runAction:[SKAction repeatActionForever:action]];
        }
        else
        {
            [sprite bounce];
        }
        
        static Platform *platform;
        
        if (!platform)
        {
            matrixPlatform matrix = {0};
            matrix[1][1] = 1;
            matrix[2][0] = 1;
            matrix[2][1] = 1;
            matrix[2][2] = 1;
            platform = [[Platform alloc] initWithMatrix:matrix andParent:self];
            
            
            platform.xScale = 0.067;
            platform.yScale = 0.067;
            platform.position = location;
            SKAction *action = [SKAction rotateByAngle:M_PI/2 duration:0.25];
            [platform runAction:[SKAction repeatAction:action count:1]];
        }
        else
        {
            SKAction *action = [SKAction rotateByAngle:M_PI/2 duration:0.25];
            [platform runAction:[SKAction repeatAction:action count:1]];
        }
    }
}

- (void)update:(CFTimeInterval)currentTime
{
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    // more than a second since last update
    if (timeSinceLast > 1)
    {
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
    
    for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
    {
        if (timerDelegate && [timerDelegate respondsToSelector:@selector(didUpdateParentScene:)])
        {
            [timerDelegate didUpdateParentScene:self];
        }
    }
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast
{
    self.lastSentTimeInterval += timeSinceLast;
    self.lastSentTimeInterval1Point5 += timeSinceLast;
    
    if (self.lastSentTimeInterval > 1)
    {
        self.lastSentTimeInterval = 0;
        
        for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
        {
            if ([timerDelegate respondsToSelector:@selector(didUpdateTimerWithParentScene:)])
            {
                [timerDelegate didUpdateTimerWithParentScene:self];
            }
        }
    }
    
    if (self.lastSentTimeInterval1Point5 > 1.3)
    {
        self.lastSentTimeInterval1Point5 = 0;
        
        for (id<GameSceneTimerDelegate> timerDelegate in self.timerDelegateArr)
        {
            if ([timerDelegate respondsToSelector:@selector(didUpdateTimerDelayWithParentScene:)])
            {
                [timerDelegate didUpdateTimerDelayWithParentScene:self];
            }
        }
    }
}

@end
