//
//  OCerShowFaceView.m
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import "OCerShowFaceView.h"

@implementation OCerShowFaceView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int x = [scrollView contentOffset].x / kScreenWidth;
    [[self page] setCurrentPage:x];
    
    return;
}

- (void)create
{
    CGFloat width = kScreenWidth;
    [self setBackgroundColor:[UIColor clearColor]];
    
    OCerFaceView *face = [[OCerFaceView alloc] init];
    [self setFace:face];
    int page = [face page];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [scroll setBackgroundColor:[UIColor clearColor]];
    [scroll setFrame:CGRectMake(0, 0, width, 156)];
    [scroll setDirectionalLockEnabled:YES];
    [scroll setPagingEnabled:YES];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    [scroll setDelegate:self];
    [scroll setClipsToBounds:NO];
    [scroll setContentSize:CGSizeMake([face frame].size.width, 0)];
    [scroll addSubview:face];
    [self addSubview:scroll];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [pageControl setBackgroundColor:[UIColor clearColor]];
    [pageControl setHidesForSinglePage:YES];
    [pageControl setEnabled:NO];
    [pageControl setNumberOfPages:page];
    [pageControl setCurrentPage:0];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor magentaColor]];
    [self setPage:pageControl];
    [self addSubview:pageControl];
    
    return;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = 170.0f;
    [super setFrame:frame];
    
    if([self face] == nil)
    {
        [self create];
    }
    
    return;
}

- (void)setDelegate:(id<OCerFaceDelegate>)delegate
{
    _delegate = delegate;
    [[self face] setDelegate:delegate];
    
    return;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[self page] setFrame:CGRectMake(0, 150, frame.size.width, 20)];
    }
    return self;
}

@end
