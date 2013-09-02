//
//  MainController.m
//  wypalacz_mordy
//
//  Created by Radosław Cięciwa on 01.09.2013.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import "MainController.h"

#import <QuartzCore/QuartzCore.h>

#import "MainView.h"

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MainView *mainView = (MainView *) self.view;
//    [mainView setupSpeedView];
//    mainView.speedUpView.delegate = self;
    mainView.scrollView.dataSource = self;
    [mainView.scrollView setupWithLooping:YES];
}

#pragma RCInfiniteSmoothScrollView
- (int)numberOfObjectsToLoop
{
    return 16;
}

- (UIView *)smoothViewForIndex:(int)viewIndex withReusableView:(UIView *)convertView
{
    UILabel *label = (UILabel *)convertView;
    
    if (label == nil)
    {
        label = [[UILabel alloc] initWithFrame:(CGRect){{0,0}, {80, 80}}];
        label.layer.borderWidth = 2.0f;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.cornerRadius = 2.0f;
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    label.text = [NSString stringWithFormat:@"%d", viewIndex];
    return label;
}

- (CGSize)sizeOfSmoothViewElement
{
    return CGSizeMake(80, 80);
}

#pragma mark - SPEEDUPVIEW
- (void)speedUpView:(SpeedUpView *)speedUpView didSpeedUpWithSpeed:(float)speed
{
    NSLog(@"current speed %f", speed);
}

@end
