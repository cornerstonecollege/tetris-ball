//
//  GameScene.h
//  tetris-ball
//

//  Copyright (c) 2016 Ideia do Luiz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneTimerDelegate <NSObject>

@optional
- (void) didUpdateTimerWithParentScene:(SKScene *)gameScene;
- (void) didUpdateTimerDelayWithParentScene:(SKScene *)gameScene;
- (void) didUpdateParentScene:(SKScene *)gameScene;

@end

@interface GameScene : SKScene

@property (nonatomic)  NSMutableArray<id<GameSceneTimerDelegate>> *timerDelegateArr;

@end
