//
//  DEInteractiveTransition.h
//  partLoadImage
//
//  Created by cts on 03/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface DEInteractiveTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end
