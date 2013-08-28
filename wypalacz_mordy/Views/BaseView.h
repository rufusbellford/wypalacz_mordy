//
//  BaseView.h
//  TUI
//
//  Created by Softhis on 04.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"

@protocol BaseViewDelegate;

@interface BaseView : UIView <BaseControllerDelegate>
{
    id<BaseViewDelegate> delegate;
}

@property(nonatomic) id<BaseViewDelegate> delegate;

@end

@protocol BaseViewDelegate <NSObject>

- (UIViewController *)controller;

@end