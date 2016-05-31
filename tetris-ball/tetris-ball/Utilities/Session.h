//
//  Session.h
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-31.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+ (instancetype) sharedInstance;

- (void) setMaxScore:(NSInteger)score;
- (NSInteger) getMaxScore;
- (void) playAudioWithFileName:(NSString *)audioName;

@end
