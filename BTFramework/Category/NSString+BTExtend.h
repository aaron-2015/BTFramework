//
//  NSString+BTExtend.h
//  BiketoRabbit
//
//  Created by aaron on 16/4/29.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BTExtend)

/**
 *  判断mobile是否为有效手机号码，符合规则返回nil
 */
+ (NSString *)valiMobile:(NSString *)mobile;

/**
 *  返回字符串的NSAttributedString
 */
+ (NSAttributedString *)missionStringWithMission:(NSString *)mission
                                       lineSpace:(CGFloat)lineSpace
                                        fontSize:(CGFloat)fontSize
                                           color:(UIColor*)color;

/**
 *  返回字符串的尺寸
 *
 *  @param font          字体
 *  @param size          最大可视面积
 *  @param lineBreakMode
 *
 *  @return
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 *  返回字符串的宽度
 *
 *  @param font          字体
 *  @param lineBreakMode
 *
 *  @return
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 *  返回字符串的高度
 *
 *  @param font  字体
 *  @param width 最大的宽度
 *
 *  @return 
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

//判断字符串是否为纯数字

- (BOOL)validateNumber;

@end
