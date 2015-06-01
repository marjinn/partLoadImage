//
//  LayerTrialsVC.m
//  partLoadImage
//
//  Created by cts on 04/05/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "LayerTrialsVC.h"
#import <QuartzCore/QuartzCore.h>
#import <libkern/OSAtomic.h>
#import <ImageIO/ImageIO.h>

@interface LayerTrialsVC ()

@property(nonatomic,weak)IBOutlet UIView* layerView;

@end

@implementation LayerTrialsVC

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    __weak typeof(self) weakSelf = self;
    [self configureTextField:^(UITextField *textField) {
        
        typeof(weakSelf) self = weakSelf;
        
        //[self layerCake];
        
        textField.text = @"boom";
        
    }];
    
//    { (parameters) -> return type in
//        statements
//    }
    
//    reversed = sorted(names, { [unowned self] (s1: String, s2: String) -> Bool in
//        return s1 > s2
//    })
    
//    lazy var someClosure: (UITextField*) -> void = {
//        [unowned self] (textField: UITextField*) -> Void in
//        // closure body goes here
//    }
    
    
    
    // Do any additional setup after loading the view from its nib.
    extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
    
    NSMutableArray* mutableArray = nil;
    mutableArray = [NSMutableArray array];
    
    uint64_t timeToExecute = 0;
    timeToExecute =
    dispatch_benchmark
    (1,
     ^{
         @autoreleasepool
         {
             //[self layerCake];
         }
     });
    static size_t const oneNanoSecond = 1000000000;
    NSLog(@"layerCake Avg. Runtime: %Lf ns", ((long double)timeToExecute/oneNanoSecond));
    
    
    UIImage* const image = [UIImage imageNamed:@"trial.jpg"];
    
    [[self layerView] addSubview:
    [self createACircularImageOfDimensions:[[self layerView] bounds]
                                 fromImage:image]];
    
   
    //UIImage* image = nil;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  
 
 geometry ->> layer background/LayerContent -> borders filters shadow/opacity ->mask -> Final OutPut
 
 */

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    CGContextBeginPath(ctx);
    
//    CGContextAddArc(ctx,
//                    layer.bounds.size.width/2,
//                    layer.bounds.size.height/2,
//                    layer.bounds.size.width,
//                    0.0f,
//                    2 *M_PI,
//                    true);
    CGContextSetLineWidth(ctx, 10.0f);
    
    CGContextAddEllipseInRect(ctx, [layer bounds]);
    
    CGContextSetRGBStrokeColor(ctx, 1.0f,.0f, .0f, 1.0f);
    
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

-(void)layerCake
{
    CALayer* const myLayer  = [CALayer layer];
    myLayer.delegate = self;
    
    
    
    myLayer.bounds          = [[self layerView]bounds];
    myLayer.position        = CGPointMake
    ([[self layerView] bounds].size.width/2,
     [[self layerView] bounds].size.height/2
     );
    myLayer.backgroundColor = [[UIColor blueColor] CGColor];
    
    UIImage* const image = [UIImage imageNamed:@"trial.jpg"];
    
    CGColorSpaceRef colorSpace =
    CGColorSpaceCreateDeviceRGB();
    
    //create a cgimage as it needs to be scaled
//    CGBitmapContextCreate(void *data, size_t width,
//                          size_t height, size_t bitsPerComponent, size_t bytesPerRow,
//                          CGColorSpaceRef space, CGBitmapInfo bitmapInfo)
    CGContextRef const bitmapContext =
    CGBitmapContextCreate
    (NULL,
     [myLayer bounds].size.width ,
     [myLayer bounds].size.height,
     8,
     0,
     colorSpace,
     (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage
    (bitmapContext,
     [myLayer bounds],
     [image CGImage]);
    
    //output
    CGImageRef const redrawnImage =
    CGBitmapContextCreateImage(bitmapContext);
    
//    UIImage* const decompressedImage =
//    [UIImage imageWithCGImage:redrawnImage];
    
    CGContextRelease(bitmapContext);
    
    
    myLayer.contents        = (__bridge id)(redrawnImage);
    
    CGImageRelease(redrawnImage);
    
    [[[self layerView] layer] addSublayer:myLayer];
    
    
    CAShapeLayer* const shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.borderWidth = 5.0f;
    shapeLayer.borderColor = [[UIColor whiteColor] CGColor];
    
    CGMutablePathRef const path = CGPathCreateMutable();
    CGPathAddArc
    (
     path,
     NULL,
     [[self layerView] bounds].size.width/2,
     [[self layerView] bounds].size.height/2,
     self.layerView.bounds.size.height >= self.layerView.bounds.size.width ?
     [[self layerView] bounds].size.width /4 :
     [[self layerView] bounds].size.height /4
     ,
     0.0f,
     (2 * M_PI),
     true);
    
    
    CGPathCloseSubpath(path);
    shapeLayer.path = path;
    
    CGPathRelease(path);
    
    
    myLayer.mask = shapeLayer;
    
//    [[[self layerView] layer] setBackgroundColor:
//    [[UIColor clearColor] CGColor]];
    
    BOOL noM =  NO;
    
    NSLog(@"nom b4 %@",@(noM));
    OSAtomicCompareAndSwap32Barrier(NO, YES, (volatile int32_t *)&noM);
    NSLog(@"nom af %@",@(noM));
    
    [[[self view] layer] setNeedsDisplay];
    
}


/**
 *  create a circular image
 */
-(UIView*)createACircularImageOfDimensions:(CGRect)imageDimensions
                                 fromImage:(UIImage*)image
{
    //output
    CGImageRef redrawnImage = NULL;
    //check if imageRect and dimension of image passed in are the same
    if (CGSizeEqualToSize(imageDimensions.size, image.size))
    {
        redrawnImage = [image CGImage];
    }
    else
    {
    
    /**
     *  get passed in image dimensions
     */
    __unused CGSize const imageSize = [image size];
    
    /**
     redraw the image using passed-in image dimensions
     */
    CGSize const sizeToBeDrawnTo =
    CGSizeMake(CGRectGetWidth(imageDimensions),
               CGRectGetHeight(imageDimensions));
    
    
    CGColorSpaceRef const colorSpace =
    CGColorSpaceCreateDeviceRGB();
    
    //create a cgimage as it needs to be scaled
//    CGBitmapContextCreate(void *data,
//                          size_t width,
//                          size_t height,
//                          size_t bitsPerComponent,
//                          size_t bytesPerRow,
//                          CGColorSpaceRef space,
//                          CGBitmapInfo bitmapInfo)
    CGContextRef const bitmapContext =
    CGBitmapContextCreate
    (NULL,
     (size_t)sizeToBeDrawnTo.width,
     (size_t)sizeToBeDrawnTo.height,
     (size_t)8,
     (size_t)0,
     colorSpace,
     (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRef const imageToBeDrawn = [image CGImage];
    CGContextDrawImage
    (bitmapContext,
     imageDimensions,
     imageToBeDrawn
     );
    
    //output
        CGImageRef drawnImage = nil;
        drawnImage=
    CGBitmapContextCreateImage(bitmapContext);
    
    //    UIImage* const decompressedImage =
    //    [UIImage imageWithCGImage:redrawnImage];
    
    CGContextRelease(bitmapContext);
        
        redrawnImage = //imageToBeDrawn;
        drawnImage;
        
        //CGImageRelease(drawnImage);
    }

    UIView* const imageView = [[UIView alloc] initWithFrame:imageDimensions];
    
    //get the view layer
    CALayer* const myLayer  = [imageView layer];
    myLayer.bounds          = [imageView bounds];
    myLayer.position        = CGPointMake
    ([imageView bounds].size.width/2,
     [imageView bounds].size.height/2
     );
    myLayer.backgroundColor = [[UIColor blueColor] CGColor];
    myLayer.contents        = (__bridge id)(redrawnImage);
    
   
    
    //create the shape layer
    CAShapeLayer* const shapeLayer = [CAShapeLayer layer];
    
    //create the circular path - use images size
    CGMutablePathRef const path = CGPathCreateMutable();
    CGPathAddArc
    (
     path,
     NULL,
     CGImageGetWidth(redrawnImage)/2,
     CGImageGetHeight(redrawnImage)/2,
     
     CGImageGetHeight(redrawnImage) >= CGImageGetWidth(redrawnImage) ?
     CGImageGetWidth(redrawnImage) /2 :
     CGImageGetHeight(redrawnImage) /2
     ,
     0.0f,
     (2 * M_PI),
     true);
    
    
    CGPathCloseSubpath(path);
    
    shapeLayer.path = path;
    
    CGPathRelease(path);
    
    //set the mask
    myLayer.mask = shapeLayer;
    
    
    //clear the views background
    [[imageView layer] setBackgroundColor:
     [[UIColor clearColor] CGColor]];
    
    
     CGImageRelease(redrawnImage);
    
    return imageView;
}



@end


@interface TrimInCircleView : UIView

@end

@implementation TrimInCircleView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    
    /**
     *  Image I/O
     */
    //create an image source
    
    NSURL* imageURL = nil;
    imageURL =
    [[NSBundle mainBundle] URLForResource:@"trial" withExtension:@"jpg"];
    
    CGImageSourceRef imageSource =
    CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, NULL);
    
   
    CFTypeRef keys[2] =
    {kCGImageSourceThumbnailMaxPixelSize,kCGImageSourceCreateThumbnailFromImageIfAbsent};
    
    
    //image dimensions
    CGFloat size =
    MAX(self.bounds.size.height, self.bounds.size.width);
    
    CFNumberRef sizeAsNumber =
    CFNumberCreate(NULL,
                   kCFNumberCGFloatType,
                   (const void *)&size);
    
    
    bool boolTrue = true;
    
    CFNumberRef boolTrueAsNumber = CFNumberCreate(NULL,
                                          kCFNumberCharType,
                                          (const void *)&boolTrue);
    
    CFTypeRef values[2] =
    {
     
        sizeAsNumber,boolTrueAsNumber
        
    };
    
    
    CFDictionaryRef optionDict =
    CFDictionaryCreate(NULL,
                       keys,
                       values,
                       2,
                       &kCFTypeDictionaryKeyCallBacks,
                       &kCFTypeDictionaryValueCallBacks);
    
    UIImage* scaledImageByImageIO =
    [UIImage imageWithCGImage:CGImageSourceCreateImageAtIndex(imageSource,
                                                              0,
                                                              optionDict)];
    
    
    
    
    
    
    UIImage* const image = [UIImage imageNamed:@"trial.jpg"];
    
    
    
    
    CGColorSpaceRef const colorSpace =
    CGColorSpaceCreateDeviceRGB();
    
    
    //UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
    
    CGContextRef const bitmapContext =
    CGBitmapContextCreate
    (NULL,
     [self bounds].size.width * [[UIScreen mainScreen] scale],
     [self bounds].size.height * [[UIScreen mainScreen] scale],
     8,
     0,
     colorSpace,
     (CGBitmapInfo)kCGImageAlphaNoneSkipLast);

    
    //UIGraphicsGetCurrentContext();
    
    
    CGContextSetInterpolationQuality(bitmapContext, kCGInterpolationHigh);
    
    CGColorSpaceRelease(colorSpace);
    
    
    CGContextSaveGState(bitmapContext);
    
    //FOR RETINA
    CGContextScaleCTM(bitmapContext, [[UIScreen mainScreen] scale], [[UIScreen mainScreen] scale]);
    
    CGContextDrawImage
    (bitmapContext,
     [self bounds],
     [image CGImage]);
    
    
    
    CGContextRestoreGState(bitmapContext);
    
    //output
    CGImageRef const redrawnImage =
    CGBitmapContextCreateImage(bitmapContext);
    
    UIImage* const decompressedImage =
    [UIImage imageWithCGImage:redrawnImage];
    
    CGImageRelease(redrawnImage);
    CGContextRelease(bitmapContext);
    
    //UIGraphicsEndImageContext();
    
    
    CGContextRef context = NULL;
    context = UIGraphicsGetCurrentContext();
    
    
    CGRect slicedBoundsRect = CGRectZero;
    slicedBoundsRect.origin.x = [self bounds].origin.x;
    slicedBoundsRect.origin.y = [self bounds].origin.y;
    slicedBoundsRect.size.width = [self bounds].size.width -10.0f;
    slicedBoundsRect.size.height = [self bounds].size.height -10.0f;
    
    slicedBoundsRect = CGRectInset([self bounds], 10.0f, 10.0f);
    
    /**
     *  image
     */
    CGContextSaveGState(context);
    
    //draw the image
    CGContextTranslateCTM(context, 0.0
                          , slicedBoundsRect.size.height+20);//to center it
    
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    
    //clip
    CGContextBeginPath(context);
    
    CGContextAddEllipseInRect(context, slicedBoundsRect);
    
    CGContextClip(context);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextDrawImage(context,
                       slicedBoundsRect,
                       [decompressedImage CGImage]
                       //[scaledImageByImageIO CGImage]
                       );
    
    
    
    CGContextRestoreGState(context);
    
    /**
     *  draw an ellipse around
     */

    CGContextSaveGState(context);
    
    CGContextBeginPath(context);

   //add a circle
    //CGContextAddEllipseInRect(context, [self bounds]);
    CGContextAddEllipseInRect(context, slicedBoundsRect);
    
    CGContextSetLineWidth(context, 10.0f);
    
    //white
    CGContextSetRGBStrokeColor(context,
                               1.0f,
                               1.0f,
                               1.0f,
                               1.0f);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
    
    
    
    //clip
//    CGContextSaveGState(context);
//    
//    CGContextBeginPath(context);
//    
//    CGContextAddEllipseInRect(context, slicedBoundsRect);
//    
//    CGContextClip(context);
//    
//    
//    CGContextRestoreGState(context);
    
}

@end

