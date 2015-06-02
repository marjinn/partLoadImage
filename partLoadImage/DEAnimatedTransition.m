//
//  DEAnimatedTransition.m
//  partLoadImage
//
//  Created by cts on 01/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "DEAnimatedTransition.h"
static NSTimeInterval const DEAnimatedTransitionDuration = 0.5f;
static NSTimeInterval const DEAnimatedTransitionMarcoDuration = 0.15f;
@implementation DEAnimatedTransition

#pragma mark UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DEAnimatedTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
//    //get from VC
//    UIViewController* fromVC = nil;
//    fromVC =
//    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
//    UIViewController* toVC = nil;
//    toVC =
//    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    //get the contianer view
//    UIView* containerView = nil;
//    containerView =  [transitionContext containerView];
    
//    if (self.reverse)
//    {
//        //push from-view down
//        fromVC.view.frame =
//        CGRectMake(toVC.view.frame.origin.x,
//                   toVC.view.frame.origin.y + CGRectGetHeight(toVC.view.frame),
//                   CGRectGetWidth(toVC.view.frame),
//                   CGRectGetHeight(toVC.view.frame));
//    }
//    else
//    {
//        //push to-view down
//        toVC.view.frame =
//        CGRectMake(toVC.view.frame.origin.x,
//                   toVC.view.frame.origin.y + CGRectGetHeight(toVC.view.frame),
//                   CGRectGetWidth(toVC.view.frame),
//                   CGRectGetHeight(toVC.view.frame));
//    }
//    
    
//    /**
//     *  the  animation
//     */
//    if (self.reverse)
//    {
//        //[containerView insertSubview:toVC.view belowSubview:fromVC.view];
//        fromVC.view.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
//        [containerView addSubview:fromVC.view];
//        
//    }
//    else
//    {
//        toVC.view.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
//        
//        [containerView addSubview:toVC.view];
//    }
//    
//    [UIView animateKeyframesWithDuration:DEAnimatedTransitionDuration
//                                   delay:0.0f
//                                 options:0
//                              animations:^{
//                                  
//                                  if (self.reverse)
//                                  {
//                                      fromVC.view.transform =
//                                      CGAffineTransformMakeScale(0.0f, 0.0f);
//                                  }
//                                  else
//                                  {
//                                      toVC.view.transform =
//                                      CGAffineTransformIdentity;
//                                  }
//                                  
//                                  
//                              } completion:^(BOOL finished) {
//                                  
//                                  if (finished)
//                                  {
//                                      /**
//                                       *  pass the message to context 
//                                       */
//                                      [transitionContext completeTransition:finished];
//                                  }
//                                  
//                              }];
    
    
//    [UIView animateWithDuration:DEAnimatedTransitionDuration
//                          delay:0.0f
//         usingSpringWithDamping:0.8f
//          initialSpringVelocity:0.0f
//                        options:0
//                     animations:
//     ^{
//         
//         if ([self reverse])
//         {
//             //fromVC.view.transform =  CGAffineTransformMakeRotation(M_PI_2);
//             
//             
//             //fromVC.view.backgroundColor = [UIColor redColor];
//             
//             
//             fromVC.view.frame =
//             CGRectMake(toVC.view.frame.origin.x,
//                        toVC.view.frame.origin.y + CGRectGetHeight(toVC.view.bounds) ,
//                        CGRectGetWidth(toVC.view.frame),
//                        CGRectGetHeight(toVC.view.frame));
//             
//             
//             
//             
//             [fromVC.view removeFromSuperview];
//         }
//         else
//         {
//             //toVC.view.transform =  CGAffineTransformMakeRotation(M_PI_2);
//    
//             toVC.view.frame =
//             CGRectMake(toVC.view.frame.origin.x,
//                        toVC.view.frame.origin.y - CGRectGetHeight(toVC.view.frame),
//                        CGRectGetWidth(toVC.view.frame),
//                        CGRectGetHeight(toVC.view.frame));
//            
//             [containerView addSubview:toVC.view];
//             
//             
//         }
//         
//                         
//                     } completion:^(BOOL finished)
//    {
//        /**
//                                                *  pass the message to context
//                                                */
//        
//        [transitionContext completeTransition:finished];
//    }];
 
    
    
    
//    [UIView animateWithDuration:DEAnimatedTransitionDuration
//                     animations:^{
//                        
//                         if (self.reverse)
//                         {
//                             [fromVC.view removeFromSuperview];
//                             [containerView addSubview:toVC.view];
//                         }
//                         else
//                         {
//                             [fromVC.view removeFromSuperview];
//                             [containerView addSubview:toVC.view];
//                         }
//                         
//                         
//                     } completion:^(BOOL finished)
//    {
//                         [transitionContext completeTransition:finished];
//                     }];
    
    UIViewController* source =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController* destination =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* container = transitionContext.containerView;
    
    // Take destination view snapshot
    UIView* destinationSS =
    [destination.view snapshotViewAfterScreenUpdates:YES]; // YES because the view hasn't been rendered yet.
    
    // Add snapshot view
    [container addSubview:destinationSS];
    
    // Move destination snapshot back in Z plane
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1.0 / -1000.0;
    perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, -100);
    destinationSS.layer.transform = perspectiveTransform;
    
    // Start appearance transition for source controller
    // Because UIKit does not remove views from hierarchy when transition finished
    [source beginAppearanceTransition:NO animated:YES];
    
    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            CGRect sourceRect = source.view.frame;
            sourceRect.origin.y = CGRectGetHeight([[UIScreen mainScreen] bounds]);
            source.view.frame = sourceRect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.8 animations:^{
            destinationSS.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        // Remove destination snapshot
        [destinationSS removeFromSuperview];
        
        // Add destination controller to view
        [container addSubview:destination.view];
        
        // Finish transition
        [transitionContext completeTransition:finished];
        
        // End appearance transition for source controller
        [source endAppearanceTransition];
    }];
}

/**
 *  Tells your animator object that the transition animations have finished.
 */

-(void)animationEnded:(BOOL)transitionCompleted
{
    
}

#pragma mark AnimationDelegates

-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

@end
