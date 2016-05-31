//
//  NewGameView.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "NewGameView.h"
#import "GameScene.h"
#import "Platform.h"
#import "Ball.h"
#import "ShapeBackground.h"
#import "Session.h"

@interface NewGameView () <SKPhysicsContactDelegate, GameSceneTimerDelegate>

@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) BOOL isNotVertical;
@property (nonatomic, weak) Ball *player;
@property (nonatomic, weak) SKLabelNode *scoreLabel;
@property (nonatomic) NSInteger score;
@property (nonatomic, weak) SKLabelNode *highScoreLabel;
@property (nonatomic) BOOL isGameOver;

@end

@implementation NewGameView

#define RED_COLOR [SKColor colorWithRed:1.0 green:0.31 blue:0.22 alpha:0.8]
#define BLUE_COLOR [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8]
#define GREEN_COLOR [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8]

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
        [self initializeGyroscope];
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
    self.isGameOver = TRUE;
    [[Session sharedInstance] playAudioWithFileName:@"background_three.mp3"];
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    self.score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.score];
    self.scoreLabel.fontSize = 60;
    self.scoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame) * 0.5,parent.size.height - self.scoreLabel.frame.size.height - 30);
    self.scoreLabel.fontColor = RED_COLOR;
    [self.parent addChild:self.scoreLabel];
    
    self.highScoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",[Session sharedInstance].getMaxScore];
    self.highScoreLabel.fontSize = 60;
    self.highScoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame) * 1.5,parent.size.height - self.highScoreLabel.frame.size.height - 30);
    self.highScoreLabel.fontColor = BLUE_COLOR;
    [self.parent addChild:self.highScoreLabel];
    
    SKSpriteNode* trophyNode = [SKSpriteNode spriteNodeWithImageNamed:@"Trophy"];
    trophyNode.xScale = 0.1;
    trophyNode.yScale = 0.1;
    trophyNode.position = CGPointMake(CGRectGetMidX(parent.frame),parent.size.height - trophyNode.frame.size.height / 2 - 10);
    
    [self.parent addChild:trophyNode];	
    
   /* __weak SKLabelNode *weakJumpLabel = jumpLabel;
    [self.arrObjects addObject:weakJumpLabel];*/
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    self.isGameOver = FALSE;
    SKNode *node = [self.parent nodeAtPoint:location];
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
        self.player = [Ball ballDefaultWithParent:self.parent andColor:[SKColor redColor]];
        self.player.position = CGPointMake(CGRectGetMidX(self.parent.frame) + self.player.frame.size.width / 2,CGRectGetMidY(self.parent.frame) + 100);
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
    static NSInteger counter;
    
    counter = randomN == 0 ? counter + 1 : 0;
    Platform *platform1;
    
    if (randomN || counter > 1)
    {
        counter = 0;
        
        SKColor *color = nil;
        int colorN = arc4random_uniform(3);
        switch(colorN)
        {
            case 0: color = RED_COLOR;
                break;
            case 1: color = BLUE_COLOR;
                break;
            case 2: color = GREEN_COLOR;
                break;
            default:
                break;
            
        }
        platform1 = [Platform platformDefaultWithParent:self.parent andColor:color];
        platform1.position = CGPointMake(self.parent.size.width,
                                         CGRectGetMidY(self.parent.frame));
        SKAction *movePlatform = [SKAction moveTo:CGPointMake(-platform1.frame.size.width, platform1.frame.origin.y) duration:0.025 * self.parent.frame.size.width];
    
        [platform1 runAction:movePlatform completion:^{
            [platform1 removeFromParent];
            if (!self.isGameOver) {
                self.scoreLabel.text = [NSString stringWithFormat:@"%ld",++self.score];
            }
        }];
    }
    
    [ShapeBackground moveBackgroundsWithParent:(GameScene *)gameScene];
    if (platform1 && self.player.position.y < platform1.position.y)
    {
        [self doGameOver];
    }
}

- (void) doGameOver
{
    self.isGameOver = TRUE;
    if ([Session sharedInstance].getMaxScore < self.score) {
        [[Session sharedInstance] setMaxScore:self.score];
        self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",self.score];
    }
    self.score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.score];
}

- (void) initializeGyroscope
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.2;
    self.motionManager.gyroUpdateInterval = 0.2;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error)
     {
         [self outputAccelerationData:accelerometerData.acceleration];
     }];
}

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    [self.player applyAccelerometerForce:acceleration.x];
}

@end
