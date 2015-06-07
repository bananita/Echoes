//
//  MBECurrentRecordingSetProvider.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "MBECurrentRecordingSetProvider.h"
#import "Echoes.h"

#ifndef ECHOES_RECORDINGS_DIRECTORY
#define ECHOES_RECORDINGS_DIRECTORY ""
#endif

@interface Elements : NSObject
@property NSUInteger currentIndex;
@property NSMutableArray *array;
@end

@implementation Elements
- (instancetype)init {
    self = [super init];
    self.array = [NSMutableArray new];
    return self;
}
@end

@interface MBECurrentRecordingSetProvider ()


@end

@implementation MBECurrentRecordingSetProvider

+ (void)addRecord:(MBERecord *)record forRequest:(MBERequest *)request {
    if (![MBECurrentRecordingSetProvider sharedInstance].recordings)
        [MBECurrentRecordingSetProvider sharedInstance].recordings = [NSMutableDictionary new];

    if (![MBECurrentRecordingSetProvider sharedInstance].recordings[request])
        [MBECurrentRecordingSetProvider sharedInstance].recordings[request] = [Elements new];

    [((Elements*)[MBECurrentRecordingSetProvider sharedInstance].recordings[request]).array addObject:@{@"request": request, @"response":record}];

    ((Elements*)[MBECurrentRecordingSetProvider sharedInstance].recordings[request]).currentIndex++;

}

+ (MBERecord *)recordForRequest:(MBERequest *)request {
    Elements * e =[MBECurrentRecordingSetProvider sharedInstance].recordings[request];
    return e.array[e.currentIndex++][@"response"];
}

+ (void)save {
    if (![MBECurrentRecordingSetProvider sharedInstance].recordings)
        return;

    NSString *recordingsPath = [NSString stringWithUTF8String:ECHOES_RECORDINGS_DIRECTORY];
    NSString *currentRecordingDirectoryName = [Echoes sharedInstance].currentRecordingName;

    [self createDirectory:recordingsPath];

    NSString *currentDirectoryPath = [recordingsPath stringByAppendingPathComponent:currentRecordingDirectoryName];

    [self createDirectory:currentDirectoryPath];

    NSString *recordingsFileName = [currentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", currentRecordingDirectoryName]];

    
    NSMutableArray *elements = [NSMutableArray new];
    [[MBECurrentRecordingSetProvider sharedInstance].recordings enumerateKeysAndObjectsUsingBlock:^(MBERequest * key, Elements * el, BOOL *stop) {

        [el.array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            id dict =  @{@"request": [key dictionary], @"response": [obj[@"response"] dictionary] };
            [elements addObject:dict];
        }];

    }];

    NSError *error;


    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:elements
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
    }

    [jsonData writeToFile:recordingsFileName atomically:YES];
}

+ (void)createDirectory:(NSString *)directory {
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager];

    if(![fileManager fileExistsAtPath:directory isDirectory:&isDir])
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:NULL];
}

+ (MBECurrentRecordingSetProvider *)sharedInstance {
    static MBECurrentRecordingSetProvider *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MBECurrentRecordingSetProvider new];
    });
    return instance;
}

+ (BOOL)isRecordForRequest:(MBERequest *)request {
    if (![MBECurrentRecordingSetProvider sharedInstance].recordings) {
        [MBECurrentRecordingSetProvider sharedInstance].recordings = [NSMutableDictionary new];

        NSString *recordingsPath = [NSString stringWithUTF8String:ECHOES_RECORDINGS_DIRECTORY];
        NSString *currentRecordingDirectoryName = [Echoes sharedInstance].currentRecordingName;



        NSString *currentDirectoryPath = [recordingsPath stringByAppendingPathComponent:currentRecordingDirectoryName];



        NSString *recordingsFileName = [currentDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", currentRecordingDirectoryName]];


        NSData *data = [NSData dataWithContentsOfFile:recordingsFileName];
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];

        [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
            MBERequest *request = [[MBERequest alloc] initWithDictionary:obj[@"request"]];
            MBERecord *record = [[MBERecord alloc] initWithDictionary:obj[@"response"]];

            if (![MBECurrentRecordingSetProvider sharedInstance].recordings[request])
                [MBECurrentRecordingSetProvider sharedInstance].recordings[request] = [Elements new];

            [((Elements*)[MBECurrentRecordingSetProvider sharedInstance].recordings[request]).array addObject:@{@"request": request, @"response":record}];
        }];

    }
    Elements *el = [MBECurrentRecordingSetProvider sharedInstance].recordings[request];
    NSUInteger curr = el.currentIndex;
    return curr < el.array.count;
}

@end
