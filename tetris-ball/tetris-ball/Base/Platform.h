//
//  Platform.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "BaseCollidableObject.h"

typedef BOOL matrixPlatform[3][3];

@interface Platform : BaseCollidableObject

- (instancetype) initWithMatrix:(matrixPlatform)matrix andParent:(SKScene *)parent;

@end
