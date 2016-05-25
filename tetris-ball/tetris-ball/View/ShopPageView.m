//
//  ShopPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShopPageView.h"
#import "GameScene.h"

@implementation ShopPageView

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
    SKLabelNode *scoreLable = [SKLabelNode labelNodeWithFontNamed:@"Arcade"];
   
    scoreLable.text = @"Score";
    scoreLable.fontSize = 45;
    scoreLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                      CGRectGetMidY(parent.frame) * 1.3);
    scoreLable.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    [parent addChild:scoreLable];
   }

@end