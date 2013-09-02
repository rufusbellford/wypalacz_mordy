//
//  MainView.h
//  wypalacz_mordy
//
//  Created by Radosław Cięciwa on 01.09.2013.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import "BaseView.h"

@class RCInfiniteSmoothScrollView;
@class SpeedUpView;

@interface MainView : BaseView

@property(nonatomic) SpeedUpView *speedUpView;
@property(nonatomic) IBOutlet RCInfiniteSmoothScrollView *scrollView;

- (void)setupSpeedView;

@end
