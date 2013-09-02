//
//  UIView+CGSize.m
//  MyNight
//
//  Created by Migdał on 4/11/13.
//  Copyright (c) 2013 MyNight. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (void)setOrigin:(CGPoint)aOrigin
{
    CGRect frame = self.frame;
    frame.origin = aOrigin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setSizeAroundCenter:(CGSize)size
{
    CGPoint center = self.center;
    [self setSize:size];
    self.center = center;
}

- (void)adjustCenter:(CGPoint (^)(float x, float y))block
{
    CGPoint center = block(self.center.x, self.center.y);
    self.center = center;
}

- (CGRect)frameWithoutStatusBarAndNaviagationBar
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 20.0 + 44.0;
    return frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect tmpFrame = self.frame;
    tmpFrame.size.height = height;
    self.frame = tmpFrame;
}

- (void)setYOrigin:(CGFloat)originY
{
    CGRect tmpFrame = self.frame;
    tmpFrame.origin.y = originY;
    self.frame = tmpFrame;
}

@end
