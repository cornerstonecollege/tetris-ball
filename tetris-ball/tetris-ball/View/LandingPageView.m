//
//  LandingPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "LandingPageView.h"
#import "GameScene.h"
#import "ShopPageView.h"
#import "NewGameView.h"
#import "ScorePageView.h"

@interface LandingPageView ()

@end

@implementation LandingPageView

#define SHOP_STR @"Shop"
#define NEW_GAME_STR @"New Game"
#define SCORE_STR @"Score"

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
    static LandingPageView *landingPage;
    if (!landingPage)
    {
        landingPage = [[LandingPageView alloc]initPrivate];
    }
    
    return landingPage;
}

- (void) buildViewWithParent:(GameScene *) parent
{
    self.parent = parent;
    
    SKLabelNode *newGameLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    SKLabelNode *shopLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    
    newGameLabel.text = NEW_GAME_STR;
    newGameLabel.fontSize = 45;
    newGameLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 1.3);
    newGameLabel.fontColor = [SKColor colorWithRed:1.0 green:0.31 blue:0.22 alpha:0.8];
    
    
    [parent addChild:newGameLabel];
    
    scoreLabel.text = SCORE_STR;
    scoreLabel.fontSize = 45;
    scoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame));
    scoreLabel.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    [parent addChild:scoreLabel];
    
    shopLabel.text = SHOP_STR;
    shopLabel.fontSize = 45;
    shopLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 0.7);
    shopLabel.fontColor = [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8];
    
    [parent addChild:shopLabel];
    
    __weak SKLabelNode *weakNewGameLbl = newGameLabel;
    __weak SKLabelNode *weakScoreLbl = scoreLabel;
    __weak SKLabelNode *weakShopLbl = shopLabel;
    
    [self.arrObjects addObjectsFromArray:@[weakNewGameLbl, weakScoreLbl, weakShopLbl]];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    SKNode *node = [self.parent nodeAtPoint:location];
    if ([node isKindOfClass:[SKLabelNode class]])
    {
        
        SKLabelNode *label = (SKLabelNode*)node;
        GameScene *parent = (GameScene *)self.parent;
        if ([label.text isEqualToString:SHOP_STR])
        {
            [parent moveToPage:[ShopPageView sharedInstance]];
        }
        else if ([label.text isEqualToString:NEW_GAME_STR])
        {
            [parent moveToPage:[NewGameView sharedInstance]];
        }
        else if ([label.text isEqualToString:SCORE_STR])
        {
            [parent moveToPage:[ScorePageView sharedInstance]];
        }
    }
    else
    {
        NSLog(@"score not clicked");
    }
}

@end
