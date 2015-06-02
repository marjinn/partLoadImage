//
//  DETransitioningDelegate.m
//  partLoadImage
//
//  Created by cts on 01/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "DETransitioningDelegate.h"
#import "DEAnimatedTransition.h"

@implementation DETransitioningDelegate


/**
 *  animator object for presentation transition
 */
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source
{
    DEAnimatedTransition* presentAnimator = nil;
    presentAnimator =  [DEAnimatedTransition new];
    
    return presentAnimator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DEAnimatedTransition* presentAnimator = nil;
    presentAnimator =  [DEAnimatedTransition new];
    presentAnimator.reverse  = YES;
    
    return presentAnimator;
}

@end
