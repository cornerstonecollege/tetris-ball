//
//  Session.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-31.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Session.h"
#import "AVFoundation/AVFoundation.h"

@interface Session ()

@property (nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) NSString *lastAudio;

@end


@implementation Session

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
        
    }
    return self;
}

+ (instancetype) sharedInstance
{
    static Session *sessionPage;
    if (!sessionPage)
    {
        sessionPage = [[Session alloc]initPrivate];
    }
    
    return sessionPage;
}

- (void) setMaxScore:(NSInteger)score
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInteger:score]
                     forKey:@"maxScore"];
    [userDefaults synchronize];
}

- (NSInteger) getMaxScore
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *maxScore = [userDefaults objectForKey:@"maxScore"];
    if (!maxScore)
        return 0;
    return [maxScore integerValue];
}

-(void)playAudioWithFileName:(NSString *)audioName
{
    if ([self.audioPlayer isPlaying])
    {
        if (audioName == self.lastAudio)
            return;
        else
            [self.audioPlayer stop];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], audioName];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.audioPlayer.numberOfLoops = -1;
    
    if (!self.audioPlayer)
        NSLog(@"%@", [error localizedDescription]);
    else
    {
        [self.audioPlayer play];
        self.lastAudio = audioName;
    }
}

@end
