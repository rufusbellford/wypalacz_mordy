//
//  BaseView.h
//  TUI
//
//  Created by Softhis on 04.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseController.h"

@interface BaseView : UIView <BaseControllerDelegate>
{
//    id<BaseViewDelegate> _delegate;
}

@property(nonatomic) id<BaseViewDelegate> delegate;

@end