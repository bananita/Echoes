//
//  MBERecordingProtocol.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "MBERecordingProtocol.h"
#import "MBERecord.h"
#import "MBERequest.h"
#import "MBECurrentRecordingSetProvider.h"

@interface MBERecordingProtocol ()
{
    MBERequest *currentRequest;
    MBERecord *currentResponse;

}
@end

@implementation MBERecordingProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    BOOL isRecording = [[self propertyForKey:@"recording" inRequest:request] boolValue];
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"http"];


    return !isRecording && isHTTP;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {

    return request;
}

- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient >)client {
    return [super initWithRequest:request cachedResponse:nil client:client];
}

- (void)startLoading {
    currentRequest = [[MBERequest alloc] initWithURLRequest:self.request];


    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    [[self class] setProperty:@(YES) forKey:@"recording" inRequest:mutableRequest];
    [NSURLConnection connectionWithRequest:mutableRequest delegate:self];

}   //TO DO HANDLE ERRORS!

- (void)stopLoading {

}   //TO DO HANDLE ERRORS!

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    currentResponse = [MBERecord new];
    currentResponse.statusCode = response.statusCode;
    currentResponse.headers = response.allHeaderFields;
    

    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}   //TO DO HANDLE ERRORS!

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    if (currentResponse.data) {
        NSMutableData *currentData = [NSMutableData dataWithData:currentResponse.data];
        [currentData appendData:data];
        currentResponse.data = currentData;
    } else {
        currentResponse.data = data;
    }
    [self.client URLProtocol:self didLoadData:data];
   //TO DO HANDLE ERRORS!
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
   //TO DO HANDLE ERRORS!
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [MBECurrentRecordingSetProvider addRecord:currentResponse forRequest:currentRequest];

    [self.client URLProtocolDidFinishLoading:self];
}

@end
