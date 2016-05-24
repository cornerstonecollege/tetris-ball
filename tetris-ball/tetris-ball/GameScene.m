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

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   __unused LandingPageView *lp = [[LandingPageView alloc]initWithGameScene:self];
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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
