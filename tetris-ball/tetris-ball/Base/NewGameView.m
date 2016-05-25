//
//  NewGameView.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-25.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "NewGameView.h"
#import "SPlatform.h"

@implementation NewGameView

- (instancetype)init
{
    [NSException raise:@"Wrong Initializer" format:@"Please use the sharedInstance"];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self)
    {
        self.arrObjects = [NSMutableArray array];
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static NewGameView *newGamePage;
    if (!newGamePage)
    {
        newGamePage = [[NewGameView alloc]initPrivate];
    }
    
    return newGamePage;
}

- (void)buildViewWithParent:(SKScene *)parent
{
    self.parent = parent;
}

- (void)viewClickReceivedWithLocation:(CGPoint)location
{
    static Platform *platform;
    if (!platform)
    {
        platform = [[SPlatform alloc] initWithParent:self.parent];
        platform.xScale = 0.067;
        platform.yScale = 0.067;
        platform.position = CGPointMake(CGRectGetMidX(self.parent.frame),CGRectGetMidY(self.parent.frame));
    }
    else
    {
        SKAction *rotation = [SKAction rotateByAngle:M_PI_2 duration:0.25];
        [platform runAction:rotation];
    }
}

@end
