//
//  BTColorManager.m
//  BiketoRabbit
//
//  Created by BIKETO on 16/7/15.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import "BTColorManager.h"

@implementation BTColorManager


+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

+ (UIColor *)blackColor
{
    return [UIColor blackColor];
}

+ (UIColor *)whiteColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)clearColor
{
    return [UIColor clearColor];
}

+ (UIColor *)redColor
{
    return RGBCOLOR(234,  45,  73);
}

+ (UIColor *)orangeColor
{
    return RGBCOLOR(242, 102,  65);
}

+ (UIColor *)greenColor
{
    return RGBCOLOR( 81, 235, 153);
}

+ (UIColor *)lightGrayColor
{
    return RGBCOLOR(154, 154, 154);
}

+ (UIColor *)blueColor
{
    return RGBCOLOR(  0, 153, 197);
}

+ (UIColor *)backgroundColor
{
    return RGBCOLOR(  9,   7,   7);
}

+ (UIColor *)lightBackgroundColor
{
    return RGBCOLOR( 21,  22,  27);
}

+ (UIColor *)cellBackgroundColor
{
    return RGBCOLOR(0x15, 0x16, 0x1b);
}

+ (UIColor *)cellSeparatorColor
{
    return RGBCOLOR(0x2e, 0x2e, 0x31);
}

+ (UIColor *)cellSeparatorLightColor
{
    return RGBCOLOR(200, 200, 200);
}

+ (UIColor *)rankFirstColor
{
    return RGBCOLOR(194, 194,  70);
}

+ (UIColor *)rankSecondColor
{
    return RGBCOLOR(194, 161,  67);
}

+ (UIColor *)rankThirdColor
{
    return RGBCOLOR(191,  93,  62);
}

+ (UIColor *)trackPathColor
{
    return RGBCOLOR(234,  45,  73);
}

+ (UIColor *)chartTextColor
{
    return RGBCOLOR(130, 139, 150);
}

+ (UIColor *)bikeTeamLeaderColor
{
    return RGBCOLOR(224, 145,  32);
}

+ (UIColor *)bikeTeamAdminColor
{
    return RGBCOLOR( 42, 175, 158);
}

+ (UIColor *)bikeTeamDetailCellSeparatorColor
{
    return RGBCOLOR( 39,  40,  48);
}

+ (UIColor *)summaryDynamicTextColor
{
    return RGBCOLOR(154, 154, 154);
}

+ (UIColor *)userTipColor
{
    return RGBACOLOR(255, 255, 255, 0.2);
}

+ (UIColor *)emptyTitleColor
{
    return RGBCOLOR(66,  68,  79);
}

+ (UIColor *)redeemGrayTextColor
{
    return RGBCOLOR(93, 105, 119);
}
@end
