//
//  ShopPageView.m
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ShopPageView.h"
#import "GameScene.h"

@interface ShopPageView ()

@property (nonatomic, weak) GameScene *parent;

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
    
    SKLabelNode *scoreLable = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
   
    scoreLable.text = @"Score";
    scoreLable.fontSize = 45;
    scoreLable.position = CGPointMake(CGRectGetMidX(parent.frame),
                                      CGRectGetMidY(parent.frame) * 1.3);
    scoreLable.fontColor = [SKColor colorWithRed:0.2 green:0.89 blue:0.43 alpha:0.8];
    
    [parent addChild:scoreLable];
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    SKNode *node = [self.parent nodeAtPoint:location];
    if ([node isKindOfClass:[SKLabelNode class]])
    {
        SKLabelNode *label = (SKLabelNode*)node;
        if ([label.text isEqualToString:@"Score"])
        {
            NSLog(@"score clicked");
        }
    }
    else
    {
        NSLog(@"score not clicked");
    }
}

@end