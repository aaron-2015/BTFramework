//
//  BTUMUserEvent.h
//  BiketoRabbit
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#ifndef BTUMUserEvent_h
#define BTUMUserEvent_h

#pragma mark - 登录
/**
 *  参数:platform (Normal,Biketo,Wechat,Weibo,QQ)
 */
static NSString * const BT_UM_USER_EVENT_LOGIN = @"login";
static NSString * const BT_UM_USER_EVENT_LOGIN_FINISH = @"login_finish";

#pragma mark - 登出

static NSString * const BT_UM_USER_EVENT_LOGOUT = @"logout";

#pragma mark - 注册

static NSString * const BT_UM_USER_EVENT_REGIST = @"regist";
static NSString * const BT_UM_USER_EVENT_REGIST_AVATAR = @"regist_avatar";
static NSString * const BT_UM_USER_EVENT_REGIST_FINISH = @"regist_finish";

#pragma mark - 忘记密码
static NSString * const BT_UM_USER_EVENT_PASSWORD_FORGET = @"password_forget";

#pragma mark - 记录页
static NSString * const BT_UM_USER_EVENT_RECORD_START = @"record_start";
static NSString * const BT_UM_USER_EVENT_RECORD_STOP = @"record_stop";
static NSString * const BT_UM_USER_EVENT_RECORD_SAVE = @"record_save";
static NSString * const BT_UM_USER_EVENT_RECORD_CHECK_DATA = @"record_check_data";
static NSString * const BT_UM_USER_EVENT_RECORD_CHECK_MAP = @"record_check_map";

#pragma mark - 摘要

static NSString * const BT_UM_USER_EVENT_SUMMARY_DETAIL_SHARE_FINISH = @"summary_detail_share_finish";
static NSString * const BT_UM_USER_EVENT_SUMMARY_DETAIL_MAP_FULLSCREEN = @"summary_detail_map_fullscreen";
static NSString * const BT_UM_USER_EVENT_SUMMARY_DETAIL_SPEED = @"summary_detail_speed";
static NSString * const BT_UM_USER_EVENT_SUMMARY_DETAIL_ALTITUDE = @"summary_detail_altitude";

#pragma mark - 个人

static NSString * const BT_UM_USER_EVENT_USER_CHART = @"user_chart";

/**
 *  参数:memory
 */
static NSString * const BT_UM_USER_EVENT_USER_SETTING_CLEAN_MEMORY = @"user_setting_clean_memory";

#endif /* BTUMUserEvent_h */
