//
//  Stars.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-06-02.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseShapeCollidableObject.h"

@interface Stars : BaseShapeCollidableObject

+ (instancetype) starDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color;

@end
