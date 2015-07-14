//
//  RootViewController.m
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        [self setTitle:@"表情选择"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenHeight;
    
    UITextView *textView = [[UITextView alloc] init];
    [textView setFrame:CGRectMake(0, 0, width, height - 200)];
    [textView setEditable:NO];
    [textView setFont:[UIFont systemFontOfSize:14.0]];
    [textView setReturnKeyType:UIReturnKeyDone];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [textView setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textView setTintColor:[UIColor orangeColor]];
    [self setTextView:textView];
    [[self view] addSubview:textView];
    
//    OCerShowFaceView *face = [[OCerShowFaceView alloc] initWithFrame:CGRectMake(0, height - 170, width, 0)];
    OCerShowFaceView *face = [[OCerShowFaceView alloc] init];
    [face setFrame:CGRectMake(0, height - 170, width, 0)]; // 表情控件默认高度是170
    [face setDelegate:self];
    [[self view] addSubview:face];
    
    return;
}

#pragma mark - 获取表情名称
- (void)getFaceName:(NSString *)name
{
    UITextView *textView = [self textView];
    NSString *str = [textView text];
    NSString *text = [NSString stringWithFormat:@"%@%@",str, name];
    
    [textView setText:text];
    
    return;
}

@end
