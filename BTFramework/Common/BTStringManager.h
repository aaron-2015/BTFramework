//
//  BTStringManager.h
//  BiketoRabbit
//
//  Created by aaron on 16/7/26.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#ifndef BTStringManager_h
#define BTStringManager_h

/***************************************************************************/
#pragma mark - help hey

#define EMPTY_STRING    @""
/***************************************************************************/

/***************************************************************************/
#pragma mark - 性别

static NSString * USER_SEX_MALE   = @"男";
static NSString * USER_SEX_FEMALE = @"女";
/***************************************************************************/

/***************************************************************************/
#pragma mark - notification key

//登出
#define kNotificationLogoutKey                  @"app_logout"

//推送
#define kNotificationRemoteNotification         @"kNotificationRemoteNotification"
#define kNotificationRedBadgeChanged            @"kNotificationRedBadgeChanged"

//用户信息
#define kNotificationRefreshUserMain            @"kNotificationRefreshUserMain"
#define kNotificationChallengeDetailJoined      @"kNotificationChallengeDetailJoined"
#define kNotificationEquipmentEdited            @"kNotificationEquipmentEdited"
#define KNotificationFriendFollowStatusChanged  @"kNotificationFriendResultListStatusChanged"
#define kNotificationChangeFansStatus           @"kNotificationChangeFansStatus"
#define kNotificationRefreshRedPoint            @"kNotificationRefreshRedPoint"

//车队
#define kNotificationGetMyTeamList              @"kNotificationGetMyTeamList"
#define kNotificationRefreshTeamActivityList    @"kNotificationRefreshTeamActivityList"
#define KNotificationBikeTeamAddressChanged     @"kNotificationBikeTeamAddressChanged"

//动态列表
#define kNotificationRefreshDynamicList         @"kNotificationRefreshDynamicList"

//用户轨迹相关通知
#define kNotificationUserDidDeleteTrack         @"BTUserDidDeleteTrackNotification"
#define kNotificationUserDidDeleteTrackGUID     @"track_guid"
#define kNotificationTrackUploadResponse        @"TrackUploadResponseNotificaion"
#define kNotificationEndRequestGoogleAlt        @"kNotificationEndRequestGoogleAlt"
#define kNotificationAfterSavedTrack            @"kNotificationAfterSavedTrack"
#define kNotificationRecoverCache               @"kNotificationRecoverCache"

//记录
#define kNotificationAfterAddPointToCache       @"kNotificationAfterAddPointToCache"
#define kNotificationSetRidingAutoPause         @"kNotificationSetRidingAutoPause"

//#define kNotificationAfterUploadTrack           @"kNotificationAfterUploadTrack"
//#define kNotificationNetworkReachableChanged    @"kNotificationNetworkReachableChanged"

/***************************************************************************/

/***************************************************************************/
#pragma mark - 轨迹文件类型

static NSString * const TRACK_FILE_TYPE = @"bt"; //轨迹文件类型
static NSString * const TRACK_CACHE_FILE_TYPE = @"ct"; //轨迹缓存文件类型
/***************************************************************************/

/***************************************************************************/
#pragma mark - 分享信息字段

static NSString * SHARE_TITLE_STRING     = @"兔子骑行";
static NSString * SHARE_CONTENT_STRING   = @"没想到还有这么好用的骑行软件，颜值够高，数据够精准，活动够好玩！APP下载：http://dwz.cn/2OIzS2";
static NSString * SHARE_URL_STRING       = @"http://dwz.cn/2OIzS2";
static NSString * SHARE_IMAGE_URL_STRING = @"";
/***************************************************************************/

/***************************************************************************/
#pragma mark - 排行榜的标签

#define RANK_CURRENT_TITLE   @[@"本周", @"本月"]
#define RANK_HISTORY_TITLE   @[@"上周", @"上月"]
/***************************************************************************/

/***************************************************************************/
#pragma mark - 提示语

static NSString * const TRACK_UNUPLOAD_EXCEPTION_COMMENT_OR_PRAISE = @"该轨迹异常或未上传，无法点赞评论";
static NSString * const TEXT_LENGTH_OVERLIMIT_STRING = @"超过长度限制";
/***************************************************************************/


#endif /* BTStringManager_h */
