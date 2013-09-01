//
//  MainController.m
//  wypalacz_mordy
//
//  Created by Radosław Cięciwa on 01.09.2013.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import "MainController.h"

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSpeedUpView];
}

- (void)addSpeedUpView
{
    float width = 80.0;
    float top = 20.0;
    CGRect frame = CGRectMake(CGRectGetWidth(self.view.frame) - width - 10.0, top,
                              width, CGRectGetHeight(self.view.frame) - 2*top);
    SpeedUpView *view = [SpeedUpView createWithFrame:frame];
    view.backgroundColor = [UIColor blueColor];
    view.delegate = self;
    view.userInteractionEnabled = YES;
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - SPEEDUPVIEW

- (void)speedUpView:(SpeedUpView *)speedUpView didSpeedUpWithSpeed:(float)speed
{
    NSLog(@"current speed %f", speed);
}

@end
