//
//  DEAnimatedTransition.h
//  partLoadImage
//
//  Created by cts on 01/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


/**
 *  CLass that implments the animation--- aka the naimator object
 */


@interface DEAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property BOOL reverse;
@end
