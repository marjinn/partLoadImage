//
//  CDraw.m
//  partLoadImage
//
//  Created by cts on 31/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "CDraw.h"

@implementation CDraw
static inline void cdoSimpleRect (CGContextRef context);

void createPDF (id);


void drawThis (CGContextRef context,id self,CGRect rect)
{
    CGContextSetLineWidth(context, 10.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    //get mid
    CGRect mainRect = CGRectZero;
    mainRect = [self bounds];
    
    CGPoint midPoint = CGPointZero;
    midPoint = (CGPoint){ CGRectGetMidX(rect), CGRectGetMidY(rect)};
    
    CGContextBeginPath(context);
    
    //starting point
    CGContextMoveToPoint(context, midPoint.x, midPoint.y);
    
    //end point
    CGPoint endPoint = CGPointZero;
    endPoint = (CGPoint) { CGRectGetMaxX(rect),CGRectGetMaxY(rect)};
    
    //add line
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    //CGContextTranslateCTM(context, CGRectGetMinX(rect), -(CGRectGetMaxY(rect)));
    
    
    /*
     minX,minY            maxX,minY
     
     
     minX,maxY            maxX,maxY
     
     
     
     */
    
    
    
    
    
    //add another line from (0,0) to (maxX,maxY)
    CGPoint fullLineStartPoint = CGPointZero;
    fullLineStartPoint = (CGPoint) { CGRectGetMinX(rect), CGRectGetMaxY(rect) };
    
    CGPoint fullLineEndPoint = CGPointZero;
    fullLineEndPoint = (CGPoint) { CGRectGetMaxX(rect), CGRectGetMinY(rect) };
    
    CGContextMoveToPoint(context, fullLineStartPoint.x, fullLineStartPoint.y);
    
    CGContextAddLineToPoint(context, fullLineEndPoint.x, fullLineEndPoint.y);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
  
    
    
}

void exampleDraw (CGContextRef context, CGRect rect, id self)
{
    
    rect = CGRectZero;
    
    rect = [self bounds];
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, CGRectGetMidX(rect),CGRectGetMidY(rect));
    

    CGContextSetRGBStrokeColor(context,
                               1.0f,
                               0.0f,
                               0.0f,
                               1.0f);
    
    CGContextSetLineWidth(context, 10.0f);
    
    //CGContextAddRect(context, [self bounds]);
    
    CGContextAddLineToPoint (context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextStrokeRect(context, rect);
    
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
 {
     [super drawRect:rect];
     
     CGContextRef pdfContext = UIGraphicsGetCurrentContext();
     
     exampleDraw(pdfContext, rect,self);
     
     //drawThis(pdfContext,self,rect);
     
     //cdoSimpleRect(pdfContext);
     
     createPDF(self);
     
     //[self getImageFromScreen];
     
}



__unused static inline void cdoSimpleRect (CGContextRef context)
{
    //get rect
    CGRect rect = CGRectZero;
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             1.0f,
                             0.0f,
                             0.0f,
                             1.0f);
    
    //set up the rect
    rect.origin.x   =   20.0f;
    rect.origin.y   =   20.0f;
    rect.size.width =   130.0f;
    rect.size.height    =   100.0f;
    
    //draw the rect
    CGContextFillRect(context, rect);
    
    rect.origin.x = rect.origin.x + 200.0f;
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             0.482f,
                             0.62f,
                             1.871f,
                             1.0f);
    
    CGContextStrokeRect(context, rect);
    
    rect.origin.y = rect.origin.y + 150.0f;
    
    CGContextStrokeRectWithWidth(context, rect, 15.0f);
    
    //set up fill color
    CGContextSetRGBFillColor(context,
                             0.482f,
                             1.62f,
                             0.871f,
                             1.0f);
    
    CGContextFillRect(context, rect);
    
    rect.origin.x = 20.0f;
    
    CGContextStrokeRectWithWidth(context, rect, 15.0f);
    
}


void otherDrawings (CGRect rect,id self)
{
    //
    //
    //     NSMutableData* pdfdata = nil;
    //     pdfdata = [NSMutableData data];
    //
    //     CGDataConsumerRef dataConsumer = NULL;
    //     dataConsumer  =
    //     CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)(pdfdata));
    //
    //     const CGRect mediaBox =
    //     CGRectMake(0.0f, 0.0f, CGRectGetWidth(rect)/2.0f, CGRectGetHeight(rect)/2.0f);
    //
    //     CGContextRef _pdfContext = NULL;
    //     _pdfContext =
    //     CGPDFContextCreate(dataConsumer,
    //                        &mediaBox,
    //                        NULL);
    //
    //     UIGraphicsPushContext(_pdfContext);
    //
    //
    //     CGContextBeginPage(_pdfContext, &mediaBox);
    //
    //     // Drawing code
    ////     CGContextRef const context = UIGraphicsGetCurrentContext();
    ////
    ////     CGContextSetLineWidth(context, 10.0);
    ////     CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    ////
    ////     //get mid
    ////     CGRect mainRect = CGRectZero;
    ////     mainRect = [self bounds];
    ////
    ////     CGPoint midPoint = CGPointZero;
    ////     midPoint = (CGPoint){ CGRectGetMidX(rect), CGRectGetMidY(rect)};
    ////
    ////     CGContextBeginPath(context);
    ////
    ////     //starting point
    ////     CGContextMoveToPoint(context, midPoint.x, midPoint.y);
    ////
    ////     //end point
    ////     CGPoint endPoint = CGPointZero;
    ////     endPoint = (CGPoint) { CGRectGetMaxX(rect),CGRectGetMaxY(rect)};
    ////
    ////     //add line
    ////     CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    ////
    ////     //CGContextTranslateCTM(context, CGRectGetMinX(rect), -(CGRectGetMaxY(rect)));
    ////
    ////
    ////     /*
    ////      minX,minY            maxX,minY
    ////
    ////
    ////      minX,maxY            maxX,maxY
    ////
    ////
    ////
    ////      */
    ////
    ////
    ////
    ////
    ////
    ////     //add another line from (0,0) to (maxX,maxY)
    ////     CGPoint fullLineStartPoint = CGPointZero;
    ////     fullLineStartPoint = (CGPoint) { CGRectGetMinX(rect), CGRectGetMaxY(rect) };
    ////
    ////     CGPoint fullLineEndPoint = CGPointZero;
    ////     fullLineEndPoint = (CGPoint) { CGRectGetMaxX(rect), CGRectGetMinY(rect) };
    ////
    ////     CGContextMoveToPoint(context, fullLineStartPoint.x, fullLineStartPoint.y);
    ////
    ////     CGContextAddLineToPoint(context, fullLineEndPoint.x, fullLineEndPoint.y);
    ////
    ////     //draw
    ////     CGContextDrawPath(context, kCGPathStroke);
    //
    //
    //     CGContextEndPage(_pdfContext);
    //
    //     CGPDFContextClose(_pdfContext);
    //
    //     UIGraphicsPopContext();
    //
    //
    //     CGContextRelease(_pdfContext);
    //
    //     CGDataConsumerRelease(dataConsumer);
    
    CGRect pageRect = CGRectZero;
    CGContextRef pdfContext = NULL;
    CFStringRef path = NULL;
    CFURLRef url = NULL;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    path = CFStringCreateWithCString(NULL,
                                     "app_laude.pdf",
                                     kCFStringEncodingUTF8);
    
    const NSString* const path_ = [[NSBundle mainBundle] resourcePath];
    
    url = CFURLCreateWithFileSystemPath(NULL,
                                        (__bridge CFStringRef)(path_),
                                        kCFURLPOSIXPathStyle,
                                        false);
    
    myDictionary = CFDictionaryCreateMutable(NULL,
                                             0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    
    pdfContext = CGPDFContextCreateWithURL(url
                                           , &pageRect,
                                           myDictionary);
    
    CFRelease(myDictionary);
    CFRelease(url);
    
    pageDictionary = CFDictionaryCreateMutable(NULL,
                                               0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    
    boxData = CFDataCreate(NULL, (const UInt8 *)&pageRect, sizeof(CGRect));
    
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    
    CGPDFContextBeginPage(pdfContext, pageDictionary);
    
    //ALL PDF DRAWING
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    context = pdfContext;
    
    CGContextSetLineWidth(context, 10.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    //get mid
    CGRect mainRect = CGRectZero;
    mainRect = [self bounds];
    
    CGPoint midPoint = CGPointZero;
    midPoint = (CGPoint){ CGRectGetMidX(rect), CGRectGetMidY(rect)};
    
    CGContextBeginPath(context);
    
    //starting point
    CGContextMoveToPoint(context, midPoint.x, midPoint.y);
    
    //end point
    CGPoint endPoint = CGPointZero;
    endPoint = (CGPoint) { CGRectGetMaxX(rect),CGRectGetMaxY(rect)};
    
    //add line
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    //CGContextTranslateCTM(context, CGRectGetMinX(rect), -(CGRectGetMaxY(rect)));
    
    
    /*
     minX,minY            maxX,minY
     
     
     minX,maxY            maxX,maxY
     
     
     
     */
    
    
    
    
    
    //add another line from (0,0) to (maxX,maxY)
    CGPoint fullLineStartPoint = CGPointZero;
    fullLineStartPoint = (CGPoint) { CGRectGetMinX(rect), CGRectGetMaxY(rect) };
    
    CGPoint fullLineEndPoint = CGPointZero;
    fullLineEndPoint = (CGPoint) { CGRectGetMaxX(rect), CGRectGetMinY(rect) };
    
    CGContextMoveToPoint(context, fullLineStartPoint.x, fullLineStartPoint.y);
    
    CGContextAddLineToPoint(context, fullLineEndPoint.x, fullLineEndPoint.y);
    
    //draw
    CGContextDrawPath(context, kCGPathStroke);
    
    ///
    
    CGPDFContextEndPage(pdfContext);
    
    CGContextRelease(pdfContext);
    
    CFRelease(pageDictionary);
    
    CFRelease(boxData);

    CFRelease(path);
}

void justDraw (CGContextRef pdfContext,CGRect pageRect)
{
    CGContextBeginPath(pdfContext);
    
    CGContextSetRGBStrokeColor(pdfContext,
                               1.0f,
                               0.0f,
                               0.0f,
                               1.0f);
    CGContextSetLineWidth(pdfContext, 10.0f);
    
    CGContextAddRect(pdfContext, pageRect);
    
    CGContextStrokePath(pdfContext);
}

/*
 Steps to create a PDF
 1.Choose  a name for the PDF file
 2.Choose a path, which includes the PDF file name
 3.If metadata like "Title" or "Author name" needs to be added
     - Create a dictionary with those
 4. Create a PDF Context using
        CGContextRef 
        CGPDFContextCreateWithURL (
                                    CFURLRef url,
                                    const CGRect *mediaBox,
                                    CFDictionaryRef auxiliaryInfo
                                    );
 
 url -> is the path of the PDF
 mediaBox -> - is a  CGRect that represents the dimensiosn of the PDF
             - is typically a rectange with origin at (0,0)
             - If you pass NULL, 
                CGPDFContextCreateWithURL uses a default page size of 8.5 by 11 inches 
                (612 by 792 points).
 
 5.Create page metadata - the page info dictionary
        eg: kCGPDFContextMediaBox
 boxData = CFDataCreate(NULL, (const UInt8 *)&pageRect, sizeof(CGRect));
 
 CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
 
 6. Create a new Page
    Begins a new page in a PDF graphics context.
    You must call the function CGPDFContextEndPage to signal the end of the
    page.
 
    CGPDFContextBeginPage(CGContextRef context,
                        CFDictionaryRef pageInfo)
 
 8. Draw
 9. End Page
    CGPDFContextEndPage(CGContextRef context)
 */

void createPDF (id self)
{
    CGRect pageRect = (CGRect){{0.0f,0.0f},{300.0f,300.0f}};
    CGContextRef pdfContext = NULL;
    CFStringRef path = NULL;
    CFURLRef url = NULL;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    //fileName
    path = CFStringCreateWithCString(NULL,
                                     "app_laude.pdf",
                                     kCFStringEncodingUTF8);
    
    const NSString* const path_ =
    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:(NSString *)CFBridgingRelease(path)];
    
    //create with
    url = CFURLCreateWithFileSystemPath(NULL,
                                        (__bridge CFStringRef)(path_),
                                        kCFURLPOSIXPathStyle,
                                        false);
    
    //Title and other MetaData
    myDictionary = CFDictionaryCreateMutable(NULL,
                                             0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    
    //create PDF Context
    pdfContext = CGPDFContextCreateWithURL(url
                                           , NULL, //pass NULL for default
                                           myDictionary);
    
    CFRelease(myDictionary);
    CFRelease(url);
    
    pageDictionary = CFDictionaryCreateMutable(NULL,
                                               0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    
    //page Matadata
    boxData = CFDataCreate(NULL, (const UInt8 *)&pageRect, sizeof(CGRect));
    
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    
    CGPDFContextBeginPage(pdfContext, pageDictionary);
    
    //ALL PDF DRAWING
    
    
    
    
    cdoSimpleRect(pdfContext);
    
    /**
     */
//  
//    UIGraphicsBeginImageContext(pageRect.size);
//    
//    [self drawViewHierarchyInRect:pageRect afterScreenUpdates:YES];
//    
//    UIImage* _image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    
    
    UIImage* _image = [UIImage imageNamed:@"trial.jpg"];
    
    //Construct an image from data
    /*
        
     */
    
    NSData* data = nil;
    data = UIImageJPEGRepresentation(_image, 1.0);
    
    /**
     *  save image to disk
     */
    NSString* pathToImage =
    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"alphaPict.jpg"];
    
    [data writeToFile:pathToImage atomically:YES];
     
    //dataProvider
    CFDataRef cfData = NULL;
    cfData = (__bridge CFDataRef)data;
    
    CGDataProviderRef dataProvider = NULL;
    dataProvider = CGDataProviderCreateWithCFData(cfData);
    
    //CGImage
    CGImageRef image = NULL;
    image = CGImageCreateWithJPEGDataProvider(dataProvider,
                                              NULL,
                                              false,
                                              kCGRenderingIntentDefault);
    
    //release dataProvider
    CGDataProviderRelease(dataProvider);
    
    size_t width = 0;
    width = CGImageGetWidth(image);
    
    size_t height = 0;
    height = CGImageGetHeight(image);
    
    size_t bytesPerRow = 0;CGImageGetBytesPerRow(image);
    bytesPerRow = (width * 4);
    
    size_t byteCount = 0;CGImageGetBitsPerPixel(image);
    byteCount = (height * bytesPerRow);
    
    void* imageBuffer = NULL;
    imageBuffer = malloc(byteCount);
    
    if (0 == width || 0 == height)
    {
        //        dispatch_queue_t queue = 0;
        //        queue = dispatch_get_main_queue();
        //
        //        void (^mainBlock) (void) =
        //        ^void (void)
        //        {
        //            if (callBack)
        //            {
        //                callBack(nil);
        //            }
        //        };
        //
        //        dispatch_async(queue,mainBlock);
    }
    
    //get the color Space
    CGColorSpaceRef colorSpace = NULL;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const size_t bitsPerComponent = 8;
    
    //create a bitMapContext
    CGContextRef imageContext = NULL;
    imageContext =
    CGBitmapContextCreate(
                          imageBuffer,
                          width,
                          height,
                          bitsPerComponent,
                          bytesPerRow,
                          colorSpace,
                          kCGImageAlphaNone | kCGImageAlphaNoneSkipLast);
    
    //release color Space
    CGColorSpaceRelease(colorSpace);
    
    //draw
    CGContextDrawImage(imageContext,
                       CGRectMake(0., 0., width/2, height/2),
                       image);
    
    //image Release
    CGImageRelease(image);
    
    //get the image from context
    CGImageRef outPutImage = NULL;
    outPutImage = CGBitmapContextCreateImage(imageContext);
    
    //release COntext
    CGContextRelease(imageContext);
    
    free(imageBuffer);
    
    
    
    
    UIImage* imageFromBitMapContext = nil;
    imageFromBitMapContext = [UIImage imageWithCGImage:outPutImage];
    
    CGImageRelease(outPutImage);
    
    [[self layer] setContents:(__bridge id)outPutImage];
    
    CGContextDrawImage(pdfContext, pageRect, outPutImage);
    
    
    /**
     */
    
    
     ///
    
    CGPDFContextEndPage(pdfContext);
    
    
    //page 2
    CGPDFContextBeginPage(pdfContext, pageDictionary);
    //ALL PDF DRAWING
    cdoSimpleRect(pdfContext);
    CGPDFContextEndPage(pdfContext);
    
    
    CGContextRelease(pdfContext);
    
    CFRelease(pageDictionary);
    
    CFRelease(boxData);
}

-(void)getImageFromScreen
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage* _image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //Construct an image from data
    /*
     
     */
    
    NSData* data = nil;
    data = UIImageJPEGRepresentation(_image, 1.0);
    
    //dataProvider
    CFDataRef cfData = NULL;
    cfData = (__bridge CFDataRef)data;
    
    CGDataProviderRef dataProvider = NULL;
    dataProvider = CGDataProviderCreateWithCFData(cfData);
    
    //CGImage
    CGImageRef image = NULL;
    image = CGImageCreateWithJPEGDataProvider(dataProvider,
                                              NULL,
                                              false,
                                              kCGRenderingIntentDefault);
    
    //release dataProvider
    CGDataProviderRelease(dataProvider);
    
    size_t width = 0;
    width = CGImageGetWidth(image);
    
    size_t height = 0;
    height = CGImageGetHeight(image);
    
    size_t bytesPerRow = 0;
    bytesPerRow = (width * 4);
    
    size_t byteCount = 0;
    byteCount = (height * bytesPerRow);
    
    void* imageBuffer = NULL;
    imageBuffer = malloc(byteCount);
    
    if (0 == width || 0 == height)
    {
//        dispatch_queue_t queue = 0;
//        queue = dispatch_get_main_queue();
//        
//        void (^mainBlock) (void) =
//        ^void (void)
//        {
//            if (callBack)
//            {
//                callBack(nil);
//            }
//        };
//        
//        dispatch_async(queue,mainBlock);
    }
    
    //get the color Space
    CGColorSpaceRef colorSpace = NULL;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const size_t bitsPerComponent = 8;
    
    //create a bitMapContext
    CGContextRef imageContext = NULL;
    imageContext =
    CGBitmapContextCreate(
                          imageBuffer,
                          width,
                          height,
                          bitsPerComponent,
                          bytesPerRow,
                          colorSpace,
                          kCGImageAlphaNone | kCGImageAlphaNoneSkipLast);
    
    //release color Space
    CGColorSpaceRelease(colorSpace);
    
    //draw
    CGContextDrawImage(imageContext,
                       CGRectMake(0., 0., width, height),
                       image);
    
    //image Release
    CGImageRelease(image);
    
    //get the iamge from context
    CGImageRef outPutImage = NULL;
    outPutImage = CGBitmapContextCreateImage(imageContext);
    
    //release COntext
    CGContextRelease(imageContext);
    
    free(imageBuffer);
    
    CGImageRelease(outPutImage);

}

@end
