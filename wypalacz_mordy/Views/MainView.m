//
//  MainView.m
//  wypalacz_mordy
//
//  Created by Radosław Cięciwa on 01.09.2013.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import "MainView.h"

#import "SpeedUpView.h"

@implementation MainView

- (void)setupSpeedView
{
    float width = 80.0;
    float top = 20.0;
    CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - width - 10.0, top,
                              width, CGRectGetHeight(self.frame) - 2*top);
    self.speedUpView = [SpeedUpView createWithFrame:frame];
    self.speedUpView.backgroundColor = [UIColor blueColor];
    self.speedUpView.userInteractionEnabled = YES;
    [self addSubview:self.speedUpView];
}

@end
