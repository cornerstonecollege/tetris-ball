//
//  Ball.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BaseShapeCollidableObject.h"

@interface Ball : BaseShapeCollidableObject

+ (instancetype) ballDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color;

- (void) bounce;
- (void) applyAccelerometerForce:(double)forceX;
- (void) bounceHorizontally;

@end
