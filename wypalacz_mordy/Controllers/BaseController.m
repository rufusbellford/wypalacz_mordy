//
//  BaseController.m
//  TUI
//
//  Created by Softhis on 04.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import "BaseController.h"

#import "BaseView.h"

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = (BaseView *) self.view;
    ((BaseView *) self.view).delegate = self;
    [self.delegate viewDidLoad];
}

#pragma mark BaseViewDelegate
- (UIViewController *)controller
{
    return self;
}

@end
