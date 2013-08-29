//
//  BaseController.h
//  TUI
//
//  Created by Softhis on 04.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewDelegate.h"

@protocol BaseControllerDelegate;

@interface BaseController : UIViewController <BaseViewDelegate>
{
    id<BaseControllerDelegate> _delegate;
}

@property(nonatomic) id<BaseControllerDelegate> delegate;

@end

@protocol BaseControllerDelegate <NSObject>

- (void)viewDidLoad;

@end
