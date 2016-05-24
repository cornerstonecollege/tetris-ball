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
                
                CGFloat xPosition = 50;
                CGFloat yPosition = 50;
                
                xPosition = i == 0 ? - node.frame.size.width - i * 50 : xPosition;
                xPosition = i == 2 ? node.frame.size.width + i * 50 : xPosition;
                
                yPosition = j == 0 ? - node.frame.size.width - j * 50 : yPosition;
                yPosition = j == 2 ? node.frame.size.width + j * 50 : yPosition;
                
                node.position = CGPointMake(xPosition, yPosition);
                [self addChild:node];
            }
        }
    }
}

- (void) initialize
{
    self.physicsBody.categoryBitMask = PLATFORM_MASK;
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
