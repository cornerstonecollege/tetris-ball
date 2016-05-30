//
//  Platform.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Platform.h"

@implementation Platform

- (instancetype)initWithPath:(CGMutablePathRef)path andParent:(SKScene *)parent
{
    self = [super initWithPath:path andParent:parent];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithPath:(CGMutablePathRef)path lineWidth:(CGFloat)lineWidth colorLine:(UIColor *)colorLine andParent:(SKScene *)parent
{
    self = [super initWithPath:path lineWidth:lineWidth colorLine:colorLine andParent:parent];
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

+ (instancetype) platformDefaultWithParent:(SKScene *)parent andColor:(SKColor *)color
{
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGRect rect = CGRectMake(0, 0, 40, 40);
    CGPathAddRoundedRect(pathToDraw, NULL, rect, 4, 4);
    Platform *platformDefault = [[Platform alloc] initWithPath:pathToDraw lineWidth:10.0 colorLine:[SKColor clearColor] andParent:parent];
     platformDefault.fillColor = color;
    
    return platformDefault;
}

- (void) initialize
{
    self.physicsBody.categoryBitMask = PLATFORM_MASK;
    self.physicsBody.contactTestBitMask = BALL_MASK;
    self.physicsBody.usesPreciseCollisionDetection = YES;
}

@end
