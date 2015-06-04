//
//  DENavConTransitionDelegate.m
//  partLoadImage
//
//  Created by cts on 02/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "DENavConTransitionDelegate.h"
#import "DEAnimatedTransition.h"
#import "DEInteractiveTransitionDelegate.h"


@interface DENavConTransitionDelegate()



@end


@implementation DENavConTransitionDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC
{
    DEAnimatedTransition* presentAnimator = nil;
    presentAnimator =  [DEAnimatedTransition new];
 
    if (operation == UINavigationControllerOperationPop)
    {
        presentAnimator.reverse = YES;
    }
    
    return presentAnimator;

}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                        interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    

    return self.interactivePopTransition;
}

@end
