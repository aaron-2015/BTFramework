//
//  NSDate+BTExtend.m
//  BiketoRabbit
//
//  Created by aaron on 16/4/22.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import "NSDate+BTExtend.h"

@implementation NSDate (BTExtend)

+ (NSString *)dayStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs
{
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSString *dayString;
    NSTimeInterval delta = secs - now;
    int day = 0;
    if (delta / (24*60*60) >= 1) {
        day = delta / (24*60*60);
        if (day < 10) {
            dayString = [NSString stringWithFormat:@"0%d",day];
        }else {
            dayString = [NSString stringWithFormat:@"%d",day];
        }
    }else {
        dayString = [NSString stringWithFormat:@"00"];
    }
    return dayString;
}

+ (NSString *)hourStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs
{
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSString *hourString;
    NSTimeInterval delta = secs - now;
    int hour = 0;
    int day = delta / (24*60*60);
    
    double hourDelta = delta - day * (24*60*60);
    if (hourDelta / (60*60) >=1) {
        hour = hourDelta / (60*60);
        if (hour < 10) {
            hourString = [NSString stringWithFormat:@"0%d",hour];
        }else {
            hourString = [NSString stringWithFormat:@"%d",hour];
        }
    }else {
        hourString = [NSString stringWithFormat:@"00"];
    }
    return hourString;
}


+ (NSString *)minuteStringfronNowWithTimeIntervalSince1970:(NSTimeInterval)secs
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSString *minuteString;
    NSTimeInterval delta = secs - now;
    int minute = 0;
    int hour = delta / (60*60);
    
    double minuteDelta = delta - hour * (60*60);
    if ((minuteDelta / 60 ) >=1) {
        minute = minuteDelta / 60;
        if (minute < 10) {
            minuteString = [NSString stringWithFormat:@"0%d",minute];
        }else {
            minuteString = [NSString stringWithFormat:@"%d",minute];
        }
    }else {
        minuteString = [NSString stringWithFormat:@"00"];
    }
    return minuteString;
}

@end
