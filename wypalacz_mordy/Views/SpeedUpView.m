//
//  SpeedUpView.m
//  wypalacz_mordy
//
//  Created by Migdał on 8/28/13.
//  Copyright (c) 2013 Smulski&Cieciwa. All rights reserved.
//

#import "SpeedUpView.h"

@implementation SpeedUpView

+ (instancetype)create
{
    SpeedUpView *view = [SpeedUpView new];
    [view setup];
    return view;
}

+ (instancetype)createWithFrame:(CGRect)frame
{
    SpeedUpView *view = [self create];
    view.frame = frame;
    return view;
}

- (void)setup
{
    [self addGesture];
}

- (void)addGesture
{
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(speedGestureTapped:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)speedGestureTapped:(UIPanGestureRecognizer *)gesture
{
    static CGPoint lastLocation;
    static NSTimeInterval lastTimeCapture;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            lastLocation = [gesture locationInView:self];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentLocation = [gesture locationInView:self];
        
            NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
//            NSTimeInterval timeDiff = currentTime - lastTimeCapture;
            CGFloat distance = currentLocation.y - lastLocation.y;
            CGFloat scrollSpeedNotAbs = (distance * 10) / 1000; //in pixels per millisecond
            
            CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
            
            if (_delegate && [_delegate respondsToSelector:@selector(speedUpView:didSpeedUpWithSpeed:)])
                [_delegate speedUpView:self didSpeedUpWithSpeed:scrollSpeed];
            
            lastLocation = currentLocation;
            lastTimeCapture = currentTime;
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            
            break;
        }
        default:
            break;
    }
}

@end
