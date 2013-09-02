//
//  UIView+CGSize.h
//  MyNight
//
//  Created by Migdał on 4/11/13.
//  Copyright (c) 2013 MyNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

- (void)setOrigin:(CGPoint)aOrigin;
- (void)setSize:(CGSize)size;
- (void)setSizeAroundCenter:(CGSize)size;
- (void)adjustCenter:(CGPoint (^)(float x, float y))block;
- (CGRect)frameWithoutStatusBarAndNaviagationBar;
- (void)setHeight:(CGFloat)height;
- (void)setYOrigin:(CGFloat)originY;

@end
