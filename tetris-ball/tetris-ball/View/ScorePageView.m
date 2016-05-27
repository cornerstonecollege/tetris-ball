//
//  ScorePageView.m
//  tetris-ball
//
//  Created by Dennis on 2016-05-27.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ScorePageView.h"
#import "GameScene.h"
#import "LandingPageView.h"

@implementation ScorePageView

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
    static ScorePageView *scorePage;
    if (!scorePage)
    {
        scorePage = [[ScorePageView alloc]initPrivate];
    }
    
    return scorePage;
}

- (void) buildViewWithParent: (GameScene *) parent
{
    self.parent = parent;
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
    
    scoreLabel.text = @"Score";
    scoreLabel.fontSize = 45;
    scoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                     parent.frame.size.height - scoreLabel.frame.size.height - 40);
    scoreLabel.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    [parent addChild:scoreLabel];
    
    __weak SKLabelNode *weakscoreLbl = scoreLabel;
    [self.arrObjects addObject:weakscoreLbl];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    SKNode *node = [self.parent nodeAtPoint:location];
    if ([node isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode*)node;
        GameScene *parent = (GameScene *)self.parent;
        if ([label.text isEqualToString:@"Score"])
        {
            [parent moveToPage:[LandingPageView sharedInstance]];
        }
    }
    else
    {
        NSLog(@"shop not clicked");
    }
}


@end
