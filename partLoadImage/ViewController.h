//
//  ViewController.h
//  partLoadImage
//
//  Created by cts on 20/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,weak) IBOutlet UIImageView* imageView;



///OBJC C NULLABILITY AND GENERICS
@property(nonnull)NSString* k;//never nil --default
@property(nullable,strong)NSString* nee; //can be nil
@property(null_resettable)NSString* p; // never retunrs "nil", but can be set to "nil"
@property(null_unspecified)NSString* un; // not specified


//Can be used to specify to wrap header files
NS_ASSUME_NONNULL_BEGIN
NS_ASSUME_NONNULL_END



@property(nonnull,copy)NSArray<NSString*>* arrayOFStrings;
@property(nonnull,copy)NSDictionary<NSString*,id>* dictionaryOFStringsAndId;




///kindof
@property(nonnull,copy)NSArray<__kindof UIView* >* subviews;
/*
 if we assign the values from the "subviews array which are declared 
 specifically to be type "UIView"
 UIButton* button = myContainerView.subviews[0]
 --we get a compiler warning
 
 --__kindof means subclasses can also access the contents of the array
 
 */

@end

