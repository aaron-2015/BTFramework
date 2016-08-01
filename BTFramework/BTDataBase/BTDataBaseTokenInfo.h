//
//  BTDataBaseTokenInfo.h
//  BiketoRabbit
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDataBaseTokenInfo : NSObject

@property (nonatomic, strong) NSString *user_id;        ///<用户ID
@property (nonatomic, strong) NSString *access_token;   ///<用户的token
@property (nonatomic, strong) NSString *refresh_token;  ///<刷新用的token
@property (nonatomic, assign) long expires_in;          ///<备用字段
@property (nonatomic, assign) long timestame;           ///<token的有效时间
@property (nonatomic, strong) NSString *token_type;     ///<token的类型
@property (nonatomic, strong) NSString *scope;          ///<备用字段

@end
