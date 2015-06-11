//
//  ToPresentViewController.m
//  partLoadImage
//
//  Created by cts on 01/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "ToPresentViewController.h"

@interface ToPresentViewController ()
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property(nonatomic,strong,readonly) UIScreenEdgePanGestureRecognizer* screenEdgePanGestureRecognizer;


@property(nonatomic,weak,readwrite)IBOutlet UIImageView* wtvrV;

@end

@implementation ToPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIImage* const image =
    [[UIImage imageNamed:@"trial.jpg"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    
    NSString* url =
    @"http://upload.wikimedia.org/wikipedia/commons/c/ca/Triple-Spiral-4turns_green_transparent.png";
    
    NSData* data = nil;
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    UIImage* imageFromWeb = nil;
    imageFromWeb = [UIImage imageWithData:data scale:1.0f];
    
    
    
    [[self wtvrV] setImage:image];
    
    [[self wtvrV] setImage:[imageFromWeb imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    
    /**
     *  adding gesture recognizer
     */
    UIScreenEdgePanGestureRecognizer* tmp = nil;
    tmp =
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handlePopRecognizer:)];
    
    self->_screenEdgePanGestureRecognizer = tmp;
    self->_screenEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    
    [[self view] addGestureRecognizer:tmp];
}

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGPoint  touchedHere =
    [recognizer translationInView:[self view]];
    
    CGFloat progress =
    touchedHere.x / ([[self view] bounds].size.width * 1.0f) ;
    
    progress = MIN(1.0f, MAX(0.0f, progress));
    
    switch ([recognizer state])
    {
        case UIGestureRecognizerStateBegan:
        {
            [[self navigationController] popViewControllerAnimated:YES];
           break;
        }
        case UIGestureRecognizerStateChanged:
        {
            //update transition progres
            [[self interactivePopTransition]
             updateInteractiveTransition:progress];
            break;
        }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
        {
            
            if (progress > 0.5)
            {
                [[self interactivePopTransition] finishInteractiveTransition];
            }
            else
            {
                [[self interactivePopTransition] cancelInteractiveTransition];
            }
            
            break;
        }
            
            
        default:
            break;
    }
    
    [self setInteractivePopTransition:nil];
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


-(IBAction)dismiss:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES
                             completion:
     ^{
                                 NSLog(@"dismissed : %@",self);
                                 
                                 //[[[NSThread mainThread] threadDictionary] removeObjectForKey:@"ToPresentViewController"];
         
     }];
}

-(void)dealloc
{
    
}

@end
