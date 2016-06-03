//
//  BaseCollidableObject.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseSpriteObject.h"

@interface BaseCollidableObject : BaseSpriteObject

#define SCALE_SIZE(size, screenHeight) (screenHeight < 500) ? size * 0.8 : size
#define BALL_MASK 0x1 << 0
#define PLATFORM_MASK 0x1 << 1
#define STAR_MASK 0x1 << 2

@end
