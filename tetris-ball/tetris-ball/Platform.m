//
//  Platform.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Platform.h"

@implementation Platform

- (instancetype) initWithMatrix:(matrixPlatform)matrix andParent:(SKScene *)parent
{
    self = [super init];
    if (self)
    {
        [self buildElementWithMatrix:matrix];
        [self initialize];
        [parent addChild:self];
    }
    
    return self;
}

- (void) buildElementWithMatrix:(matrixPlatform)matrix
{
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if(matrix[i][j])
            {
                SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"Default-Block"];
                
                node.position = CGPointMake(node.frame.size.width * j - j * 50, node.frame.size.height * i + i * 50);
                [self addChild:node];
            }
        }
    }
}

- (void) initialize
{
    [self setNewColor:[SKColor redColor]];
}

- (void) setNewColor:(UIColor *)color
{
    [self.children enumerateObjectsUsingBlock:^(SKNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj isKindOfClass:[SKSpriteNode class]])
        {
            SKSpriteNode *node = (SKSpriteNode *)obj;
            node.color = color;
            node.colorBlendFactor = 0.4;
        }
    }];
}

@end
