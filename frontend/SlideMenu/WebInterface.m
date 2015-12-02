//
//  WebInterface.m
//  Civi_Frontend_Zeqi
//
//  Created by Aaron Graubert on 11/28/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "WebInterface.h"

@implementation WebInterface

+(NSMutableArray*)JSONDataFromUrl:(NSString*)urlRaw withPOST:(NSString*)postString
{
    NSLog(@"Starting new database POST request to URL %@", urlRaw);
    NSURL* url = [[NSURL alloc] initWithString:urlRaw];
    NSData* postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError* problem = nil;
    NSData* results = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSMutableDictionary* data = [NSJSONSerialization JSONObjectWithData:results options:NSJSONReadingMutableContainers error:&problem];
    if(data==nil) NSLog(@"Error: %@", problem);
    NSLog(@"Number of items %lu", [[data objectForKey:@"result"] count]);
    return [[NSMutableArray alloc] initWithArray:[data objectForKey:@"result"]];
}

+(NSArray*)JSONDataFromUrl:(NSString*)urlRaw
{
    NSLog(@"Starting new database request to URL %@", urlRaw);
    NSURL* url = [[NSURL alloc] initWithString:urlRaw];
    NSData* results = [NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:nil error:nil];
    NSMutableDictionary* data = [NSJSONSerialization JSONObjectWithData:results options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Number of items %lu", [[data objectForKey:@"result"] count]);
    return [[NSArray alloc] initWithArray:[data objectForKey:@"result"]];
}

@end
