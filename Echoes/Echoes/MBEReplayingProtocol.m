//
//  MBEReplayingProtocol.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "MBEReplayingProtocol.h"
#import "MBECurrentRecordingSetProvider.h"

@implementation MBEReplayingProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"http"];
    BOOL isRecorded = [MBECurrentRecordingSetProvider isRecordForRequest:[[MBERequest alloc] initWithURLRequest:request]];

    return isRecorded && isHTTP;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    //TO DO HANDLE ERRORS!
    MBERequest *request = [[MBERequest alloc] initWithURLRequest:self.request];
    MBERecord *record = [MBECurrentRecordingSetProvider recordForRequest:request];


    NSURL *url = [NSURL URLWithString:request.URL];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url
                                                              statusCode:record.statusCode
                                                             HTTPVersion:@"HTTP/1.1"
                                                            headerFields:record.headers];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:record.data];
    [self.client URLProtocolDidFinishLoading:self];

}

- (void)stopLoading {
    // do nothing
}
@end
