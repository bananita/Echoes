//
//  Echoes.h
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Echoes : NSObject

@property BOOL recording;
@property NSString *currentRecordingName;

+ (void)startWithRecordingEnabled:(BOOL)recordingEnabled;

+ (void)setCurrentRecordingName:(NSString *)name;

+ (void)stop;

+ (instancetype)sharedInstance;

@end
