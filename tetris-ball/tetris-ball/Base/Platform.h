//
//  Platform.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseShapeCollidableObject.h"

@interface Platform : BaseShapeCollidableObject

+ (instancetype) platformDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color;

@end
