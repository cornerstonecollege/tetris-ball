//
//  View.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "View.h"

@implementation View

- (void) viewClickReceivedWithLocation:(CGPoint)location
{
    //Will be implamented by the sub class.
}

- (void) buildViewWithParent:(SKScene *)parent
{
    //Will be implamented by the sub class.
}

- (void) removeObjectsFromParent
{
    if (self.arrObjects)
    {
        [self.arrObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [obj removeFromParent];
        }];
    }
    
    self.arrObjects = [NSMutableArray array];
}

@end
