//
//  Session.m
//  tetris-ball
//
//  Created by CICCC1 on 2016-05-31.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Session.h"

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

@end
