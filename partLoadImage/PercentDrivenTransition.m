//
//  PercentDrivenTransition.m
//  partLoadImage
//
//  Created by cts on 03/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "PercentDrivenTransition.h"

@interface PercentDrivenTransition()

@property BOOL interactive;
@property CGFloat startScale;
@property (nonatomic,strong)UINavigationController* parent;

@end


@implementation PercentDrivenTransition

-(void)handlePinch:(UIPinchGestureRecognizer*)gr
{
    CGFloat scale = [gr scale];
    
    switch ([gr state])
    {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            _startScale = scale;
            
            [[self parent] popViewControllerAnimated:YES];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percent = (1.0 - scale/_startScale);
            
            [self updateInteractiveTransition:
             (percent <= 0.0) ? 0.0 : percent
             ];
            break;
        }
            
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
        {
            if ([gr velocity] >= 0.0 || [gr state] == UIGestureRecognizerStateCancelled)
            {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
            
            [self setInteractive:NO];
            
            break;
        }
            
        default:
            break;
    }
}

@end
