//
//  RootViewController.h
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCerShowFaceView.h"

@interface RootViewController : UIViewController<OCerFaceDelegate>

@property(nonatomic, strong) UITextView *textView;

@end
