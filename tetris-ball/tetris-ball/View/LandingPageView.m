//
//  LandingPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "LandingPageView.h"
#import "GameScene.h"

@interface LandingPageView ()

@property (nonatomic, weak) GameScene *parent;

@end

@implementation LandingPageView

- (instancetype)init
{
    [NSException raise:@"Wrong Initializer" format:@"Please use the sharedInstance"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
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
    
    SKLabelNode *newGameLable = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    SKLabelNode *scoreLable = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    SKLabelNode *shopLable = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    
    newGameLable.text = @"New Game";
    newGameLable.fontSize = 45;
    newGameLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 1.3);
    newGameLable.fontColor = [SKColor colorWithRed:1.0 green:0.31 blue:0.22 alpha:0.8];
    
    
    [parent addChild:newGameLable];
    
    scoreLable.text = @"Score";
    scoreLable.fontSize = 45;
    scoreLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame));
    scoreLable.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    [parent addChild:scoreLable];
    
    shopLable.text = @"Shop";
    shopLable.fontSize = 45;
    shopLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                   CGRectGetMidY(parent.frame) * 0.7);
    shopLable.fontColor = [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8];
    
    [parent addChild:shopLable];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
}

@end
