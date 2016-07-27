//
//  BTEnumManager.h
//  BiketoRabbit
//
//  Created by bike on 16/7/19.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#ifndef BTEnumManager_h
#define BTEnumManager_h

#pragma mark - 获取验证码类型

typedef NS_ENUM(NSUInteger, VerifyCodeType) {
    kVerifyCodeTypeRegister = 1,
    kVerifyCodeTypeRetrieve = 2,
};

#pragma mark - 用户注册类型

typedef NS_ENUM(NSUInteger, RegisterType) {
    kRegisterTypeEmail  = 1,
    kRegisterTypeMobile = 2,
};

#pragma mark - 用户登录类型

typedef NS_ENUM(NSUInteger, UserLoginType) {
    UserLoginTypeMobile  = 1,
    UserLoginTypeEmail = 2,
    UserLoginTypeBikeTo = 3,
    UserLoginTypeWeibo = 4,
    UserLoginTypeQQ = 5,
    UserLoginTypeWeixin = 6,
};

#pragma mark - 海拔类型

typedef NS_ENUM(NSUInteger, AltitudeType) {
    AltitudeType_GPS = 0,
    AltitudeType_Altimeter,
    AltitudeType_Google
};

#pragma mark - 用户好友关注

typedef NS_ENUM(NSInteger, UserRelationStatus) {
    UserRelationStatus_Friend    =  2,
    UserRelationStatus_Following =  1,
    UserRelationStatus_Default   =  0,
    UserRelationStatus_Fans      = -1,
    UserRelationStatus_None      = -2,
};

///************* 传参定义 ********************************///

#pragma mark - 消息推送类型 

typedef NS_ENUM(NSInteger, PushType) {
    kPushTypeBroadcast              = 0,    ///<广播
    kPushTypeSubscribe              = 1,    ///<有人关注
    kPushTypePraise                 = 2,    ///<有人点赞
    kPushTypeComment                = 3,    ///<有人评论
    kPushTypeRecommend              = 4,    ///<好友加入推荐
    kPushTypeTeamJoinApply          = 5,    ///<入队申请
    kPushTypeTeamNoticed            = 6,    ///<公告新增或修改
    kPushTypeTeamInviteRecieved     = 7,    ///<受到入队邀请
    kPushTypeTeamJoinAnswered       = 8,    ///<同意或拒绝入队
    kPushTypeTeamActivityPass       = 9,    ///<发布活动审核通过
    kPushTypeTeamActivityReject     = 10,   ///<发布活动审核拒绝
    kPushTypeTeamActivityNew        = 11,   ///<发布活动通知全队
    kPushTypeTeamActivityCancel     = 12,   ///<取消活动通知全队
    kPushTypeTeamActivityWillStart  = 13,   ///<活动即将开始
    kPushTypeTeamCreatePass         = 14,   ///<创建车队审核通过
    kPushTypeTeamCreateReject       = 15,   ///<创建车队审核未通过
    kPushTypeTeamAuthenticatePass   = 16,   ///<车队认证通过
    kPushTypeTeamAuthenticateReject = 17,   ///<车队认证未通过
    kPushTypeCount
};

#pragma mark - 消息推送开关

typedef NS_ENUM(NSInteger, PushSwitch) {
    kPushSwitchSubscribe  = 0,  //控制：Subscribe
    kPushSwitchPraise,          //控制：Praise
    kPushSwitchComment,         //控制：Comment
    kPushSwitchRecommend,       //控制：Recommend
    kPushSwitchTeamNotice,      //控制：TeamJoinApply,TeamNoticed,InviteRecieved,JionAnswered
    kPushSwitchBroadcast,       //控制：Broadcast
};

#pragma mark - 轨迹上传状态

typedef NS_ENUM(int, TrackUploadStatus) {
    Track_Upload_Status_Photo_Uploading = -5,
    Track_Upload_Status_Photo_Local = -4,
    Track_Upload_Status_Alt_Fix = -3,
    Track_Upload_Status_Conflict  = -2,
    Track_Upload_Status_Uploading = -1,
    Track_Upload_Status_Local     =  0,
    Track_Upload_Status_Success   =  1
};

///********************************************************///

#pragma mark - 摘要列表类型

typedef NS_ENUM(NSInteger, BTSummaryDynamicType) {
    BTSummaryDynamicTypeNone = 0,               ///<通用类型-->借用为本地轨迹数据类型
    BTSummaryDynamicTypeTrack,                  ///<已上传的轨迹
    BTSummaryDynamicTypeJoinTeam,               ///<加入车队
    BTSummaryDynamicTypeCreateTeam,             ///<创建车队
    BTSummaryDynamicTypeJoinChallenge,          ///<加入挑战
    BTSummaryDynamicTypeCompleteChallenge,      ///<完成挑战
    BTSummaryDynamicTypeGotAchievement,         ///<获得成就
    BTSummaryDynamicTypePublishTeamActive,      ///<发布车队活动
    BTSummaryDynamicTypeJoinTeamActive,         ///<加入车队活动
    BTSummaryDynamicTypeOfficialNews,           ///<官方资讯
    BTSummaryDynamicTypeOfficialNotice,         ///<官方通知
    BTSummaryDynamicTypeCount                   ///<类型总数
};

#pragma mark - 分享（原BTShare.h）

typedef NS_ENUM(NSInteger, Share_Platform) {
    Share_Platform_Sina_Weibo = 3,
    Share_Platform_QQ = 5,
    Share_Platform_QQ_Space = 4,
    Share_Platform_Wechat = 2,
    Share_Platform_Wechat_Timeline = 1,
    Share_Platform_URL = 6
};

typedef NS_ENUM(NSInteger, BTShareFromType) {
    BTShareFromType_To_Friend = 0,      ///<推荐给好友
    BTShareFromType_Track = 1,          ///<轨迹
    BTShareFromType_Challenge = 2,      ///<挑战
    BTShareFromType_Activity = 3,       ///<活动
    BTShareFromType_Redeem = 4,         ///<积分兑换
    BTShareFromType_Artical = 5,        ///<文章
    BTShareFromType_Achievement,        ///<成就
    BTShareFromType_Medal,              ///<勋章
    
};

#endif /* BTEnumManager_h */
