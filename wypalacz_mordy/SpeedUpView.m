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
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(swipeGestureTapped:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeGesture];
}

- (void)swipeGestureTapped:(UISwipeGestureRecognizer *)gesture
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
//            float offsetDeltaY = currentLocation.y - lastLocation.y;
            
            NSTimeInterval timeDiff = currentTime - lastTimeCapture;
            if (timeDiff > 0.1)
            {
                CGFloat distance = currentLocation.y - lastLocation.y;
                CGFloat scrollSpeedNotAbs = (distance * 10) / 1000; //in pixels per millisecond
                
                CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
                NSLog(@"speed %f", scrollSpeed);
//                if ((scrollSpeed > 0.5 && scrollSpeed < 2.0) || currentLocation.y == 0 || offsetDeltaY < 0.0)
//                {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"list:scroll:did:scroll"
//                                                                        object:@(offsetDeltaY)];
//                }
                
                lastLocation = currentLocation;
                lastTimeCapture = currentTime;
            }
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
