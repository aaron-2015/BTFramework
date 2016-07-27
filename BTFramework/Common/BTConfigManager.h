//
//  BTConfigManager.h
//  BiketoRabbit
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#ifndef BTConfigManager_h
#define BTConfigManager_h

/***************************************************************************/

static NSString * const BT_CLIENT_ID = @"1_lcn2vsdinhwcs8og8ksgko4c48w8g4okg408ookkggk8kg44s";

static NSString * const BT_CLIENT_SECRET = @"3sf551vyh0kkgwgo0o4kg844cwoockwgss4ggwkog4s0o84go4";

/***************************************************************************/


/***************************************************************************/
// screen helpers
/**
 * 屏幕宽度
 */
#define BT_SCREEN_WIDTH     ([[UIScreen mainScreen]bounds].size.width)

/**
 * 屏幕高度
 */
#define BT_SCREEN_HEIGHT    ([[UIScreen mainScreen]bounds].size.height)

/**
 * 键盘基本高度
 */
#define BT_KEYBOARD_HEIGHT  216

#pragma mark - 相对Iphone6比例

#define BT_SCALE                   (BT_SCREEN_WIDTH/375.0)

#define BT_ACTIVITY_IMAGE_RATIO    (420.0/750.0)

/***************************************************************************/


/***************************************************************************/
#pragma mark - 设备类型

#define IPHONE_4 ([UIScreen mainScreen].bounds.size.height == 480 ? YES : NO)

#define IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568 ? YES : NO)

#define IPHONE_6 ([UIScreen mainScreen].bounds.size.height == 667 ? YES : NO)

#define IPHONE_6P ([UIScreen mainScreen].bounds.size.height == 736 ? YES : NO)
/***************************************************************************/

/***************************************************************************/
#pragma mark - 系统版本和屏幕值

#define CURRENT_DEVICE_MODEL ([[UIDevice currentDevice] model])

#define CURRENT_VERSION  ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

// ios version helpers

/**
 * 本机当前iOS版本
 */
#define CURRENT_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

/**
 * iOS版本是否是7.0或者7.0以上
 */
#define IOS_VERSION_7_OR_ABOVE ((CURRENT_SYSTEM_VERSION >= 7.0) ? (YES):(NO))

/**
 * iOS版本是否小于7.0
 */
#define IOS_VERSION_7_BEFORE ((CURRENT_SYSTEM_VERSION < 7.0) ? (YES):(NO))

/**
 * iOS版本是否小于8.0
 */
#define IOS_VERSION_8_BEFORE   ((CURRENT_SYSTEM_VERSION < 8.0) ? (YES):(NO))

/**
 * iOS版本是否小于9.0
 */
#define IOS_VERSION_9_BEFORE   ((CURRENT_SYSTEM_VERSION < 9.0) ? (YES):(NO))

/**
 *  tabbar 高度
 */
#define BT_TABBAR_HEIGHT    49

/**
 * 导航条高度
 */
#define BT_NAVIGATION_BAR_HEIGHT (IOS_VERSION_7_OR_ABOVE ? 64 : 44)

/**
 * 状态条高度
 */
#define BT_STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

/**
 * iPhone4 和 5 的屏幕宽度
 */
#define SCREEN_WIDTH_IPHONE_4_AND_5 320.0

/**
 * iPhone6 的屏幕宽度
 */
#define SCREEN_WIDTH_IPHONE_6       375.0

/**
 * iPhone6P 的屏幕宽度
 */
#define SCREEN_WIDTH_IPHONE_6_PLUS  414.0
/***************************************************************************/

/**
 * 新增的字体
 */
#define NEW_FONT        @"LeagueGothic"

/***************************************************************************/
/**
 *  存储文件的系统路径
 */
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]


#pragma mark - 数据库
/**
 *  定义数据库加密功能
 */
//TODO: 上线前设置 数据库加密
#ifndef DB_ENCRYPT

#ifndef DEBUG
#define DB_ENCRYPT
#endif

#endif

/**
 *  定义数据库加密key
 */
#ifdef DB_ENCRYPT
#define DB_ENCRYPT_KEY    @"_bike_To_app_7HTu93BF4cZ"
#else
#define DB_ENCRYPT_KEY    @""
#endif

#pragma mark - http请求header字段

#define BT_HEAD_SOURCE     @"biketo-channel"

#define BT_HEAD_VERSION    @"biketo-version"

/***************************************************************************/
/**
 *  app使用的中文字体
 */
#define BT_CHN_FONT         (IOS_VERSION_9_BEFORE ? @"STHeitiSC-Medium" : @"PingFangSC-Regular")

#define BT_CHN_FONT_WITH_SIZE(size)  (IOS_VERSION_9_BEFORE ? [[UIFont systemFontOfSize:size]:[UIFont fontWithName:BT_CHN_FONT size:size])
/***************************************************************************/


/**
 *  存储记录中的GUID值
 */
#define BT_SAVE_CURRENT_GUID_KEY  @"save_current_guid_key"

/**
 *  积分说明H5
 */
static NSString * BT_POINTS_EXPLAIN_PATH = @"/v2/common/pointsins";

/**
 *  百度SDK AppKey
 */
#ifdef BETA
static NSString * const BT_BAIDU_APPKEY = @"i87Gh5qn2GWVWmhkY5QBV7vzx0YAKYCG";
#else
static NSString * const BT_BAIDU_APPKEY = @"O7X2DREqY9MWmpfS09aB8ykG";
#endif

/**
 *  友盟SDK AppKey
 */
static NSString * const BT_UMENG_APPKEY = @"558ce9b667e58ed63f003742";

/**
 *  极光推送SDK AppKey
 */
static NSString * const BT_JPUSH_APPKEY = @"f4db31580ba8f671c7b768ed";

/**
 *  极光推送渠道
 */
static NSString * const BT_JPUSH_CHANNEL = @"iOS";

/**
 *  微信SDK AppKey
 */
static NSString * const BT_WECHAT_APPID = @"wx00267ddee2bd11f6";

/**
 *  微信SDK AppSecret
 */
static NSString * const BT_WECHAT_APPSECRET = @"54531bd9397d4a0387f4d37f9fb27b60";

/**
 *  QQSDK AppKey
 */
static NSString * const BT_QQ_APPID = @"1104671763";

/**
 *  微博SDK AppKey
 */
static NSString * const BT_WEIBO_APPID = @"1390226725";

#endif /* BTConfigManager_h */
