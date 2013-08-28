//
//  SpeedUpView.h
//  wypalacz_mordy
//
//  Created by Migdał on 8/28/13.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpeedUpView;

@protocol SpeedUpViewDelegate <NSObject>
@optional
- (void)speedUpViewDidStart:(SpeedUpView *)view;

@end

@interface SpeedUpView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic) id<SpeedUpViewDelegate> delegate;

+ (instancetype)createWithFrame:(CGRect)frame;

@end
