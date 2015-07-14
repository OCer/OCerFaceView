//
//  OCerFaceView.h
//  OCerFaceViewDome
//
//  Created by Cer on 15-7-14.
//  Copyright (c) 2015年 Cer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenHeight [[UIScreen mainScreen]                bounds].size.height // 获取设备的物理高度
#define kScreenWidth [[UIScreen mainScreen]                 bounds].size.width  // 获取设备的物理宽度
#define kFaceDistanceWidth                                  10                  // 表情间隔的宽度
#define kFaceDistanceHeight                                 10                  // 表情间隔的高度
#define kFaceWidth                                          32                  // 表情的宽度
#define kFaceHeight                                         32                  // 表情的高度
#define kLine                                               7                   // 每页中表情最大行数
#define kQueue                                              3                   // 每页中表情最大表情列数
#define kTop                                                20                  // 表情距离顶部的距离
#define kLeft ((kScreenWidth - (kFaceWidth * kLine) - 60) / 2)                  // 表情距离左边的距离
#define kInfoFace                                           @"infoFace.plist"   // 表情的plist文件名

@protocol OCerFaceDelegate <NSObject>  // 自定义选择的代理

- (void)getFaceName:(NSString *)name;  // 获取表情名

@end

@interface OCerFaceView : UIView  // 表情视图

@property(strong, nonatomic) NSArray      *objs;            // 图片名称数组
@property(strong, nonatomic) NSArray      *keys;            // 表情名称数组
@property(copy, nonatomic  ) NSString     *faceName;        // 选中的表情名
@property(strong, nonatomic) UIImageView  *magnifierView;   // 放大镜
@property(strong, nonatomic) UIImageView  *face;            // 放大镜里面的表情
@property(weak, nonatomic  ) id<OCerFaceDelegate> delegate; // 代理
@property(assign, nonatomic) int          page;             // 表情页数
@property(assign, nonatomic) int          queue;            // 上次选中的列
@property(assign, nonatomic) int          line;             // 上次选中的行


@end
