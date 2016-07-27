//
//  BTDataBaseManager.h
//  BiketoRabbit
//
//  Created by BIKETO on 15/6/10.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTDataBaseUserInfo.h"
#import "BTDataBaseTrackFile.h"
#import "BTDataBaseTrackPhoto.h"
#import "BTDataBaseTrackInfo.h"
#import "BTDataBaseUserTrackRelation.h"
#import "BTDataBaseTrackTemp.h"
#import "BTDataBaseTokenInfo.h"
#import "BTDataBaseCurrUserInfo.h"
#import "BTDataBaseSummaryTrackRelation.h"
#import "BTDataBaseSummaryBikeTeamTrackRelation.h"

/**
 *  不支持多线程操作，若需要在其他线程使用，则新建一个Manager对象
 */

@interface BTDataBaseManager : NSObject

+ (BTDataBaseManager *)shareManager;

/**************Token信息操作****************/
#pragma mark - Token信息操作
/**
 *  保存Token，若该Token不存在则自动添加
 *
 *  @param tokenInfo Token信息数据对象
 *
 *  @return 操作是否成功
 */
- (BOOL)saveTokenInfo:(BTDataBaseTokenInfo *)tokenInfo;

/**
 *  通过 user_id 获取Token信息
 *
 *  @param userId 用户id
 *
 *  @return Token信息数据对象
 */
- (BTDataBaseTokenInfo *)getTokenInfoWithUserID:(NSString *)userId;

/**
 *  通过 user_id 删除Token信息
 *
 *  @param userId 用户id
 *
 *  @return 操作是否成功
 */
- (BOOL)deleteTokenInfoWithUserID:(NSString *)userId;

- (BOOL)mergerTokenInfo:(BTDataBaseTokenInfo *)tokenInfo withUserID:(NSString *)userId;

/**************当前用户信息操作****************/
#pragma mark - 当前用户信息操作
/**
 *  保存当前用户资料，若用户不存在则自动添加
 *
 *  @param userInfo 用户信息数据对象
 *
 *  @return 操作是否成功
 */
- (BOOL)saveCurrUserInfo:(BTDataBaseCurrUserInfo *)userInfo;

/**
 *  通过 user_id 获取当前用户信息
 *
 *  @param userId 用户id
 *
 *  @return 用户信息数据对象
 */
- (BTDataBaseCurrUserInfo *)getCurrUserInfoWithUserID:(NSString *)userId;

/**
 *  通过 user_id 删除当前用户信息
 *
 *  @param userId 用户id
 *
 *  @return 操作是否成功
 */
- (BOOL)deleteCurrUserInfoWithUserID:(NSString *)userId;

- (BOOL)mergerCurrUserInfo:(BTDataBaseCurrUserInfo *)userInfo withUserID:(NSString *)userId;

/**************用户信息操作****************/
#pragma mark - 用户信息操作
/**
 *  保存用户资料，若该用户不存在则自动添加
 *
 *  @param userInfo 用户信息数据对象
 *
 *  @return 操作是否成功
 */
- (BOOL)saveUserInfo:(BTDataBaseUserInfo *)userInfo;

/**
 *  通过 user_id 获取用户信息
 *
 *  @param userId 用户id
 *
 *  @return 用户信息数据对象
 */
- (BTDataBaseUserInfo *)getUserInfoWithUserID:(NSString *)userId;

/**
 *  通过 user_id 删除用户信息
 *
 *  @param userId 用户id
 *
 *  @return 操作是否成功
 */
- (BOOL)deleteUserInfoWithUserID:(NSString *)userId;

- (BOOL)mergerUserInfo:(BTDataBaseUserInfo *)userInfo withUserID:(NSString *)userId;

/**************轨迹信息****************/
#pragma mark - 轨迹信息
- (BOOL)saveTrackInfo:(BTDataBaseTrackInfo *)trackInfo;
- (BTDataBaseTrackInfo *)getTrackInfoWithTrackGUID:(NSString *)trackId;

- (NSArray *)getUserUnuploadTrackInfoWithUserId:(NSString *)userId;
- (NSArray *)getUserTrackInfoWithUserId:(NSString *)userId upload:(NSInteger)upload;
//- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange;
- (NSArray *)getAllTrackInfo;
- (BOOL)deleteTrackInfoWithTrackGUID:(NSString *)trackId;
- (BOOL)mergerTrackInfo:(BTDataBaseTrackInfo *)trackInfo;

/**************轨迹用户关联****************/
#pragma mark - 轨迹用户关联
- (BOOL)saveUserTrackRelation:(BTDataBaseUserTrackRelation *)relation;
- (BTDataBaseUserTrackRelation *)getUserTrackRelationWithTrackGUID:(NSString *)trackId;
- (BTDataBaseUserTrackRelation *)getUserTrackRelationWithTrackID:(NSString *)trackId;
- (NSArray *)getUserTrackRelationWithUserID:(NSString *)userId;
- (NSArray *)getAllTrackRelation;
- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare;
- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout;
- (BOOL)deleteUserTrackRelationWithTrackGUID:(NSString *)trackId;

/**************轨迹相片****************/
#pragma mark - 轨迹相片
- (BOOL)saveTrackPhoto:(BTDataBaseTrackPhoto *)relation;
- (void)saveTrackPhotoArray:(NSArray *)photos;
- (NSArray *)getTrackPhotoWithTrackGUID:(NSString *)TrackID;
- (NSArray *)getUnuploadTrackPhotoWithTrackGUID:(NSString *)track_guid;
- (NSArray *)getAllUnuploadTrackPhoto;
- (BOOL)mergerTrackPhoto:(BTDataBaseTrackPhoto *)photo;
- (BOOL)mergerTrackPhoto:(BTDataBaseTrackPhoto *)photo withFileName:(NSString *)fileName;
- (void)mergerTrackPhotoArray:(NSArray *)photoArr;
- (BOOL)deleteTrackPhotoWithTrackGUID:(NSString *)track_guid;
- (BOOL)deleteUploadedTrackPhotoWithTrackGUID:(NSString *)track_guid;
- (BOOL)deleteTrackPhotoWithPhotoId:(NSString *)photoId;
- (BOOL)deleteTrackPhotoWithFileGUID:(NSString *)file_guid;

/**************轨迹文件****************/
#pragma mark - 轨迹文件
- (BOOL)saveTrackFile:(BTDataBaseTrackFile *)trackFile;
- (BTDataBaseTrackFile *)getTrackFileWithTrackGUID:(NSString *)trackId;
- (BOOL)deleteTrackFileWithTrackGUID:(NSString *)trackId;
- (BOOL)mergerTrackFile:(BTDataBaseTrackFile *)trackFile;

/**************临时轨迹****************/
//- (BOOL)saveTrackTempArray:(NSArray *)trackTempArray;
//- (BOOL)saveTrackTemp:(BTDataBaseTrackTemp *)trackTemp;
//- (NSArray *)getTrackTempArray;
//- (NSArray *)getTrackTempArrayWithClass:(Class)objClass;
//- (BOOL)deleteTrackTemp;

/**************我的关注****************/
#pragma mark - 我的关注
//我的关注
- (BOOL)saveSummaryTrackRelation:(BTDataBaseSummaryTrackRelation *)relation;
- (BTDataBaseSummaryTrackRelation *)getSummaryTrackRelationWithTrackGUID:(NSString *)trackId;
- (BTDataBaseSummaryTrackRelation *)getSummaryTrackRelationWithTrackID:(NSString *)trackId;
- (NSArray *)getSummaryTrackRelationWithCurrentUserId:(NSString *)userId;
- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare;
- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout;
- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)current_user_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout;
- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange;
- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)current_user_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange;
- (BOOL)deleteSummaryTrackRelationWithTrackGUID:(NSString *)trackId;

/**************车队轨迹****************/
#pragma mark - 车队轨迹
//车队
- (BOOL)saveSummaryBikeTeamTrackRelation:(BTDataBaseSummaryBikeTeamTrackRelation *)relation;
- (BTDataBaseSummaryBikeTeamTrackRelation *)getSummaryBikeTeamTrackRelationWithTrackGUID:(NSString *)track_guid;
- (BTDataBaseSummaryBikeTeamTrackRelation *)getSummaryBikeTeamTrackRelationWithTrackID:(NSString *)trackId;
- (NSArray *)getSummaryBikeTeamTrackRelationAllArray;
- (NSArray *)getSummaryBikeTeamTrackRelationWithTeamId:(NSString *)team_id;
- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare;
- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout;
- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout;
- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange;
- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange;
- (BOOL)deleteSummaryBikeTeamTrackRelationWithTrackGUID:(NSString *)trackId;

/**************关注动态****************/
#pragma mark - 关注动态
//摘要动态
- (BOOL)insertIntoSummaryDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id;
- (BOOL)saveSummaryDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id;
- (NSArray *)getSummaryDynamicWithUserID:(NSString *)user_id page:(NSInteger)page;
- (NSArray *)getSummaryDynamicAllDataWithUserID:(NSString *)user_id;
- (BOOL)deleteSummaryDynamicAllDataWithUserID:(NSString *)user_id;

/**************车队动态 分页存储****************/
#pragma mark - 车队动态 分页存储

- (BOOL)insertIntoTeamDynamicWithDictionary:(NSDictionary *)object;
- (BOOL)insertIntoTeamDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id teamID:(NSInteger)team_id;
- (NSArray *)getTeamDynamicWithUserID:(NSString *)user_id teamID:(int)team_id page:(NSInteger)page;
- (NSArray *)getTeamDynamicAllDataWithUserID:(NSString *)user_id teamID:(int)team_id;
- (BOOL)deleteTeamDynamicAllDataWithUserID:(NSString *)user_id teamID:(NSInteger)team_id;

#pragma mark - 批量存入摘要轨迹
/**************批量存入摘要轨迹****************/
- (void)saveUserTrackInfoArrayInTransition:(NSArray *)array;
- (void)saveSummaryTrackInfoArrayInTransition:(NSArray *)array;
- (void)saveSummaryBikeTeamTrackInfoArrayTransition:(NSArray *)array;


@end
