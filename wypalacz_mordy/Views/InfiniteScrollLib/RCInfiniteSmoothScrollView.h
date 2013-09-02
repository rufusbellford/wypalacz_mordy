//
//  RCInfiniteSmoothScrollView.h
//  TUI
//
//  Created by Softhis on 09.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef UIView *(^smoothViewForIndex)(int index, UIView *convertView);

typedef enum
{
    ScrollDirectionLeft,
    ScrollDirectionRight
} ScrollDirection;

@protocol RCInfiniteSmoothScrollViewDataSource <NSObject>

@required
- (int)numberOfObjectsToLoop;
- (UIView *)smoothViewForIndex:(int)viewIndex withReusableView:(UIView *)convertView;
- (CGSize)sizeOfSmoothViewElement;

@end

// Normally view should be tagged as dataSource indexes.
// Functions such as delete item, depends on tags.
// They should be tagged properly, but remember tagging is performed.
// outside of this class, in:
// - smoothViewForIndex:
// - smoothViewForIndex: withConvertView:
// delegate methods.
@interface RCInfiniteSmoothScrollView : UIScrollView
{
    NSMutableArray *listOfViews;
    CGFloat centerOffsetX;
    int viewsCountPerScreen;
    BOOL isAnimating;
    BOOL shouldLoopContent;
}

//@property(nonatomic, copy) smoothViewForIndex blockDataSource;
@property(nonatomic, weak) id<RCInfiniteSmoothScrollViewDataSource> dataSource;

- (void)setup;
- (void)setupWithLooping:(BOOL)shouldLooping;
- (NSMutableArray *)listOfViews;
- (void)deleteViewWithTag:(int)viewTag;
- (void)showViewWithTag:(int)viewTag animated:(BOOL)animated;
- (void)adjustToOrientation:(UIDeviceOrientation)orientation;

@end
