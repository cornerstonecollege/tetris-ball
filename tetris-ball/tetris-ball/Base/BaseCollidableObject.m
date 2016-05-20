//
//  BaseCollidableObject.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseCollidableObject.h"

@implementation BaseCollidableObject

- (instancetype)initWithImageNamed:(NSString *)imageName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageName position:pos andParentScene:parent];
    
    if (self)
    {
        [self initializePhysicsBody];
    }
    
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)imageNamed imageMovableName:(NSString *)imageMovableName position:(CGPoint)pos andParentScene:(SKScene *)parent
{
    self = [super initWithImageNamed:imageNamed imageMovableName:imageMovableName position:pos andParentScene:parent];
    
    if (self)
    {
        [self initializePhysicsBody];
    }
    
    return self;
}

- (void) initializePhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.collisionBitMask = 0;
}

@end
