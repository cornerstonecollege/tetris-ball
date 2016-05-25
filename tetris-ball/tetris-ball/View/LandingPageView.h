//
//  LandingPageView.h
//  tetris-ball
//
//  Created by Digby Andrews on 2016-05-24.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "View.h"
@class GameScene;

@interface LandingPageView : NSObject <ViewDelegate>

+ (instancetype) sharedInstance;

@end
