//
//  MBERequest.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "MBERequest.h"

@implementation MBERequest 

- (NSDictionary *)dictionary {
    return @{
             @"url": self.URL,
             @"method": self.method,
             @"headers": self.headers

             };
}
- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.URL = [[dictionary objectForKey:@"url"] self];
        self.method = [[dictionary objectForKey:@"method"] self];
        self.headers = [dictionary objectForKey:@"headers"];

    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    MBERequest *copy = [MBERequest new];

    copy.URL = [self.URL copy];
    copy.method = [self.method copy];
    copy.headers=[self.headers copy];

    return  copy;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.URL hash];
    hash ^= self.method.hash;


    return hash;
}

- (BOOL)isEqual:(MBERequest*)object {
    return [self.URL isEqual:object.URL] &&
    [self.method isEqual:object.method] &&
    [self.headers isEqual:object.headers];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    self = [super init]; if (!self)return nil;
    self.URL = request.URL.absoluteString;
    self.method = request.HTTPMethod;
    self.headers = request.allHTTPHeaderFields;
    return self;
}

@end
