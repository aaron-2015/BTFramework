//
//  GlobalMacros.h
//  BiketoRabbit
//
//  Created by apple on 15/7/9.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#ifndef BiketoRabbit_GlobalMacros_h
#define BiketoRabbit_GlobalMacros_h

#import "BTColorManager.h"
#import "BTConfigManager.h"
#import "BTEnumManager.h"
#import "BTStringManager.h"
#import "BTUMUserEvent.h"

/***************************************************************************/
/**
 * 字典hepler
 */
#define DICT_PUT(dict, key, obj) do{if(obj)dict[key] = obj;}while(0)

/***************************************************************************/


/***************************************************************************/


#define SAFE_FREE(arg) if(arg){free(arg); arg = NULL;}


#pragma mark - Others

#define Common_Corner_Radius 5

#define Common_Corner_Radius_Bike_Team_Logo 2

/**
 *  对象判空
 */
#define NOT_NULL(obj) (obj) && ![(obj) isKindOfClass:[NSNull class]]

/**
 *  数组判空
 */
#define ARRAY_NOT_NULL(array) (array && ![array isKindOfClass:[NSNull class]] && array.count > 0)

/**
 *  手机验证码长度
 */
#define VERIFICATION_NUMBER_MAX  6

#define USER_CURRENT_TEAM_DEF   -1
//static const int USER_CURRENT_TEAM_DEF = -1;
/***************************************************************************/


/***************************************************************************/

#pragma mark - 文件读取级别

//注：0->原数据；1->摘要级别；2->详情级别；3->画图级别
#define FILE_LEVEL_ORIGINAL     0
#define FILE_LEVEL_SUMMARY      1
#define FILE_LEVEL_DETAIL       2
#define FILE_LEVEL_SMOOTH       3



#define BT_KILOMETER   1000.0

#define BT_IMAGE_DEFAULT       [UIImage imageFromContextWithColor:[BTColorManager lightBackgroundColor]] //注：使用此宏需引入头文件#import "UIImage+Color.h"
#define BT_IMAGE_DEFAULT_BLACK [UIImage imageFromContextWithColor:[BTColorManager backgroundColor]]

/******** 经纬度 测试 *******/
#ifdef DEBUG
#define LOCAL_LAT    23.128280
#define LOCAL_LON    113.394900
#endif

#endif
