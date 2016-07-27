//
//  BTColorManager.h
//  BiketoRabbit
//
//  Created by BIKETO on 16/7/15.
//  Copyright © 2016年 BIKETO. All rights reserved.
//
//*******颜色管理*********

#import <Foundation/Foundation.h>

#define RGBCOLOR(r,g,b)     ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1])

#define RGBACOLOR(r,g,b,a)  ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])

@interface BTColorManager : NSObject

#pragma mark - 全局使用
+ (UIColor *)randomColor;
+ (UIColor *)blackColor;
+ (UIColor *)whiteColor;
+ (UIColor *)clearColor;
+ (UIColor *)redColor;
+ (UIColor *)orangeColor;
+ (UIColor *)greenColor;
+ (UIColor *)blueColor;
+ (UIColor *)lightGrayColor;

+ (UIColor *)backgroundColor;           //9,   7,   7
+ (UIColor *)lightBackgroundColor;      //21,  22,  27

+ (UIColor *)cellBackgroundColor;       //0x15, 0x16, 0x1b
+ (UIColor *)cellSeparatorColor;        //0x2e, 0x2e, 0x31
+ (UIColor *)cellSeparatorLightColor;   //200, 200, 200
+ (UIColor *)bikeTeamDetailCellSeparatorColor;//39,  40,  48

#pragma mark - 排行
+ (UIColor *)rankFirstColor;
+ (UIColor *)rankSecondColor;
+ (UIColor *)rankThirdColor;

#pragma mark - 轨迹描绘
+ (UIColor *)trackPathColor;

#pragma mark - 图表文字
+ (UIColor *)chartTextColor;

#pragma mark - 车队身份标签
+ (UIColor *)bikeTeamLeaderColor;
+ (UIColor *)bikeTeamAdminColor;

#pragma mark - 动态文字
+ (UIColor *)summaryDynamicTextColor;

#pragma mark - 用户提示
+ (UIColor *)userTipColor;

#pragma mark - 空白页文字
+ (UIColor *)emptyTitleColor;

#pragma mark - 积分兑换文字
+ (UIColor *)redeemGrayTextColor;

@end
