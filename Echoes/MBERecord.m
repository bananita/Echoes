//
//  MBERecord.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "MBERecord.h"

@implementation MBERecord

- (NSDictionary *)dictionary {
    return @{
             @"statusCode": @(self.statusCode),
             @"headers": self.headers,
             @"body":[[NSString alloc] initWithData:self.data encoding:NSStringEncodingConversionAllowLossy]
             };
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];

    if (self) {
        self.statusCode = [[dictionary objectForKey:@"statusCode"] integerValue];
        NSString*body = [[dictionary objectForKey:@"body"] self];
        self.data = [body dataUsingEncoding:NSStringEncodingConversionAllowLossy];
        self.headers=[dictionary objectForKey:@"headers"];
    }

    return self;
}

@end
