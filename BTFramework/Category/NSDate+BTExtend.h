//
//  NSDate+BTExtend.h
//  BiketoRabbit
//
//  Created by aaron on 16/4/22.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BTExtend)

/**
 *  根据后台返回的时间戳计算跟当前时间的天数差，返回两位数的格式，天数为个位数的时候前面补0；
 */
+ (NSString *)dayStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs;
/**
 *  根据后台返回的时间戳计算跟当前时间的小时数差，返回两位数的格式，小时数为个位数的时候前面补0；
 */
+ (NSString *)hourStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs;

/**
 *  根据后台返回的时间戳计算跟当前时间的分钟数差，返回两位数的格式，分钟数为个位数的时候前面补0；
 *
 *  @param secs 时间戳
 *
 *  @return NSString
 */
+ (NSString *)minuteStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs;

@end
