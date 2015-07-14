//
//  OCerFaceView.m
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import "OCerFaceView.h"

@implementation OCerFaceView

- (id)init
{
    if([super init])
    {
        [self setQueue:0];
        [self setLine:0];
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];  // 初始化放大镜
        [imageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"magnifier.png" ofType:nil]]];
        [imageView setHidden:YES];
        [self addSubview:imageView];
        [self setMagnifierView:imageView];
        
        UIImageView *face = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, kFaceWidth, kFaceHeight)];
        [face setBackgroundColor:[UIColor clearColor]];
        [imageView addSubview:face];
        [self setFace:face];
        
        [self sort];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)sort
{
    NSString *path = [[NSBundle mainBundle] pathForResource:kInfoFace ofType:nil];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSMutableArray *objs = [[NSMutableArray alloc] initWithArray:[dic allValues]];
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:[dic allKeys]];
    
    int count = (int)[objs count];
    count -= 1;
    
	for(int i = 0; i < count; ++i)
	{
		BOOL flag = YES;
        
		for(int j= 0; j < count - i; ++j)
		{
            NSString *str1 = [objs objectAtIndex:j];
            NSString *str2 = [objs objectAtIndex:j + 1];
			if([str1 compare:str2] == NSOrderedDescending)
			{
                NSString *temp1 = [keys objectAtIndex:j];
                NSString *temp2 = [keys objectAtIndex:j + 1];
                
                [objs setObject:str2 atIndexedSubscript:j];
                [objs setObject:str1 atIndexedSubscript:j + 1];
                [keys setObject:temp2 atIndexedSubscript:j];
                [keys setObject:temp1 atIndexedSubscript:j + 1];
                
				flag = NO;
			}
		}
        
		if(flag)
		{
			break;
		}
	}
    
    [self setObjs:objs];
    [self setKeys:keys];
    
    count += 1;
    int sum = kLine * kQueue;
    float temp = count / (float)sum;
    int page = count / sum;
    
    if(temp > page)
    {
        ++page;
    }
    
    [self setFrame:CGRectMake(0, 0, kScreenWidth * page, 156)];
    [self setPage:page];
    
    return;
}

- (void)drawRect:(CGRect)rect
{
    NSArray *array = [self objs];
    CGFloat kWidth = kScreenWidth;
    
    int count = (int)[array count];
    int page = 0;  // 页数
    int j = 0;     // 行数
    int k = 0;     // 列数
    int width = kLeft;
    
    for(int i = 0; i < count; ++i)
    {
        NSString *name = [array objectAtIndex:i];
        UIImage *image = [UIImage imageNamed:name];
        CGRect frame = CGRectMake(width + (kFaceDistanceWidth + kFaceWidth) * k + (page * kWidth), kTop + ((kFaceHeight + kFaceDistanceHeight) * j), kFaceWidth, kFaceHeight);
        [image drawInRect:frame];
        ++k;
        
        if(k % kLine == 0)
        {
            k = 0;
            ++j;
            
            if(j % kQueue == 0)
            {
                j = 0;
                ++page;
            }
        }
    }
    
    return;
}

- (int)getX:(CGFloat)x
{
    if(x < 0.0f)  // 判断开头无效部分
    {
        [[self magnifierView] setHidden:YES];
        return 233; // 一个较大的、无意义的值
    }
    
    int index = 0;
    
    while(x >= 0)
    {
        ++index;
        x -= kFaceWidth;
        
        if((x >= 0) && (x <= kFaceDistanceWidth)) // 判断间隙部分
        {
            return 233;
        }
        else
        {
            x -= kFaceDistanceWidth;
        }
        
        if(index == kLine + 1) // 判断结尾部分
        {
            [[self magnifierView] setHidden:YES];
            return 233;
        }
    }
    
    return index;
}

- (int)getY:(CGFloat)y
{
    if(y < 0.0f)
    {
        [[self magnifierView] setHidden:YES];
        return 233;
    }
    
    int index = -1;
    
    while(y >= 0)
    {
        ++index;
        y -= kFaceHeight;
        
        if((y >= 0) && (y <= kFaceDistanceHeight))
        {
            return 233;
        }
        else
        {
            y -= kFaceDistanceHeight;
        }
        
        if(index == kQueue)
        {
            [[self magnifierView] setHidden:YES];
            return 233;
        }
    }
    
    return index;
}

- (void)showFace:(CGPoint)point
{
    int width = kLeft;
    CGFloat kWidth = kScreenWidth;
    int page = point.x / kWidth; // 页
    CGFloat x = point.x - (page * kWidth) - width; // 当前页的x
    CGFloat y = point.y - kTop;
    int queue = 0;
    int line = [self getX:x];
    
    if(line < kLine + 1)  // 行有效才计算列
    {
        queue = [self getY:y];
    }
    else
    {
        return;
    }
    
    if((queue == [self queue]) && (line == [self line])) // 处理同一个表情重复选择的情况
    {
        return;
    }
    
    [self setLine:line];
    [self setQueue:queue];
    int index = (page * kQueue * kLine) + (queue * kLine) + line - 1;
    
    if(index >= [[self keys] count]) // 处理无效情况
    {
        [self setFaceName:nil];
        return;
    }
    
    NSString *faceName = [[self keys] objectAtIndex:index];
    [self setFaceName:faceName];
    NSString *name = [[self objs] objectAtIndex:index];
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *face = [self face];
    [face setImage:image];
    UIImageView *imageView = [self magnifierView];
    CGRect frame = [imageView frame];
    --line;
    x = ((page * kWidth) + width + (line * kFaceWidth) + (line * kFaceDistanceWidth)) - (kFaceWidth / 2);
    y = (kTop + (queue * kFaceHeight) + (queue * kFaceDistanceHeight)) + (kFaceHeight / 2) - 90;
    frame.origin.y = y;
    frame.origin.x = x;
    [imageView setFrame:frame];
    [imageView setHidden:NO];
    
    return;
}

- (void)hiddenMagnifierView
{
    [[self magnifierView] setHidden:YES];
    UIScrollView *scroll = (UIScrollView *)[self superview];
    [scroll setScrollEnabled:YES];
    [self setQueue:0];
    [self setLine:0];
    
    return;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIScrollView *scroll = (UIScrollView *)[self superview];
    [scroll setScrollEnabled:NO];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self showFace:point];
    
    return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self showFace:point];
    
    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenMagnifierView];
    
    id delegate = [self delegate];
    NSString *name = [self faceName];
    
    if((name != nil) && (delegate != nil) && ([delegate respondsToSelector:@selector(getFaceName:)]))
    {
        [delegate getFaceName:name];
    }
    
    return;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenMagnifierView];
    
    return;
}

@end
