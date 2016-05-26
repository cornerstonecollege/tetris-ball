//
//  ShapeContainer.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-26.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseShapeObject.h"

@interface ShapeContainer : BaseShapeObject

+ (instancetype) containerDefaultWithParent:(SKScene *)parent andNode:(SKNode *)node;

@end
