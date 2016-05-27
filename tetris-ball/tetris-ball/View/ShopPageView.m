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
#import "ShapeContainer.h"


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
    
    SKLabelNode *shopLabel = [SKLabelNode labelNodeWithFontNamed:FONT_TYPE];
   
    shopLabel.text = @"Shop";
    shopLabel.fontSize = 45;
    shopLabel.position = CGPointMake(CGRectGetMidX(parent.frame),
                                      parent.frame.size.height - shopLabel.frame.size.height - 40);
    shopLabel.fontColor = [SKColor colorWithRed:0.2 green:0.65 blue:0.89 alpha:0.8];
    
    [parent addChild:shopLabel];
    
    __weak SKLabelNode *weakshopLbl = shopLabel;
    [self.arrObjects addObject:weakshopLbl];
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"Default-Ball"];
    node.xScale = 0.1;
    node.yScale = 0.1;
    node.color = [SKColor blackColor];
    node.colorBlendFactor = 0.4;
    __unused ShapeContainer *container = [ShapeContainer containerDefaultWithParent:self.parent andNode:node];
    
    container.position = CGPointMake(10, parent.frame.size.height - container.frame.size.height - 80);
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