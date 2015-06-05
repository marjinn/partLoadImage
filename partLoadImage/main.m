//
//  main.m
//  partLoadImage
//
//  Created by cts on 20/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"




int main(int argc, char * argv[]) {
    
    
    
    
    NSString* string = nil;
    string = @"https://api.datamarket.azure.com/Data.ashx/Bing/Search/Web?Query=%27%@%27&$top=10";
    
    
//    https://api.datamarket.azure.com/Data.ashx/Bing/Search/Composite?Sources=%27web%2bnews%27&Query=%27XBox%27&$top=10
    
    
    //string = @"https://api.datamarket.azure.com/Bing/Search/v1/Composite?Sources='web+image'&Query='%@'&$format=JSON&$top=10";
    
   string = @"https://api.datamarket.azure.com/Bing/Search/v1/Web?Query='%@'&$format=JSON&$top=10";
    
    NSString* tmp = @"black cisco digital display telephone set";
    
    CFStringRef originalString = (__bridge CFStringRef)(tmp);
    
    CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(
                                                                        kCFAllocatorDefault,
                                                                        originalString,
                                                                        NULL,
                                                                        CFSTR(":/?#[]@!$&'()*+,;="),
                                                                        kCFStringEncodingUTF8);
    
    NSString* __strong encStr = CFBridgingRelease(encodedString);
    
    //CFRelease(encodedString);
    
    
    
    NSString* url = nil;
    url = [NSString stringWithFormat:string,encStr];
    
    NSURL* urlWithString = nil;
    urlWithString = [NSURL URLWithString:url];
    
    NSString* const key = @":xjEzE0bCFS0xRBHnwgQGKXVPQqvhfcDeYcoVceYAhmo=";
    
    NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* base64 =  [data base64EncodedStringWithOptions:0];
    
    NSString* authHeaderValue = [NSString stringWithFormat:@"Basic %@",base64];
    
    NSDictionary* header = nil;
    header = @{@"Authorization" : authHeaderValue};
    
    NSMutableURLRequest* req =
    [NSMutableURLRequest requestWithURL:urlWithString];
    
    [req setHTTPMethod:@"POST"];
    
    [req setAllHTTPHeaderFields:header];
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSError* err = nil;
        
         if(data)
         {
         NSLog(@"%@",
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers error:&err]);
         }
     }];
    
    
    
    
    static size_t const count = 1000;
    static size_t const iterations = 10000;
    id object = @"🐷";
    
    extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
    
    NSMutableArray* mutableArray = nil;
    mutableArray = [NSMutableArray array];
    
    uint64_t timeToExecute = 0;
    timeToExecute =
    dispatch_benchmark
    (iterations,
     ^{
         @autoreleasepool
         {
             for (size_t i = 0; i < count; i++)
             {
                 [mutableArray addObject:object];
             }
         }
     });
    static size_t const oneNanoSecond = 1000000000;
    NSLog(@"[[NSMutableArray array] addObject:] Avg. Runtime: %Lf ns", ((long double)timeToExecute/oneNanoSecond));
    
    
    
    @autoreleasepool {
        
       
        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/**
 *  BIG O
 * O(1)
 */
BOOL containsValueAtIndex(int array[], int count, int value, int idx)
{
    return ((idx < count) && (array[idx] == value));
}

/**
 *  BIG O
 * O(n)
 */
BOOL containsValue(int array[], int count, int value)
{
    for (int i = 0; i < count; i++)//O(n) check through every index to find one
    {
        if (array[i] == value)
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  BIG O
 * O(n2)
 */
BOOL containsDuplicateValues(int array[], int count)
{
    for (int i = 0; i < count; i++) //O(n)
    {
        for (int j = 0; j < count; j++) //O(n)
        {
            if ( (i != j) && (array[i] == array[j]))
            {
                return YES;
            }
        }
    }
    
    return NO;
}
