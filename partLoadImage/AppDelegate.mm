//
//  AppDelegate.m
//  partLoadImage
//
//  Created by cts on 20/03/15.
//  Copyright (c) 2015 asdasdsd. All rights reserved.
//

#import "AppDelegate.h"
#import "LayerTrialsVC.h"
#import "Dtraustrop.h"

/**
 *  BUILD COFIGURATIONS WWDC 2013 Optimize Your Code Using LLVM
 

 STEPS FOR OPTIMIZATION
 ----------------------
 
 1. Enable O3 - Optimization level for Release (default - Os)
 2. Enable Link Time Optimization (NO by default)
 3. Enforce Strict Aliasing -fstrict-aliasing (default - enabled)
 4. use 'restrict' to avoid redundant loads
 
 
XCODE > Build Setting > Apple LLVM 5.0 Code Generation 
 > Optimization level
 ---------------------
 Debug : None[-O0]                  -- fast compile time , debug info
 Release : Fastest,Smallest[-Os]    -- fastes code withou compramising on code size
 
 Change --
 Release : Fastest[-O3]  -- more code size
 , but fastest 
 
 
 -O0            - 1x normal
 -Os(Release)   - 3.08x
 -O3(Release)   - 3.42
 
 
 LInk -Time -Optimization
 ------------------------
 
 one source file at a time
 
 source Code File ----> LLVM Optimizer ----> object file ---> Linker -----> Executable
 
 
 LLVM'S Way - Whole Program at a time
 
 source Code File ----> LLVM Intermediate representation ----> object file --->( Linker + Optimization) -----> Executable
 
 -O0            - 1x normal
 -Os(Release)   - 3.08x
 -O3(Release)   - 3.42
 -O3 -flto      - 4.28
 
 
 LLVM Optimizations and CODE
 ----------------------------
 
 Pointer
 Aliasing
 .Can two pointers refer to the same underlying object?
 .Optimize memory references
    . Reorder load and stores
    . Remove redundant loads
    . Remove Dead Store
 
 -fstrict-aliasing -- Enable dby default from XCode 4.0
 
 
 //Different pointer types  cast  - no loading again as pointers are for different types
 void foo(float* a, float* b, int* c)
 {
    *a = *c;
    *b = *c;
 }
 
 ARM ASSEMBLY  
 
 r0 - 1st function pramater
 r1 - 2nd
 r2 - 3rd
 
 _foo:
    vldr s0,[r2]            // Load 'c' only once
    vcvt.f32.s32 do, do     // Convert to float
    vstr s0, [r0]           //Store result to 'a'
    vstr s0, [r1]           //Store result  to 'b'
    bx lr
 
 
 
 //Same pointer type
 //Type information isnt always enough
 
 void foo(int* a, int* b, int* c)
 {
 *a = *c;
 *b = *c;
 }
 
 ARM ASSEMBLY
 
 r0 - 1st function pramater
 r1 - 2nd
 r2 - 3rd
 
 _foo:
 ldr r3,[r2]            // Load 'c' only once
 str r3, [r0]           // store to 'a'
 ldr r0, [r2]           //load 'c' again
 str r0, [r1]           //Store result  to 'b'
 bx lr
 
 c is loaded again
 as compiler is  not sture if it has been changed by pointer 'a'
 
 redundant load
 .Can be stoped by "restrict" keyword
        -- tells compiler that no other pointer will alias this
 .Object can't be aliased in its scope
 
 
 void foo(int* a, int* b, int* restrict c)
 {
 *a = *c;
 *b = *c;
 }
 
 ARM ASSEMBLY
 
 r0 - 1st function pramater
 r1 - 2nd
 r2 - 3rd
 
 _foo:
 ldr r3,[r2]            // Load 'c' only once
 str r3, [r0]           // store to 'a'
 str r0, [r1]           //Store result  to 'b'
 bx lr
 
 
 
 FLOATING POINT MATH
 -Representation challenges
 
 . -0.0 vs 0.0 - both are distinct numbers
 . NaN      - Not a Number
 
 - Reassociation
    (a+b) + c may not equal; a+(b+c)
 
 
 
 Relax IEEE Compliance  ie ffast-math
 
 
 Vectorization
 
 OSX 
    SSE , SSE2, SSE3, SSE4
    AVX, AVX2
 iOS 
    NEON
 
 
 Vectorization LLVM -- target independent vector instruction
 
 
 


//adds 4 elements ffrom an array at a time
typedef __attribute__((ext_vector_type(4))) int int4;

void do_mul_add(int4* a,int4* b, int4* c, int4* out_)
{
    *out_ = (*a * *b) + *c;
}


Auto-Vectorization LLVM
 XCODE 5
 Optimises loop
 
 More for gaming/image processing 
 
 
*/

@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    mainCall();
    
    
    self.window =
    [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //tint
    //[[self window] setTintColor:[UIColor redColor]];
    
    LayerTrialsVC* rootVc = nil;
    rootVc = [[LayerTrialsVC alloc]init];
    
    UINavigationController* navCon = nil;
    navCon = [[UINavigationController alloc] initWithRootViewController:rootVc];
    
    self.window.rootViewController = navCon;
    
    [[self window]makeKeyAndVisible];
    
    
   
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
