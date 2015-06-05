//
//  partLoadImageTests.m
//  partLoadImageTests
//
//  Created by cts on 20/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

@interface partLoadImageTests : XCTestCase
{
    dispatch_queue_t concurrentDispatchQueue;
    NSOperationQueue* concurrentOperationQueue;
}
@end

@implementation partLoadImageTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    /**
     *  create ASYNC Q
     *
     */
    
    self->concurrentDispatchQueue =
    dispatch_queue_create("com.XCTestCase.primaryDispatchConcurrent.queue",
                          DISPATCH_QUEUE_CONCURRENT);
    
    self->concurrentOperationQueue =
    [NSOperationQueue new];
    [self->concurrentOperationQueue setName:@"com.XCTestCase.primaryOperationConcurrent.queue"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    static size_t const count = 1000;
    static size_t const iterations = 10000;
    id object = @"🐷";
    
    NSMutableArray* mutableArray = nil;
    mutableArray = [NSMutableArray array];
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        
        
        
        
             @autoreleasepool
             {
                 for (size_t i = 0; i < count; i++)
                 {
                     [mutableArray addObject:object];
                 }
             }
         

        
    }];
}

-(void)testOnePlusOneEqualsTwo
{
    XCTAssertEqual(1 + 1, 2, "one plus one should equal two");
    
    XCTestExpectation* expectation = nil;
    expectation =
    [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        
        NSLog(@"error %@",error);
        
    }];
    
    [expectation fulfill];
}


-(void)testAsynchronousURLConnectionWithSession
{
    NSURL* url = nil;
    url = [NSURL URLWithString:@"http://www.example.com/"];
    
    NSString* description = nil;
    description = [NSString stringWithFormat:@"GET %@",url];
    
    /**
     *  Expectation - create
     */
    XCTestExpectation* expectation = nil;
    expectation =
    [self expectationWithDescription:description];
    
    NSURLSession* session = nil;
    session =
    [NSURLSession sharedSession];
    
    
    void (^taskCompletionHandler)
    (NSData *data, NSURLResponse *response, NSError *error) =
    ^ void (NSData *data, NSURLResponse *response, NSError *error)
    {
        //test data
        XCTAssertNotNil(data, @"data should not be nil");
        
        //test response
        XCTAssertNotNil(response,@"response should not be nil");
        
        //text error
        XCTAssertNil(error, @"error should be nil");
        
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse* httpResponse = nil;
            httpResponse = (NSHTTPURLResponse*)response;
            
            //test StatusCode
            XCTAssertEqual([httpResponse statusCode], 200,
                           @"HTTP response status code should be 200"
                           );
            
            //test URLString
            XCTAssertEqualObjects
            ([[httpResponse URL] absoluteString],
             [url absoluteString],
             @"HTTP response URL should be equal to original URL"
             );
            
            //test MIMEType
            XCTAssertEqualObjects
            ([httpResponse MIMEType],
             @"text/html",
             @"HTTP response URL should be equal to original URL"
             );
        }
        else
        {
            XCTFail(@"Response was not NSHTTPURLResponse");
        }
        
        
        /**
         *  Expectation - fulfill
         */
        [expectation fulfill];
        
        
    };
    
    
    
    NSURLSessionDataTask* task = nil;
    task =
    [session dataTaskWithURL:url completionHandler:taskCompletionHandler];
    
    [task resume];
    
    
    /**
     *  Expectation - timeout
     * if no time out is specified
     * "Failed due to unwaited expectations." is displayed
     */
    [self waitForExpectationsWithTimeout:10.0
                                 handler:^(NSError *error) {
        
                                     [task cancel];
                                 }];
    
    
}

-(void)testAsynchronousURLConnectionWithDispatch
{
    NSURL* url = nil;
    url = [NSURL URLWithString:@"http://www.example.com/"];
    
    NSString* description = nil;
    description = [NSString stringWithFormat:@"GET %@",url];
    
    
    
    NSURLRequest* request = nil;
    request = [NSURLRequest requestWithURL:url];
    
    [self measureBlock:^
    {
        
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:nil
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        /**
         *  Expectation - create
         */
        XCTestExpectation* expectation = nil;
        expectation =
        [self expectationWithDescription:description];
        
        //test data
        XCTAssertNotNil(data, @"data should not be nil");
        
        //test response
        XCTAssertNotNil(response,@"response should not be nil");
        
        //text error
        XCTAssertNil(connectionError, @"error should be nil");
        
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse* httpResponse = nil;
            httpResponse = (NSHTTPURLResponse*)response;
            
            //test StatusCode
            XCTAssertEqual([httpResponse statusCode], 200,
                           @"HTTP response status code should be 200"
                           );
            
            //test URLString
            XCTAssertEqualObjects
            ([[httpResponse URL] absoluteString],
             [url absoluteString],
             @"HTTP response URL should be equal to original URL"
             );
            
            //test MIMEType
            XCTAssertEqualObjects
            ([httpResponse MIMEType],
             @"text/html",
             @"HTTP response URL should be equal to original URL"
             );
        }
        else
        {
            XCTFail(@"Response was not NSHTTPURLResponse");
        }
        
        
        /**
         *  Expectation - fulfill
         */
        [expectation fulfill];
        
        /**
         *  Expectation - timeout
         * if no time out is specified
         * "Failed due to unwaited expectations." is displayed
         */
        [self waitForExpectationsWithTimeout:1
                                     handler:
         ^(NSError *error)
         {
             
         }];
    
    }];//sendAsynchronousRequest
        
        
        
    }];//measureMetrics
    
    
    
}


-(void)testArrayToSetConversion
{
    NSMutableArray* array = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 10000 ; i++)
    {
        array[i] =  @(i);
    }
    
    
    //@[@"a",@"b",@"c",@"d",@"d",@"e"];
    NSSet* __block set = nil;
    
    //[self measureBlock:^{
        set = [NSSet setWithArray:array];
    //}];
    
    
//    [self measureBlock:
//     ^{
//         __unused BOOL containsObject = [set containsObject:@"e"];
//     }];
//
//    [self measureBlock:
//     ^{
//         __unused BOOL containsObject = [array containsObject:@"e"];
//     }];
    
    [self measureBlock:^{
        __unused BOOL containsObject = [array containsObject:@"e"];
    }];
    
    /**
     NSARRAy/NSMutableArray
     */
    //Fast Operations
    //indexed actions
    (void)[array objectAtIndex:0];
    (void)[array firstObject];
    (void)[array lastObject];
    
    //add/remove at either end
    [[array mutableCopy] addObject:@(0)];
    [[array mutableCopy] removeLastObject];
    
    //SLow
    //-- search
    [array containsObject:@(0)];
    [array indexOfObject:@(0)];
    [[array mutableCopy] removeObject:@(0)];
    //--- Add/Remove at arbitrary indexes
    [[array mutableCopy] insertObject:@(0) atIndex:0];
    
    //Binary search
    [[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        
        if (obj1 < obj2)
        {
            return NSOrderedAscending;
        }
        else if(obj1 == obj2)
        {
            return NSOrderedSame;
        }
        else
        {
            return NSOrderedDescending;
        }

    }] indexOfObject:@(0)
           inSortedRange:NSMakeRange(0, [array count] - 1)
                 options:NSBinarySearchingFirstEqual
         usingComparator:^NSComparisonResult(id obj1, id obj2)
     {
         if (obj1 < obj2)
         {
             return NSOrderedAscending;
         }
         else if(obj1 == obj2)
         {
             return NSOrderedSame;
         }
         else
         {
             return NSOrderedDescending;
         }
         
     }];
    
    [NSDictionary sharedKeySetForKeys:array];
    
    [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory];
    
   
    
    
    NSString* text = @"3 + 5 * 4e10";
    NSExpression* exp =
    [NSExpression expressionWithFormat:text,nil];
    NSNumber* result =
    [exp expressionValueWithObject:nil context:nil];
    
    NSLog(@"result: %@", result);
    
    NSMutableString* string = [@"😡" mutableCopy];
    
    NSLog(@"%hhu",CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformToUnicodeName, NO));
    
}


@end
