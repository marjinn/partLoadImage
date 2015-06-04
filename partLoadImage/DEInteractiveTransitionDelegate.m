//
//  DEInteractiveTransition.m
//  partLoadImage
//
//  Created by cts on 03/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "DEInteractiveTransitionDelegate.h"
#import "PercentDrivenTransition.h"
#import "DEAnimatedTransition.h"

@implementation DEInteractiveTransitionDelegate

#pragma mark UIViewControllerInteractiveTransitioning

//-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    
//}
//
//-(CGFloat)completionSpeed
//{
//    return 1.0f;
//}
//
//-(UIViewAnimationCurve)completionCurve
//{
//    return UIViewAnimationCurveEaseInOut;
//}


#pragma mark UIViewControllerTransitioningDelegate
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

//FOR INTERACTIVE ANIMATED TRANSITION

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    //PercentDrivenTransition* percentTrans = [PercentDrivenTransition new];
    
    return self.interactivePopTransition;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    //PercentDrivenTransition* percentTrans = [PercentDrivenTransition new];
    
    return self.interactivePopTransition;
}

@end
