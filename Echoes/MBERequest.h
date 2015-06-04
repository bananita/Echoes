//
//  MBERequest.h
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBERequest : NSObject <NSCopying>

@property NSString *URL;
@property NSString *method;
@property NSDictionary *headers;

- (NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@end
