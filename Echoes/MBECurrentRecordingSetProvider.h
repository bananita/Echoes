//
//  MBECurrentRecordingSetProvider.h
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBERequest.h"
#import "MBERecord.h"

@interface MBECurrentRecordingSetProvider : NSObject

@property NSMutableDictionary *recordings;

+ (void)addRecord:(MBERecord *)record forRequest:(MBERequest *)request;
+ (MBERecord *)recordForRequest:(MBERequest *)request;

+ (BOOL)isRecordForRequest:(MBERequest *)request;

+ (void)save;

+ (instancetype)sharedInstance;

@end
