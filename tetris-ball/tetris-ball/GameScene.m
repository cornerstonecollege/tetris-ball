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

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   __unused LandingPageView *lp = [[LandingPageView alloc]initWithGameScene:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        Ball *sprite = [Ball ballDefaultWithParent:self];
        sprite.position = location;
        
        sprite.xScale = 0.1;
        sprite.yScale = 0.1;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        [sprite runAction:[SKAction repeatActionForever:action]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
