//
//  NotificationHandle.h
//  BiketoRabbit
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PUSH_TYPE       @"op"
#define PUSH_USER_ID    @"tid"
#define PUSH_TRACK_ID   @"uid"
#define PUSH_COMMENT_ID @"cid"
#define PUSH_URL        @"url"
#define PUSH_FRIEND_ID  @"source"

/**
 *  系统通知模型
 */
@interface ApsModel:NSObject

@property (nonatomic, assign) NSInteger badge;  ///<badge数量
@property (nonatomic, strong) NSString *alert;  ///<推送显示的内容
@property (nonatomic, strong) NSString *sound;  ///<播放的声音

@end

/**
 *  自定义通知模型
 */
@interface PushModel : NSObject

@property (nonatomic, strong) ApsModel *aps;
@property (nonatomic, assign) PushType  op;     ///<通知的类型
@property (nonatomic, assign) NSInteger uid;    ///<用户id
@property (nonatomic, assign) NSInteger tid;    ///<轨迹id 车队id
@property (nonatomic, assign) NSInteger cid;    ///<评论id
@property (nonatomic, assign) NSInteger aid;    ///<活动id
@property (nonatomic, assign) NSInteger source; ///<好友匹配来源（3微博 5好友）
@property (nonatomic, strong) NSString *url;    ///<跳转的url

@end

/**
 *  自定义通知模型
 */
@interface PushMessageModel : NSObject

@property (nonatomic, strong) PushModel *extras;
@property (nonatomic, strong) NSString  *content;     ///<自定义消息内容

@end

/**
 *  push通知处理类
 */
@interface NotificationHandle : NSObject

+ (void)handleRemoteMessage:(NSDictionary *)userInfo;

+ (void)handleRemoteNotification:(NSDictionary *)userInfo jump:(BOOL)jump;

//屏蔽本地推送接口
//+ (void)handleLocaleNotification:(NSDictionary *)userInfo jump:(BOOL)jump;

//+ (void)registerLocalNotification:(NSDictionary *)userInfo;
//
//+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end

