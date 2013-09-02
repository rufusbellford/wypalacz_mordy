//
//  RCInfiniteSmoothScrollView.m
//  TUI
//
//  Created by Softhis on 09.01.2013.
//  Copyright (c) 2013 Softhis. All rights reserved.
//

#import "RCInfiniteSmoothScrollView.h"

#import "UIView+Layout.h"

#define BUFFER_ELEMENTS 1

@implementation RCInfiniteSmoothScrollView

@synthesize dataSource;

- (void)setup
{
    [self setupWithLooping:YES];
}

- (void)setupWithLooping:(BOOL)shouldLooping
{
    [self setShowsHorizontalScrollIndicator:YES];
    
    viewWidth = [self.dataSource sizeOfSmoothViewElement].width;
    
    if(!shouldLooping)
    {
        [self setupWithoutLooping];
    }
    else
    {
        viewsCountPerScreen = self.frame.size.width / viewWidth;
        int numberOfObjectsToLoop = [self.dataSource numberOfObjectsToLoop];
        
        if(viewsCountPerScreen >= numberOfObjectsToLoop)
        {
            [self setupWithoutLooping];
        }
        else
        {
            [self setupWithLooping];
        }
    }
}

#pragma mark - ORIENTATION
- (void)adjustToOrientation:(UIDeviceOrientation)orientation
{
    viewWidth = [self.dataSource sizeOfSmoothViewElement].width;
    viewsCountPerScreen = CGRectGetWidth(self.frame) / viewWidth;
    int numberOfObjectsToLoop = listOfViews.count;
    
    if(numberOfObjectsToLoop <= viewsCountPerScreen)
    {
        int offsetFromLeft = (viewsCountPerScreen - numberOfObjectsToLoop) * ((float)viewWidth/2.0);
        
        for (int i = 0 ; i < numberOfObjectsToLoop ; i++)
        {
            UIView *view = [listOfViews objectAtIndex:i];
            [view setOrigin:CGPointMake(offsetFromLeft, 0)];
            offsetFromLeft += viewWidth;
        }
    }
}

- (void)setupWithLooping
{
    shouldLoopContent = YES;
    viewWidth = [self.dataSource sizeOfSmoothViewElement].width;
    viewsCountPerScreen = self.frame.size.width / viewWidth;
    int numberOfObjectsToLoop = [self.dataSource numberOfObjectsToLoop];
    
    int totalViewsCount = viewsCountPerScreen + (2 * BUFFER_ELEMENTS);
    viewIndexes = (int *)malloc(totalViewsCount * sizeof(int));
    listOfViews = [[NSMutableArray alloc] initWithCapacity:totalViewsCount];
    self.contentSize = CGSizeMake(totalViewsCount * viewWidth, self.frame.size.height);
//    int offsetToCenter = (self.contentSize.width / 2.0f) - (self.frame.size.width / 2.0f);
    
    for (int i = 0 ; i < totalViewsCount ; i++)
    {
        int viewIndex = [self mod:i andB:numberOfObjectsToLoop];
        UIView *view = [self.dataSource smoothViewForIndex:viewIndex withReusableView:nil];
        [self addSubview:view];
//        int offsetX = [self mod:((i * viewWidth) + offsetToCenter) andB:self.contentSize.width];
        int offsetX = (i * viewWidth);
        [self moveView:view toXYOrigins:CGPointMake(offsetX, 0)];
        [listOfViews addObject:view];
        viewIndexes[i] = i;
    }
    
    centerOffsetX = (self.contentSize.width - self.bounds.size.width) / 2.0;
    self.contentOffset = CGPointMake(centerOffsetX, 0);
}

- (void)setupWithoutLooping
{
    shouldLoopContent = NO;
    viewsCountPerScreen = CGRectGetWidth(self.frame) / viewWidth;
    int numberOfObjectsToLoop = [self.dataSource numberOfObjectsToLoop];
    listOfViews = [[NSMutableArray alloc] initWithCapacity:numberOfObjectsToLoop];
    int offsetFromLeft;
    
    if(numberOfObjectsToLoop >= viewsCountPerScreen) {
        offsetFromLeft = 0;
    }
    else {
        offsetFromLeft = (viewsCountPerScreen - numberOfObjectsToLoop) * ((float)viewWidth/2.0);
    }
    
    self.contentSize = CGSizeMake(numberOfObjectsToLoop * viewWidth, self.frame.size.height);
    self.scrollEnabled = YES;
    self.contentOffset = CGPointMake(0, 0);
    
    for (int i = 0 ; i < numberOfObjectsToLoop ; i++)
    {
        UIView *view = [self.dataSource smoothViewForIndex:i withReusableView:nil];
        [self addSubview:view];
        [view setOrigin:CGPointMake(offsetFromLeft, 0)];
        [listOfViews addObject:view];
        offsetFromLeft += viewWidth;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (shouldLoopContent) {
        [self recenterIfNecessary];
    }
}

- (void)recenterIfNecessary
{
    CGPoint _currentOffset = self.contentOffset;

    if (_currentOffset.x < (viewWidth / 2.0))
    {
        [self moveContentWhileScrollInDirection:ScrollDirectionLeft forViewCount:BUFFER_ELEMENTS];
    }
    else if (_currentOffset.x + self.bounds.size.width > ((listOfViews.count - 0.5) * viewWidth))
    {
        [self moveContentWhileScrollInDirection:ScrollDirectionRight forViewCount:BUFFER_ELEMENTS];
    }
    
//    if(distanceFromCenter > self.frame.size.width / 2.0f)
//    {
//        if(self.scrollEnabled && !isAnimating)
//        {
//            if(_currentOffset.x < _centerOffsetX) {
//                [self recenterInDirection:ScrollDirectionLeft];
//            }
//            else {
//                [self recenterInDirection:ScrollDirectionRight];
//            }
//        }
//    }
}

// This logic is inverse if scroll is to left then move content to right
- (void)moveContentWhileScrollInDirection:(ScrollDirection)scrollDirection forViewCount:(int)viewCount
{
    float offsetDX = viewCount * viewWidth;
    
    if (scrollDirection == ScrollDirectionRight) {
        offsetDX *= -1;
    }
    
    CGPoint currentOffset = self.contentOffset;
    self.contentOffset = (CGPoint){currentOffset.x + offsetDX, currentOffset.y};
    
    for (int i = 0 ; i < listOfViews.count; i++)
    {
        int indexOfViewInList = viewIndexes[i];
//        UIView *view = [listOfViews objectAtIndex:indexOfViewInList];
    }
    
    // TODO: Move view and reindex in table!
}

//- (void)layoutWhileScrollInDirection:(ScrollDirection)direction
//{
//    int elementsCount = [self.dataSource numberOfObjectsToLoop];
//    int lastViewIndex = listOfViews.count;
//    int movingElements = [self countAndReindexElements:direction];
//    
//    if(direction == ScrollDirectionRight)
//    {
//        for (int i = lastViewIndex - movingElements ; i < listOfViews.count ; i++)
//        {
//            UIView *view = [listOfViews objectAtIndex:i];
//            int nextIndex = [self mod:(view.tag + listOfViews.count) andB:elementsCount];
//            [listOfViews replaceObjectAtIndex:i withObject:[self.dataSource smoothViewForIndex:nextIndex withReusableView:view]];
//        }
//    }
//    else
//    {
//        for (int i = movingElements - 1; i >= 0 ; i--)
//        {
//            UIView *view = [listOfViews objectAtIndex:i];
//            int nextIndex = [self mod:(view.tag - listOfViews.count) andB:elementsCount];
//            [listOfViews replaceObjectAtIndex:i withObject:[self.dataSource smoothViewForIndex:nextIndex withReusableView:view]];
//        }
//    }
//}
//
//- (int)countAndReindexElements:(ScrollDirection)direction
//{
//    NSArray *tmpArray;
//    int movingElements = viewsCountPerScreen / 2;
//    
//    NSIndexSet *leftBorderElementsIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, movingElements)];
//    NSIndexSet *rightBorderElementsIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([listOfViews count] - movingElements, movingElements)];
//    
//    if(direction == ScrollDirectionRight)
//    {
//        tmpArray = [NSArray arrayWithArray:[listOfViews objectsAtIndexes:leftBorderElementsIndexSet]];
//        [listOfViews removeObjectsAtIndexes:leftBorderElementsIndexSet];
//        [listOfViews insertObjects:tmpArray atIndexes:rightBorderElementsIndexSet];
//    }
//    else
//    {
//        tmpArray = [NSArray arrayWithArray:[listOfViews objectsAtIndexes:rightBorderElementsIndexSet]];
//        [listOfViews removeObjectsAtIndexes:rightBorderElementsIndexSet];
//        [listOfViews insertObjects:tmpArray atIndexes:leftBorderElementsIndexSet];
//    }
//    
//    for (int i = 0 ; i < listOfViews.count ; i++)
//    {
//        UIView *view = [listOfViews objectAtIndex:i];
//        [self moveView:view toXYOrigins:CGPointMake(i * viewWidth, 0)];
//    }
//    
//    tmpArray = nil;
//    
//    return movingElements;
//}
//
//- (void)deleteViewWithTag:(int)viewTag
//{
//    int numberOfObjectsToLoop = [self.dataSource numberOfObjectsToLoop];
//    // positioning if we don't loop elements
//    
//    if(!shouldLoopContent)
//    {
//        [self clean];
//        [self setupWithLooping:NO];
//    }
//    else
//    {
//        if(viewsCountPerScreen >= numberOfObjectsToLoop)
//        {
//            [self clean];
//            [self setupWithoutLooping];
//        }
//        else
//        {
//            NSMutableArray *thumbsToDelete = [NSMutableArray arrayWithCapacity:0];
//            
//            for (int i = 0 ; i < listOfViews.count; i++)
//            {
//                UIView *thumb = [listOfViews objectAtIndex:i];
//                
//                if(thumb.tag == viewTag) {
//                    [thumbsToDelete addObject:thumb];
//                }
//                
//                // tag should be reindex, cause the data Source will delete elements, so it will reindex data
//                // we should reindex all data above source index tag
//                if(thumb.tag > viewTag) {
//                    thumb.tag -= 1;
//                }
//            }
//            
//            for(UIView *thumb in thumbsToDelete) {
//                [thumb removeFromSuperview];
//                [listOfViews removeObject:thumb];
//            }
//            
//            int viewWidth = [self.dataSource sizeOfSmoothViewElement].width;
//            
//            for (int i = 0 ; i < listOfViews.count; i++)
//            {
//                UIView *view = [listOfViews objectAtIndex:i];
//                [self moveView:view toXYOrigins:CGPointMake((i * viewWidth), 0)];
//            }
//            
//            UIView *lastView = [listOfViews lastObject];
//            int lastElementIndex = lastView.tag;
//            
//            for(int i = 0 ; i < thumbsToDelete.count ; i++)
//            {
//                UIView *thumb = [thumbsToDelete objectAtIndex:i];
//                thumb = [self.dataSource smoothViewForIndex:[self mod:lastElementIndex + i + 1 andB:numberOfObjectsToLoop] withReusableView:thumb];
//                [self addSubview:thumb];
//                [self moveView:thumb toXYOrigins:CGPointMake((listOfViews.count + i) * viewWidth, 0)];
//                [listOfViews addObject:thumb];
//            }
//        }
//    }
//}
//
//- (void)showViewWithTag:(int)viewTag animated:(BOOL)animated
//{
//    if(self.contentSize.width <= self.frame.size.width) {
//        return ;
//    }
//    
//    BOOL viewFound = NO;
//    int viewWidth = [self.dataSource sizeOfSmoothViewElement].width;
//    CGPoint willGoToOffset = self.contentOffset;
//    
//    for (int i = 0 ; i < listOfViews.count && !viewFound; i++)
//    {
//        UIView *thumb = [listOfViews objectAtIndex:i];
//        
//        if(thumb.tag == viewTag)
//        {
//            // desired view is on the screen so we can jump to it
//            viewFound = YES;
//            willGoToOffset = CGPointMake(thumb.frame.origin.x + (viewWidth / 2) - (self.frame.size.width/2), 0);
//            
//            if(willGoToOffset.x < 0) {
//                willGoToOffset.x = 0;
//            }
//            
//            if(willGoToOffset.x > self.contentSize.width - self.frame.size.width) {
//                willGoToOffset.x = self.contentSize.width - self.frame.size.width;
//            }
//        }
//    }
//    
//    if(animated)
//    {
//        isAnimating = YES;
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    }
//    
//    self.contentOffset = willGoToOffset;
//    
//    if(!viewFound) {
////        [self createAndSkipToViewWithTag:viewTag];
//    }
//    
//    if(animated)
//    {
//        [UIView commitAnimations];
//    }
//}
//
//- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
//    if(shouldLoopContent)
//    {
//        isAnimating = NO;
//        [self recenterIfNecessary];
//    }
//}

- (void)moveView:(UIView *)view toXYOrigins:(CGPoint)XYpoint
{
    view.frame = CGRectMake(XYpoint.x, XYpoint.y, view.frame.size.width, view.frame.size.height);
}

- (NSMutableArray *)listOfViews
{
    return listOfViews;
}

- (void)clean
{
    for(UIView *thumb in [self subviews]){
        [thumb removeFromSuperview];
    }
    
    [self.listOfViews removeAllObjects];
}

- (int)mod:(int)a andB:(int)b
{
    a = a % b;
    
    if(a < 0) {
        a += b;
    }
    
    return a;
}

- (void)dealloc
{
    [self clean];
    dataSource = nil;
    free(viewIndexes);
}

@end
