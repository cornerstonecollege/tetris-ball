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
#import "Stars.h"

@interface NewGameView () <SKPhysicsContactDelegate, GameSceneTimerDelegate>

@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) BOOL isNotVertical;
@property (nonatomic, weak) Ball *player;
@property (nonatomic) SKLabelNode *scoreLabel;
@property (nonatomic) NSInteger score;
@property (nonatomic) SKLabelNode *highScoreLabel;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic) SKSpriteNode *audioNode;
@property (nonatomic, weak) SKSpriteNode *tapNode;
@property (nonatomic) SKSpriteNode *infoNode;
@property (nonatomic) NSArray<SKNode *> *creditsNodeArr;

@end

@implementation NewGameView

#define RED_COLOR [SKColor colorWithRed:1.0 green:0.31 blue:0.22 alpha:0.8]
#define BLUE_COLOR [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8]
#define GREEN_COLOR [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8]
#define BLACK_COLOR [SKColor colorWithRed:0 green:0 blue:0 alpha:0.8]

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
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    self.score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score];
    self.scoreLabel.fontSize = 60;
    self.scoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame) * 0.5,parent.size.height - self.scoreLabel.frame.size.height - 30);
    self.scoreLabel.fontColor = RED_COLOR;
    [self.parent addChild:self.scoreLabel];
    
    self.highScoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",(long)[Session sharedInstance].getMaxScore];
    self.highScoreLabel.fontSize = 60;
    self.highScoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame) * 1.5,parent.size.height - self.highScoreLabel.frame.size.height - 30);
    self.highScoreLabel.fontColor = BLUE_COLOR;
    [self.parent addChild:self.highScoreLabel];
    
    SKSpriteNode* trophyNode = [SKSpriteNode spriteNodeWithImageNamed:@"Trophy"];
    trophyNode.xScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    trophyNode.yScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    trophyNode.position = CGPointMake(CGRectGetMidX(parent.frame),parent.size.height - trophyNode.frame.size.height / 2 - 10);
    
    [self.parent addChild:trophyNode];
    
    [self doGameOver];
    
    if ([Session sharedInstance].getAudioPreference)
    {
        self.audioNode = [SKSpriteNode spriteNodeWithImageNamed:@"AudioOn"];
        [[Session sharedInstance] playAudioWithFileName:@"background_three.mp3"];
    }
    else
    {
        self.audioNode = [SKSpriteNode spriteNodeWithImageNamed:@"AudioOff"];
    }
    
    self.audioNode.xScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    self.audioNode.yScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    self.audioNode.position = CGPointMake(50.0, 50.0);
    
    [self.parent addChild:self.audioNode];
    
    self.infoNode = [SKSpriteNode spriteNodeWithImageNamed:@"InformationIcon"];
    self.infoNode.xScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    self.infoNode.yScale = SCALE_SIZE(0.1, self.parent.frame.size.height);
    self.infoNode.position = CGPointMake(parent.frame.size.width - 50, 50.0);
    
    [self.parent addChild:self.infoNode];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    if (self.creditsNodeArr && self.creditsNodeArr.count > 0)
    {
        [self.creditsNodeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromParent];
        }];
        self.creditsNodeArr = nil;
        return;
    }
    
    SKNode *node = [self.parent nodeAtPoint:location];
    if (node == self.audioNode)
    {
        BOOL isAudioEnabled = [Session sharedInstance].getAudioPreference;
        [[Session sharedInstance] setAudioPreference:!isAudioEnabled];
        [self setAudioNode];
    }
    else if (node == self.infoNode)
    {
        [self createInfo];
        return;
    }

    if (!self.isGameOver)
    {
        return;
    }
    
    if (self.tapNode)
    {
        self.tapNode.texture = [SKTexture textureWithImageNamed:@"Phone"];
        self.tapNode.xScale = SCALE_SIZE(0.25, self.parent.frame.size.height);
        SKAction *waitAction = [SKAction waitForDuration:0.4];
        SKAction *fistAction = [SKAction rotateByAngle:- M_PI_2 / 4 duration:0.2];
        SKAction *secondAction = [SKAction rotateByAngle:M_PI_2 / 2 duration:0.4];
        SKAction *thirdAction = [SKAction rotateByAngle:- M_PI_2 / 2 duration:0.4];
        SKAction *sequenceAction = [SKAction sequence:@[waitAction, fistAction, secondAction, thirdAction]];
        [self.tapNode runAction: sequenceAction completion:^{
            [self.tapNode removeFromParent];
        }];
    }
    
    self.isGameOver = FALSE;
    self.player.physicsBody.dynamic = YES;
}

- (void)createInfo
{
    SKSpriteNode *creditsNode = [SKSpriteNode spriteNodeWithColor:BLACK_COLOR size:self.parent.frame.size];
    creditsNode.position = CGPointMake(CGRectGetMidX(self.parent.frame), CGRectGetMidY(self.parent.frame));
    creditsNode.zPosition = 10;
    
    SKLabelNode *createdBy = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    createdBy.text = @"Created By";
    createdBy.fontSize = 40;
    createdBy.zPosition = 11;
    createdBy.fontColor = [SKColor whiteColor];
    createdBy.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame) +100);
    [self.parent addChild:createdBy];
    
    SKLabelNode *nameLuizPeres = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    nameLuizPeres.text = @"Luiz Peres";
    nameLuizPeres.fontSize = 25;
    nameLuizPeres.zPosition = 11;
    nameLuizPeres.fontColor = [SKColor whiteColor];
    nameLuizPeres.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame) +50);
    [self.parent addChild:nameLuizPeres];
    
    SKLabelNode *nameDennisPham = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    nameDennisPham.text = @"Dennis Pham";
    nameDennisPham.fontSize = 25;
    nameDennisPham.zPosition = 11;
    nameDennisPham.fontColor = [SKColor whiteColor];
    nameDennisPham.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame) +25);
    [self.parent addChild:nameDennisPham];
    
    SKLabelNode *nameDigbyAndrews = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    nameDigbyAndrews.text = @"Digby Andrews";
    nameDigbyAndrews.fontSize = 25;
    nameDigbyAndrews.zPosition = 11;
    nameDigbyAndrews.fontColor = [SKColor whiteColor];
    nameDigbyAndrews.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame));
    [self.parent addChild:nameDigbyAndrews];
    
    SKLabelNode *copyright = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    copyright.text = @"Copyright @ 2016 CICCC";
    copyright.fontSize = 20;
    copyright.zPosition = 11;
    copyright.fontColor = [SKColor whiteColor];
    copyright.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame) -170);
    [self.parent addChild:copyright];
    
    SKLabelNode *rightsReserved = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    rightsReserved.text = @"All rights reserved";
    rightsReserved.fontSize = 20;
    rightsReserved.zPosition = 11;
    rightsReserved.fontColor = [SKColor whiteColor];
    rightsReserved.position = CGPointMake(CGRectGetMidX(creditsNode.frame), CGRectGetMidY(creditsNode.frame) -185);
    [self.parent addChild:rightsReserved];
    
    [self.parent addChild:creditsNode];
    
    __weak SKNode* weakCreditsNode = creditsNode;
    __weak SKNode* weakCreatedBy = createdBy;
    __weak SKNode* weakNameLuizPeres = nameLuizPeres;
    __weak SKNode* weakNameDennisPham = nameDennisPham;
    __weak SKNode* weakNameDigbyAndrews = nameDigbyAndrews;
    __weak SKNode* weakCopyright = copyright;
    __weak SKNode* weakRightsReserved = rightsReserved;
    
    self.creditsNodeArr = @[weakCreditsNode, weakCreatedBy, weakNameLuizPeres, weakNameDennisPham, weakNameDigbyAndrews,weakCopyright, weakRightsReserved];
}

- (void)setAudioNode
{
    if ([Session sharedInstance].getAudioPreference)
    {
        self.audioNode.texture = [SKTexture textureWithImageNamed:@"AudioOn"];
        [[Session sharedInstance] playAudioWithFileName:@"background_three.mp3"];
    }
    else
    {
        self.audioNode.texture = [SKTexture textureWithImageNamed:@"AudioOff"];
        [[Session sharedInstance] stopAudio];
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
    
    SKPhysicsBody *starBody = nil;
    starBody = (contact.bodyA.categoryBitMask & STAR_MASK) != 0 ? contact.bodyA : starBody;
    starBody = (contact.bodyB.categoryBitMask & STAR_MASK) != 0 ? contact.bodyB : starBody;
    
    if (ballBody && platformBody)
    {
        Ball *ball = (Ball *)ballBody.node;
        Platform *platform = (Platform *)platformBody.node;
        if ([ball.fillColor isEqual:platform.fillColor])
        {
            [self makeBallBounce: ball];
        }
        else
        {
            [self.player makeExplosion];
            [self doGameOver];
        }
    }
    else if (ballBody && starBody)
    {
        {
            Ball *ball = (Ball *) ballBody.node;
            Stars *star = (Stars *) starBody.node;
            ball.fillColor = star.fillColor;
            [star removeFromParent];
        }
    }
    // otherwise do nothing
}

- (void) makeBallBounce:(Ball *)ball
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
        
        SKColor *color = [self randomColor];
        platform1 = [Platform platformDefaultWithParent:self.parent andColor:color];
        platform1.position = CGPointMake(self.parent.size.width,
                                         CGRectGetMidY(self.parent.frame));
        SKAction *movePlatform = [SKAction moveTo:CGPointMake(-platform1.frame.size.width, platform1.frame.origin.y) duration:0.025 * self.parent.frame.size.width];
    
        [platform1 runAction:movePlatform completion:^{
            [platform1 removeFromParent];
            if (!self.isGameOver) {
                self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)++self.score];
            }
        }];
        
        int starN = arc4random_uniform(3);
        if(starN == 1)
        {
            Stars *star = [Stars starDefaultWithParent:self.parent andColor:color];
            int starHeight = arc4random_uniform(30);
            star.position = CGPointMake(self.parent.size.width, CGRectGetMidY(self.parent.frame)+30+starHeight);
            SKAction *moveStar = [SKAction moveToX:-star.frame.size.width duration:0.015 * self.parent.frame.size.width];
            [star runAction:moveStar completion:^{
                [star removeFromParent];
            }];
        }
    }
    
    [ShapeBackground moveBackgroundsWithParent:(GameScene *)gameScene];
    if (platform1 && self.player.position.y < platform1.position.y)
    {
        [self doGameOver];
    }
}

- (SKColor *) randomColor
{
    int colorN = arc4random_uniform(3);
    switch(colorN)
    {
        case 0: return RED_COLOR;
        case 1: return BLUE_COLOR;
        case 2: return GREEN_COLOR;
        default: return nil;
    }
}

- (void) doGameOver
{
    self.isGameOver = TRUE;
    [self.player removeFromParent];
    
    self.player = [Ball ballDefaultWithParent:self.parent andColor:[self randomColor]];
    self.player.physicsBody.dynamic = NO;
    self.player.position = CGPointMake(CGRectGetMidX(self.parent.frame) + self.player.frame.size.width / 2,CGRectGetMidY(self.parent.frame) + 150);

    if ([Session sharedInstance].getMaxScore < self.score) {
        [[Session sharedInstance] setMaxScore:self.score];
        self.highScoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score];
    }
    self.score = 0;
    
    if (self.scoreLabel)
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score];
    
    if (!self.tapNode)
    {
        SKSpriteNode *tapNode = [SKSpriteNode spriteNodeWithImageNamed:@"Tap"];
        self.tapNode = tapNode;
        self.tapNode.xScale = SCALE_SIZE(0.3, self.parent.frame.size.height);
        self.tapNode.yScale = SCALE_SIZE(0.3, self.parent.frame.size.height);
        self.tapNode.zPosition = 2;
        self.tapNode.position = CGPointMake(CGRectGetMidX(self.parent.frame),CGRectGetMidY(self.parent.frame) * 0.65);
        
        [self.parent addChild:self.tapNode];
    }

}

- (void) initializeGyroscope
{
    if (!self.motionManager)
    {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = 0.2;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error)
         {
             [self outputAccelerationData:accelerometerData.acceleration];
         }];
    }
}

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    [self.player applyAccelerometerForce:acceleration.x];
}

@end