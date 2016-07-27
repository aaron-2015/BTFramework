//
//  BTDataBaseCurrUserInfo.h
//  BiketoRabbit
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDataBaseCurrUserInfo : NSObject

@property (nonatomic, copy) NSString *user_id;  ///<用户id
@property (nonatomic, copy) NSData *user_data;  ///<登录成功后返回的数据
@property (nonatomic, copy) NSData *user_info;  ///<修改数据成功后返回的数据

@property (nonatomic, assign) NSInteger user_follows;       ///<用户关注数
@property (nonatomic, assign) NSInteger user_fans;          ///<用户粉丝数
@property (nonatomic, assign) NSInteger user_currTeamID;    ///<用户选择的车队id

@property (nonatomic, copy) NSData *team_list_data;          ///<车队列表数据
@property (nonatomic, copy) NSData *my_equipment_list_data;  ///<我的装备列表数据
@property (nonatomic, copy) NSData *brand_list_data;         ///<产品库列表数据
@property (nonatomic, copy) NSData *achievement_medal_data;  ///<成就与勋章列表

@end
