//
//  LandingPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "LandingPageView.h"
#import "GameScene.h"

@implementation LandingPageView

- (instancetype)initWithGameScene: (GameScene *) parent
{
    self = [super init];
    if (self) {
        [self initializeWithParent: parent];
    }
    return self;
}

- (void) initializeWithParent: (GameScene *) parent
{
    SKLabelNode *newGameLable = [SKLabelNode labelNodeWithFontNamed:@"Arcade"];
    SKLabelNode *scoreLable = [SKLabelNode labelNodeWithFontNamed:@"Arcade"];
    SKLabelNode *settingsLable = [SKLabelNode labelNodeWithFontNamed:@"Arcade"];
    
    newGameLable.text = @"New Game";
    newGameLable.fontSize = 45;
    newGameLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 1.3);
    newGameLable.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    
    [parent addChild:newGameLable];
    
    scoreLable.text = @"Score";
    scoreLable.fontSize = 45;
    scoreLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame));
    scoreLable.fontColor = [SKColor colorWithRed:1 green:0.58 blue:0.22 alpha:0.8];
    
    [parent addChild:scoreLable];
    
    settingsLable.text = @"Settings";
    settingsLable.fontSize = 45;
    settingsLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 0.7);
    settingsLable.fontColor = [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8];
    
    [parent addChild:settingsLable];
}

@end
