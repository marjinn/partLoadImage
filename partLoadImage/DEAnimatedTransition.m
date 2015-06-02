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


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DEAnimatedTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //get from VC
    UIViewController* fromVC = nil;
    fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController* toVC = nil;
    toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //get the contianer view
    UIView* containerView = nil;
    containerView =  [transitionContext containerView];
    
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
 
    
    
    
    [UIView animateWithDuration:DEAnimatedTransitionDuration
                     animations:^{
                        
                         if (self.reverse)
                         {
                             [fromVC.view removeFromSuperview];
                         }
                         else
                         {
                             [containerView addSubview:toVC.view];
                         }
                         
                         
                     } completion:^(BOOL finished)
    {
                         [transitionContext completeTransition:finished];
                     }];
    
    
}

-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

/**
 *  Tells your animator object that the transition animations have finished.
 */

-(void)animationEnded:(BOOL)transitionCompleted
{
    
}

@end
