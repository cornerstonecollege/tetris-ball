//
//  Ball.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-20.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseCollidableObject.h"

@interface Ball : BaseCollidableObject

+ (instancetype) ballDefaultWithParent:(SKScene *)parent;

- (void) bounce;

@end
