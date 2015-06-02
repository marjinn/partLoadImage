//
//  ToPresentViewController.m
//  partLoadImage
//
//  Created by cts on 01/06/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "ToPresentViewController.h"

@interface ToPresentViewController ()

@end

@implementation ToPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
                                 
                                 [[[NSThread mainThread] threadDictionary] removeObjectForKey:@"ToPresentViewController"];
         
     }];
}

-(void)dealloc
{
    
}

@end
