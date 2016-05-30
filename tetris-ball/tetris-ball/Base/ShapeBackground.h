//
//  ShapeBackground.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseShapeObject.h"
@class GameScene;

@interface ShapeBackground : BaseShapeObject

- (instancetype)initWithColorLine:(SKColor *)colorLine andParent:(SKScene *)parent;
+ (void) moveBackgroundsWithParent:(GameScene *)parent;

@end
