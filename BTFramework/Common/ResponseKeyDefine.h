//
//  ResponseKeyDefine.h
//  BiketoRabbit
//
//  Created by apple on 15/7/14.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#ifndef BiketoRabbit_ResponseKeyDefine_h
#define BiketoRabbit_ResponseKeyDefine_h

//common
#define RESP_STATUS_KEY         @"status"
#define RESP_MESSAGE_KEY        @"message"
#define RESP_ERROR_KEY          @"error"
#define RESP_DATA_KEY           @"data"
#define RESP_LIST_KEY           @"list"
#define RESP_COUNT_KEY          @"count"
#define RESP_PAGES_KEY          @"pages"
#define RESP_UNREAD_NOTICE_NUM_KEY  @"unreadNoticeNum"
#define RESP_SHARE_KEY          @"share"
#define RESP_INVITE_KEY         @"invite"
#define RESP_MY_APPLY_KEY       @"myApply"
#define RESP_MY_AUDIT_KEY       @"myAudit"
#define RESP_RECOMMEND_KEY      @"recommend"
#define RESP_IOS_VERSION_KEY    @"iosVersion"

//token
#define RESP_TOKEN_KEY          @"token"
#define RESP_ACCESS_TOKEN_KEY   @"access_token"
#define RESP_EXPIRES_IN_KEY     @"expires_in"
#define RESP_TOKEN_TYPE_KEY     @"token_type"
#define RESP_SCOPE_KEY          @"scope"
#define RESP_REFRESH_TOKEN_KEY  @"refresh_token"

//user
#define RESP_USERINFO_KEY       @"userInfo"
#define RESP_USER_KEY           @"user"
#define RESP_USER_ID_KEY        @"id"
#define RESP_USERNAME_KEY       @"username"
#define RESP_QQ_KEY             @"qq"
#define RESP_QQGROUP_KEY        @"qqgroup"
#define RESP_WEIXIN_KEY         @"weixin"
#define RESP_EMAIL_KEY          @"email"
#define RESP_SEX_KEY            @"sex"
#define RESP_BIRTHDAY_KEY       @"birthday"
#define RESP_HEIGHT_KEY         @"height"
#define RESP_WEIGHT_KEY         @"weight"
#define RESP_PROVINCE_KEY       @"province"
#define RESP_CITY_KEY           @"city"
#define RESP_REGION_KEY         @"region"
#define RESP_PROVINCEID_KEY     @"provinceID"
#define RESP_CITYID_KEY         @"cityID"
#define RESP_REGIONID_KEY       @"regionID"
#define RESP_STREET_KEY         @"street"
#define RESP_AVATAR_KEY         @"avatar"
#define RESP_CREATED_AT_KEY     @"createdAt"
#define RESP_LAST_RIDE_AT_KEY   @"lastRideAt"
#define RESP_HAS_WEIBO_KEY      @"hasWeibo"
#define RESP_HAS_WEIXIN_KEY     @"hasWeixin"
#define RESP_HAS_QQ_KEY         @"hasQQ"
#define RESP_HAS_BIKETO_KEY     @"hasBiketo"
#define RESP_HAS_PASS_KEY       @"hasPass"
#define RESP_USER_NEAR_KEY      @"near"
#define RESP_USER_LOGINTYPE     @"loginType"

//equipment
#define RESP_EQUIPMENT_PHOTOS_KEY @"photos"
#define RESP_EQUIPMENT_DETAIL_KEY @"detail"

//summary
#define RESP_PRAISE_NUM_KEY     @"praiseNum"
#define RESP_FOLLOW_STATUS_KEY  @"followStatus"
#define RESP_NUM_KEY            @"num"
#define RESP_MY_FOLLOW_KEY      @"myfollow"
#define RESP_MY_TEAMS_KEY       @"myteams"

//track
#define RESP_TRACK_ID_KEY       @"track_id"
#define RESP_TRACK_INFO_KEY     @"trackInfo"
#define RESP_START_TIME_KEY     @"starttime"
#define RESP_END_TIME_KEY       @"endtime"
#define RESP_TOTAL_TIME_KEY     @"totaltime"
#define RESP_TOTAL_DIS_KEY      @"totalDis"
#define RESP_AVERAGE_SPEED_KEY  @"averageSpeed"
#define RESP_SPEED_MAX_KEY      @"speedMax"
#define RESP_CLIMB_UP_KEY       @"climbUp"
#define RESP_CLIMB_DOWN_KEY     @"climbDown"
#define RESP_SLOPE_MAX_KEY      @"slopeMax"
#define RESP_SLOPE_MIN_KEY      @"slopeMin"
#define RESP_CALORIE_KEY        @"calorie"
#define RESP_START_LAT_KEY      @"startLat"
#define RESP_START_LON_KEY      @"startLon"
#define RESP_START_GEO_CODE_KEY @"StartGeoCode"
#define RESP_END_LAT_KEY        @"endLat"
#define RESP_END_LON_KEY        @"endLon"
#define RESP_DATA_TYPE_KEY      @"dataType"

//query track
#define RESP_LAT_KEY            @"lat"
#define RESP_LON_KEY            @"lon"
#define RESP_PHOTO_TIME_KEY     @"photo_time"
#define RESP_FILE_TYPE_KEY      @"file_type"
#define RESP_URL_KEY            @"url"

//query user
#define RESP_WEEK_KEY           @"week"
#define RESP_MONTH_KEY          @"month"
#define RESP_YEAR_KEY           @"year"
//#define RESP_AVERAGE_SPEED_KEY  @"averageSpeed" //redefine
#define RESP_MAX_SPEED_KEY      @"maxSpeed"
#define RESP_MAX_CALORIE_KEY    @"maxCalorie"
#define RESP_MAX_DIS_KEY        @"maxDis"
#define RESP_MAX_TIME_KEY       @"maxtime"
//#define RESP_TOTAL_DIS_KEY      @"totalDis"//redefine
//#define RESP_TOTAL_TIME_KEY     @"totalTime"//redefine
//#define RESP_MAX_DIS_KEY        @"maxDis"//redefine
#define RESP_TOTAL_CLIMB_KEY    @"totalClimb"
#define RESP_TOTAL_COUNT_KEY    @"totalCount"
#define RESP_TOTAL_CALORIE_KEY  @"totalCalorie"

//team
#define RESP_TEAM_APPLY_KEY     @"apply"
#define RESP_TEAM_JOINED_KEY    @"joined"
#define RESP_TEAM_APPLY_ID_KEY  @"apply_id"
#define RESP_TEAM_ID_KEY        @"team_id"
#define RESP_ID_KEY             @"id"
#define RESP_TEAM_MYTEAMS_KEY   @"myteams"
#define RESP_TEAM_APPLYING_KEY  @"applying"
#define RESP_TEAM_INFO          @"teamInfo"
#define RESP_ACTIVITITY_INFO    @"activityInfo"
#define RESP_ACTIVITITY_SIGNERS_KEY  @"signData"
#define RESP_ACTIVITY_PRECUT_PHOTO   @"precut"
#define RESP_TEAM_RECOMMEND_PKEY     @"recommend"

//point list
#define RESP_DATE_POINTS        @"datePoints"

//dynamic type
#define RESP_DYNAMIC_USER_LIST  @"userList"
#define RESP_DYNAMIC_TYPE       @"type"
#define RESP_DYNAMIC_TIME       @"dynamicTime"
#define RESP_OFFICIAL_LIST      @"officialList"

//my grade
#define RESP_MY_GRADE_KEY       @"mygrade"
#define RESP_EXP_INFO_KEY       @"experienceInfo"

//challenge
#define RESP_CHALLENGE_DETAIL_KEY          @"detail"
#define RESP_CHALLENGE_ALL_RANK_KEY        @"allRank"
#define RESP_CHALLENGE_SUBSCRIBE_RANK_KEY  @"subscribeRank"
#define RESP_CHALLENGE_LIST_1_KEY          @"list1"
#define RESP_CHALLENGE_LIST_2_KEY          @"list2"
#define RESP_CHALLENGE_MESSAGE_KEY         @"message"
#define RESP_CHALLENGE_SIGN_NUMBER_KEY     @"signNumber"
#define RESP_CHALLENGE_RECOMMEND_KEY       @"recommend"

//achievement and medal key
#define RESP_ACHIEVEMENT_LIST_KEY   @"achievementList"
#define RESP_MEDAL_LIST_KEY         @"medalList"
#define RESP_CATE_LIST_KEY          @"cateList"

//points redeem 积分兑换
#define RESP_REDEEM_DETAIL_NAME_KEY   @"id"
#define RESP_REDEEM_DETAIL_SUB_KEY    @"sub"
#define RESP_REDEEM_RECEIVERINFO_KEY  @"receiverInfo"
#define RESP_REDEEM_LOGISTICSINFO_KEY @"logisticsInfo"
#define RESP_REDEEM_PRICE_KEY           @"price"
#define RESP_REDEEM_MARK_PRICE_KEY @"market_price"
#define RESP_REDEEM_IMAGES_KEY @"images"
#define RESP_REDEEM_EXTRA_KEY @"extra"
#define RESP_REDEEM_COUPONCODE  @"couponCode"

//网络请求返回状态码
typedef NS_ENUM(NSUInteger, RespStatus) {
    kRespStatusNone,    //0 正确
    kRespStatus1,       //1 通⽤的出错信息/⽤户名已被注册/邮箱已被注册
    kRespStatus2,       //2 错误的用户token
    kRespStatus3,       //3
    kRespStatus4,       //4
    kRespStatus5,       //5
    kRespStatus6,       //6
    kRespStatus7,       //7
    kRespStatus8,       //8
    kRespStatus9,       //9
    kRespStatus10,      //10
    kRespStatus11,      //11
    kRespStatus12,      //12
    kRespStatus13,      //13 Token过期失效
    kRespStatus14,      //14 ⽤户未关联第三方账号
    kRespStatus15,      //15 第三⽅账号Token校验错误
    kRespStatus16,      //16 此ID已与其他账号绑定
    kRespStatus17,      //17
    kRespStatus18,      //18
    kRespStatus19,      //19
    kRespStatus20,      //20
    kRespStatus21,      //21 参数有误 //应⽤ID与KEY校验失败
    kRespStatus22,      //22 客户端认证失败 //应⽤授权被禁⽤
    kRespStatus23,      //23
    kRespStatus24,      //24
    kRespStatus25,      //25
    kRespStatus26,      //26
    kRespStatus27,      //27 用户名或者密码错误/AccessToken错误 //错误的Refresh Token，请重新登录
    kRespStatus28,      //28
    
    kRespStatusTrackUploadTimeConflict  = 502,       //502 轨迹时间冲突（不同轨迹）
    kRespStatusTrackUploadExistSame     = 503,       //503 与现有线路有冲突（相同轨迹）
    kRespStatusCreateTeamShowAlert      = 504,       //创建车队时需要弹出提示框
    kRespStatusTrackPhotoExistSame      = 505,       //轨迹图片相同
    kRespStatusUserNoBindMobile         = 506,       //未绑定手机号码
    kRespStatusTrackUploadDataException = 507        //骑行轨迹距离为0或轨迹有效时长为0
    

};
#endif
