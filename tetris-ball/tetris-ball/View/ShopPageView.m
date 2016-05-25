//
//  ShopPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShopPageView.h"
#import "GameScene.h"
#import "LandingPageView.h"

@interface ShopPageView ()

@end

@implementation ShopPageView

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
    static ShopPageView *shopPage;
    if (!shopPage)
    {
        shopPage = [[ShopPageView alloc]initPrivate];
    }
    
    return shopPage;
}

- (void) buildViewWithParent: (GameScene *) parent
{
    self.parent = parent;
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
   
    scoreLabel.text = @"Shop";
    scoreLabel.fontSize = 45;
    scoreLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                      CGRectGetMidY(parent.frame) * 1.3);
    scoreLabel.fontColor = [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8];
    
    [parent addChild:scoreLabel];
    
    __weak SKLabelNode *weakScoreLbl = scoreLabel;
    [self.arrObjects addObject:weakScoreLbl];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    SKNode *node = [self.parent nodeAtPoint:location];
    if ([node isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode*)node;
        GameScene *parent = (GameScene *)self.parent;
        if ([label.text isEqualToString:@"Shop"])
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