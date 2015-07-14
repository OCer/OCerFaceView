//
//  OCerShowFaceView.h
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCerFaceView.h"

@interface OCerShowFaceView : UIView<UIScrollViewDelegate>  // 封装好的表情选择视图

@property(strong, nonatomic) OCerFaceView *face;
@property(strong, nonatomic) UIPageControl *page;
@property(weak, nonatomic) id<OCerFaceDelegate> delegate;

@end
