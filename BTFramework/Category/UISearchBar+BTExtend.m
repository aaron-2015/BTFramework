//
//  UISearchBar+BTExtend.m
//  BiketoRabbit
//
//  Created by aaron on 16/5/6.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import "UISearchBar+BTExtend.h"

#define IS_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9

@implementation UISearchBar (BTExtend)

- (void)bt_setTextFont:(UIFont *)font
{
    if (IS_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)bt_setTextColor:(UIColor *)textColor
{
    if (IS_IOS9) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    }else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)bt_setCancelButtonTitle:(NSString *)title
{
    if (IS_IOS9) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

@end
