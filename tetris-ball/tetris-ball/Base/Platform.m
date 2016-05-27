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
                BaseCollidableObject *node = [[BaseCollidableObject alloc] initWithImageNamed:@"Default-Block"];
                
                CGFloat xPosition = 50;
                CGFloat yPosition = 50;
                
                xPosition = i == 0 ? - node.frame.size.width - i * 50 : xPosition;
                xPosition = i == 2 ? node.frame.size.width + i * 50 : xPosition;
                
                yPosition = j == 0 ? - node.frame.size.width - j * 50 : yPosition;
                yPosition = j == 2 ? node.frame.size.width + j * 50 : yPosition;
                
                node.position = CGPointMake(xPosition, yPosition);
                node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
                node.physicsBody.dynamic = NO;
                node.physicsBody.categoryBitMask = PLATFORM_MASK;
                node.physicsBody.contactTestBitMask = BALL_MASK;
                
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

- (void) rotateWithCompletion:(void (^)())completion
{
    SKAction *action = [SKAction rotateByAngle:M_PI_2 duration:0.25];
    [self runAction:action completion:completion];
}

@end
