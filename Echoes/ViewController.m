//
//  ViewController.m
//  Echoes
//
//  Created by Michal Banasiak on 04.06.2015.
//  Copyright (c) 2015 SO MANY APPS. All rights reserved.
//

#import "ViewController.h"
#import "Echoes.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [Echoes startWithRecordingEnabled:NO];
    [Echoes setCurrentRecordingName:@"dupa"];

    NSString *path = @"http://localhost:3000/api/v1/token?api_key=f61081511557c5745ccef63574388874";
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *authStr = [NSString stringWithFormat:@"user1:password"];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    id r = request.allHTTPHeaderFields;

    // use either NSURLSession or NSURLConnection
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        id s = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"%@ %@",response.URL, s);
    }];
    [task resume];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        {
            NSString *path = @"http://localhost:3000/api/v1/token?api_key=f61081511557c5745ccef63574388874";
            NSURL *url = [NSURL URLWithString:path];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            NSString *authStr = [NSString stringWithFormat:@"user1:password1"];
            NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
            NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
            [request setValue:authValue forHTTPHeaderField:@"Authorization"];
            request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
            id r = request.allHTTPHeaderFields;

            // use either NSURLSession or NSURLConnection
            NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                id s = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
                NSLog(@"%@ %@",response.URL, s);
            }];

            [task resume];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            {
                NSString *path = @"http://localhost:3000/api/v1/token?api_key=f61081511557c5745ccef63574388874";
                NSURL *url = [NSURL URLWithString:path];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                NSString *authStr = [NSString stringWithFormat:@"user1:password1"];
                NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
                NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
                [request setValue:authValue forHTTPHeaderField:@"Authorization"];
                request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
                id r = request.allHTTPHeaderFields;

                // use either NSURLSession or NSURLConnection
                NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                    id s = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
                    NSLog(@"%@ %@",response.URL, s);
                }];

                [task resume];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                {
                    NSString *path = @"http://localhost:3000/api/v1/token?api_key=f61081511557c5745ccef63574388874";
                    NSURL *url = [NSURL URLWithString:path];
                    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                    NSString *authStr = [NSString stringWithFormat:@"user1:password1"];
                    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
                    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
                    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
                    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
                    id r = request.allHTTPHeaderFields;

                    // use either NSURLSession or NSURLConnection
                    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                        id s = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
                        NSLog(@"%@ %@",response.URL, s);
                    }];
                    
                    [task resume];
                }
            });


        });
            });


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Echoes stop];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
