//
//  ViewController.m
//  partLoadImage
//
//  Created by cts on 20/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

{
   NSMutableData* mutableData;
    const CALayer* newLayer;
    CABasicAnimation* dropAnimation;
}

@end

@implementation ViewController

-(void)configureTextField:(void (^)(UITextField* textField))textF
{
    
    UITextField* textFi = nil;
    textFi = [[UITextField alloc] initWithFrame:CGRectZero];
    
    [textFi setText:@"jum"];
    
    if (textF)
    {
        textF(textFi);
        
    }
}

-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [[[self view] layer] removeAnimationForKey:@"dropAnimation"];
        
        [self->newLayer removeFromSuperlayer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self->newLayer = [CALayer layer];
    //newLayer.position = cgpoin;
    
    newLayer.cornerRadius = 14.0f;
    newLayer.backgroundColor =  [[UIColor blueColor] CGColor];
    
    
    newLayer.contents = (__bridge id)([[UIImage imageNamed:@"trial.jpg"] CGImage]);
    
    CGRect slice = CGRectZero;
    CGRect remainder = CGRectZero;
    CGFloat amount = 50.0f;
    CGRectEdge edge = CGRectMinYEdge;
    
    
    
    
    CGRectDivide(self.view.bounds, &slice, &remainder, amount, edge);
    
    newLayer.frame = remainder;
    
    

    dropAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    
    [dropAnimation setDelegate:self];
    
    dropAnimation.fromValue = @(self.view.bounds.origin.y);
    dropAnimation.toValue = @(CGRectGetMaxY(self.view.bounds));
    dropAnimation.duration = 5.0f;
    
    [newLayer addAnimation:dropAnimation forKey:@"dropAnimation"];
    
    
    [[[self view]layer] addSublayer:(CALayer*)newLayer];
    
    

    
    __weak typeof(self) weakSelf = self;
    [self configureTextField:^(UITextField *textField) {
        
        typeof(weakSelf) self = weakSelf;
        
        [self description];
        
        textField.text = @"boom";
        
    }];
    
    
    
    
    self->mutableData = nil;
    
    NSString* filePath = nil;
    filePath = [[NSBundle mainBundle] pathForResource:@"trial"
                                               ofType:@".jpg"];
    
    NSURL* url = nil;
    url = [NSURL URLWithString:filePath];
    
    NSError* fileReadError = nil;
    
    NSFileHandle* fileHandle = nil;
    fileHandle =
    [NSFileHandle fileHandleForReadingFromURL:url
                                        error:&fileReadError];
    
    NSError* fileAccessError = nil;

    NSDictionary* fileAttributes = nil;
    fileAttributes =
    [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                     error:&fileAccessError];
    
    CGFloat fileSize = [[fileAttributes valueForKey:NSFileSize] floatValue];
    NSUInteger numberOfSlices = (int)round(fileSize / 1024);
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    
    
    void (^downloadBlock) (void) =
    ^void (void)
    {
        CGFloat chunkSize = 0;
        
        for (NSUInteger i = 0; i < numberOfSlices ; i++)
        {
            CGFloat currentChunkSize = chunkSize + 1024;
            
            if (fileHandle)
            {
                //start Reading
                NSData* fileData = nil;
                fileData =
                [fileHandle readDataOfLength:currentChunkSize];
                
                // NSLog(@"fileData %@",fileData);
                
                UIImage* imageFromData = nil;
                imageFromData =
                [[UIImage alloc] initWithData:fileData];
                
                if (imageFromData)
                {
                    
                    dispatch_queue_t mainQueue;
                    mainQueue = dispatch_get_main_queue();
                    
                    void (^mainBlock) (void) =
                    ^void (void)
                    {
                        void (^animationBlock) (void) =
                        ^void (void)
                        {
                            [[self imageView] setImage:imageFromData];
                            NSLog(@"dataSize %@",@([fileData length]));
                            [[self imageView] setNeedsDisplay];
                        };

                        void (^completionBlock) (BOOL) =
                        ^void (BOOL finished)
                        {
                            //NSLog(@"finished %@",@(finished));
                        };

                        
                        [UIView animateWithDuration:1
                                         animations:animationBlock
                                         completion:completionBlock];
                        
                        
                    };
                    
                    dispatch_async(mainQueue, mainBlock);
                    
                }
                
                
                [fileHandle seekToFileOffset:0];
            }
            
            chunkSize = currentChunkSize;
            NSLog(@"chunkSize %@",@(chunkSize));
        }
        
        [fileHandle closeFile];
    };
    
    dispatch_async(queue,downloadBlock);
    
    
//    CGRect pageRect = [[self view] bounds];
//    
//        UIGraphicsBeginImageContext(pageRect.size);
//    
//        [[self view ]drawViewHierarchyInRect:pageRect afterScreenUpdates:YES];
//    
//        UIImage* _image = UIGraphicsGetImageFromCurrentImageContext();
//    
//        UIGraphicsEndImageContext();
//    
//    
//    //UIImage* _image = [UIImage imageNamed:@"trial.jpg"];
//    
//    //Construct an image from data
//    /*
//     
//     */
//    
//    NSData* data = nil;
//    data = UIImageJPEGRepresentation(_image, 1.0);
//    
//    /**
//     *  save image to disk
//     */
//    NSString* pathToImage =
//    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"alphaPict_ViewDidLoad.jpg"];
//    
//    [data writeToFile:pathToImage atomically:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    }

-(void)trialWithNSURLSessionDownloadTask
{
    NSString* bundle = nil;
    bundle = [[NSBundle mainBundle] resourcePath];
    
    __unused NSString* const fileName = @"trial.jpg";
    
    NSString* const urlString =
    @"http://www.wallpaperup.com/uploads/wallpapers/2014/06/19/374229/55391d4dbe6fa0e3a8622c70f2bfc808.jpg";
    
    
    NSURLSessionConfiguration* sessionConfig = nil;
    sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //    NSURLSession* session =
    //    [NSURLSession sessionWithConfiguration:sessionConfig];
    
    //setupCache
    NSString* const cachePath = @"/mycacheDir";
    
    NSArray* pathList = nil;
    pathList =
    NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory,
     NSUserDomainMask,
     YES);
    
    NSString*  path = [pathList firstObject];
    
    NSString*  bundleIdentifier =
    [[NSBundle mainBundle] bundleIdentifier];
    
    NSString* fullCachePath = nil;
    fullCachePath =
    [[path stringByAppendingPathComponent:bundleIdentifier]
     stringByAppendingPathComponent:cachePath];
    
    NSURLCache* cache = nil;
    cache =
    [[NSURLCache alloc] initWithMemoryCapacity:16384 //bytes
                                  diskCapacity:268435456
                                      diskPath:fullCachePath];
    
    [sessionConfig setURLCache:cache];
    [sessionConfig setRequestCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    NSURLSession* session = nil;
    session =
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate:self
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    
    NSURL* url = nil;
    url = [NSURL URLWithString:urlString];
    
    NSURLRequest* req = nil;
    req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask* downloadTask = nil;
    downloadTask =
    [session downloadTaskWithRequest:req];
    
    [downloadTask resume];
}


- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    
}


/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

-(void)trialWithNSURLSessionDatatask
{
    NSString* bundle = nil;
    bundle = [[NSBundle mainBundle] resourcePath];
    
    NSString* const fileName = @"trial.jpg";
    
    NSString* const urlString =
    @"http://www.wallpaperup.com/uploads/wallpapers/2014/06/19/374229/55391d4dbe6fa0e3a8622c70f2bfc808.jpg";
    
    
    NSURLSessionConfiguration* sessionConfig = nil;
    sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    //    NSURLSession* session =
    //    [NSURLSession sessionWithConfiguration:sessionConfig];
    
    //setupCache
    NSString* const cachePath = @"/mycacheDir";
    
    NSArray* pathList = nil;
    pathList =
    NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory,
     NSUserDomainMask,
     YES);
    
    NSString*  path = [pathList firstObject];
    
    NSString*  bundleIdentifier =
    [[NSBundle mainBundle] bundleIdentifier];
    
    NSString* fullCachePath = nil;
    fullCachePath =
    [[path stringByAppendingPathComponent:bundleIdentifier]
     stringByAppendingPathComponent:cachePath];
    
    NSURLCache* cache = nil;
    cache =
    [[NSURLCache alloc] initWithMemoryCapacity:16384 //bytes
                                  diskCapacity:268435456
                                      diskPath:fullCachePath];
    
    [sessionConfig setURLCache:cache];
    [sessionConfig setRequestCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    
    NSURLSession* session = nil;
    session =
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask* dataTask = nil;
    dataTask =
    //create a task
    [session dataTaskWithURL:[NSURL URLWithString:urlString]
           completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error)
     {
         NSLog(@"response %@",response);
         NSLog(@"error %@",error);
         NSLog(@"data %@",@([data length]));
         
         if ([data length] > 0)
         {
             //save to documents dir
             NSString* imageName = @"test.jpg";
             
             //docuemnts dir
             NSArray* documenstDirArray = nil;
             documenstDirArray =
             NSSearchPathForDirectoriesInDomains
             (NSDocumentDirectory,
              NSUserDomainMask,
              YES);
             
             NSString* pathToDocumentsDir = nil;
             pathToDocumentsDir =
             [documenstDirArray firstObject];
             
             NSString* filePath = nil;
             filePath =
             [pathToDocumentsDir stringByAppendingPathComponent:imageName];
             
             //bundle path
             NSString* pathInBundle = nil;
             pathInBundle =
             [bundle stringByAppendingPathComponent:fileName];
             
             NSError* err = nil;
             NSLog(@"%@",@(
                   [data writeToFile:filePath
                             options:NSDataWritingAtomic
                               error:&err]));
             
             NSLog(@"pathInBundle %@",@(
                   [data writeToFile:pathInBundle
                             options:NSDataWritingAtomic
                               error:&err]));
             
             NSLog(@"Bundle %@",pathInBundle);
             
         }
     }];
    
    [dataTask resume];

}


@end
