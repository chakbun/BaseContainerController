//
//  JRBaseContainerController.m
//  ObjcPropertyDemo
//
//  Created by Jaben on 15/7/25.
//  Copyright (c) 2015年 xpg. All rights reserved.
//

#import "JRBaseContainerController.h"

@implementation JRBaseContainerController

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for(UIViewController *controller in viewControllers) {
        [controller beginAppearanceTransition:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for(UIViewController *controller in viewControllers) {
        [controller endAppearanceTransition];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for(UIViewController *controller in viewControllers) {
        [controller beginAppearanceTransition:NO animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSArray *viewControllers = [self childViewControllersWithAppearanceCallbackAutoForward];
    for(UIViewController *controller in viewControllers) {
        [controller endAppearanceTransition];
    }
}

#pragma mark -
#pragma mark 下面两个方法是在需要的情况下给基类覆盖用的，毕竟不是所有的容器都需要将相关方法传递给所有的childViewControllers
- (NSArray *)childViewControllersWithAppearanceCallbackAutoForward{
    return self.childViewControllers;
}

- (NSArray *)childViewControllersWithRotationCallbackAutoForward{
    return self.childViewControllers;
}

#pragma mark - Rotate

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (BOOL)shouldAutorotate {
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    BOOL shouldAutorotate = YES;
    for (UIViewController *viewController in viewControllers) {
        shouldAutorotate = shouldAutorotate &&  [viewController shouldAutorotate];
    }
    
    return shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations {
    NSUInteger supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    
    NSArray *viewControllers = [self childViewControllersWithRotationCallbackAutoForward];
    for (UIViewController *viewController in viewControllers) {
        supportedInterfaceOrientations = supportedInterfaceOrientations & [viewController supportedInterfaceOrientations];
    }
    
    return supportedInterfaceOrientations;
}

@end
