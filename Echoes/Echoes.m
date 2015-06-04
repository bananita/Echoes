//
//  Echoes.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "Echoes.h"
#import "MBERecordingProtocol.h"
#import "MBEReplayingProtocol.h"

#import "MBECurrentRecordingSetProvider.h"
@interface Echoes ()

@end

@implementation Echoes

+ (void)startWithRecordingEnabled:(BOOL)recordingEnabled {
    [Echoes sharedInstance].recording = recordingEnabled;

    if (recordingEnabled)
        [NSURLProtocol registerClass:[MBERecordingProtocol class]];
    else
        [NSURLProtocol registerClass:[MBEReplayingProtocol class]];
}

+ (void)setCurrentRecordingName:(NSString *)name {
    [Echoes sharedInstance].currentRecordingName = name;
}

+ (void)stop {
    if ([Echoes sharedInstance].recording) {
        [MBECurrentRecordingSetProvider save];
        [NSURLProtocol unregisterClass:[MBERecordingProtocol class]];
    }
    else
        [NSURLProtocol unregisterClass:[MBEReplayingProtocol class]];
}

+ (Echoes *)sharedInstance {
    static Echoes *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Echoes new];
    });
    return instance;
}

@end
