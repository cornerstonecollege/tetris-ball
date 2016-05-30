//
//  NewGameView.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "NewGameView.h"
#import "GameScene.h"
#import "Platform.h"
#import "Ball.h"
#import "ShapeBackground.h"

@interface NewGameView () <SKPhysicsContactDelegate, GameSceneTimerDelegate>

@property (nonatomic) BOOL isNotVertical;

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
    __weak NewGameView *weakSelf = self;
    [((GameScene*)self.parent).timerDelegateArr addObject:weakSelf];
    parent.physicsWorld.contactDelegate = self;
    
    SKLabelNode *jumpLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    
    jumpLabel.text = @"Jump";
    jumpLabel.fontSize = 45;
    jumpLabel.position = CGPointMake(parent.size.width - jumpLabel.frame.size.width / 2 - 30, 30);
    jumpLabel.fontColor = [SKColor colorWithRed:1.0 green:0.31 blue:0.22 alpha:0.8];
    
    [self.parent addChild:jumpLabel];
    
    __weak SKLabelNode *weakJumpLabel = jumpLabel;
    [self.arrObjects addObject:weakJumpLabel];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    SKNode *node = [self.parent nodeAtPoint:location];
    static Ball *ball;
    if ([node isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode*)node;
        
        if ([label.text isEqualToString:@"Jump"])
        {
            self.isNotVertical = YES;
        }
    }
    else
    {
        
        ball = [Ball ballDefaultWithParent:self.parent andColor:[SKColor redColor]];
        ball.position = CGPointMake(CGRectGetMidX(self.parent.frame) + ball.frame.size.width / 2,CGRectGetMidY(self.parent.frame) + 100);
        
        /*static Platform *platform;
        if (!platform)
        {
            platform = [Platform platformDefaultWithParent:self.parent andColor:[SKColor blueColor]];
            platform.position = CGPointMake(CGRectGetMidX(self.parent.frame),CGRectGetMidY(self.parent.frame));
        }*/
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
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
    if (self.isNotVertical)
    {
        [ball bounceHorizontally];
        self.isNotVertical = NO;
    }
    else
    {
        [ball bounce];
    }
}

- (void) didUpdateTimerWithParentScene:(SKScene *)gameScene
{
    int randomN = arc4random_uniform(2);
    
    if (randomN)
    {
        Platform *platform1;
        platform1 = [Platform platformDefaultWithParent:self.parent andColor:[SKColor blueColor]];
        platform1.position = CGPointMake(self.parent.size.width + platform1.frame.size.width,
                                         CGRectGetMidY(self.parent.frame));
        SKAction *movePlatform = [SKAction moveByX:-self.parent.frame.size.width - self.parent.frame.size.width/2 y:0 duration:0.03 * self.parent.size.width];
    
        [platform1 runAction:movePlatform completion:^{
            [platform1 removeFromParent];
        }];
        
        [ShapeBackground moveBackgroundsWithParent:(GameScene *)gameScene];
    }
}

@end
