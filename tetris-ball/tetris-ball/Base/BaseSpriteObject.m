//
//  BaseSpriteObject.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseSpriteObject.h"

@implementation BaseSpriteObject

- (instancetype) initWithImageNamed:(NSString *)imageNamed position:(CGPoint)pos andParentScene:(SKScene *)parent;
{
    self = [super initWithImageNamed:imageNamed];
    if (self)
    {
        self.position = pos;
        self.name = imageNamed;
        [parent addChild:self];
    }
    
    return self;
}

- (instancetype) initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    SKTexture *firstTexture = [SKTexture textureWithImageNamed:imageNamed];
    SKTexture *secondTexture = [SKTexture textureWithImageNamed:imageMovableName];
    
    self = [super initWithTexture:firstTexture];
    if (self)
    {
        SKAction *move = [SKAction repeatActionForever:[SKAction animateWithTextures:@[firstTexture, secondTexture] timePerFrame:0.2]];
        self.position = pos;
        self.name = imageNamed;
        [self runAction:move];
        [parent addChild:self];
    }
    
    return self;
}

- (void)setNewColor:(SKColor *)color
{
    self.color = color;
    self.colorBlendFactor = 0.4;
}

@end
