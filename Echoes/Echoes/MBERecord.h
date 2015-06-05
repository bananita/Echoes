//
//  MBERecord.h
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBERecord : NSObject

@property NSDictionary *headers;
@property NSUInteger statusCode;
@property NSData *data;

- (NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
