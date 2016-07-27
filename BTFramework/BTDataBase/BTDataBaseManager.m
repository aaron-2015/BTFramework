 //
//  BTDataBaseManager.m
//  BiketoRabbit
//
//  Created by BIKETO on 15/6/10.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import "BTDataBaseManager.h"
#import "BTDataBase.h"
#import "NSObject+ObjectMap.h"
#import "BTSummaryTrack.h"
#import "BTSummaryBikeTeamTrack.h"
#import "BTSummaryDynamicUser.h"

@interface BTDataBaseManager ()
{
    BTDataBase *dataBase;
}
@end

@implementation BTDataBaseManager


static BTDataBaseManager *manager = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        dataBase = [BTDataBase createDataBase];
    }
    return self;
}

#pragma mark - Token信息相关

- (BOOL)saveTokenInfo:(BTDataBaseTokenInfo *)tokenInfo
{
    if ([self getTokenInfoWithUserID:tokenInfo.user_id]) {
        return [self mergerTokenInfo:tokenInfo withUserID:tokenInfo.user_id];
    }
    return [dataBase insertDataForTableName:DBName_TokenInfo withObject:tokenInfo];
}

- (BTDataBaseTokenInfo *)getTokenInfoWithUserID:(NSString *)userId
{
    return [dataBase getDataForTableName:DBName_TokenInfo withKey:@"user_id" andValue:userId dataClass:[BTDataBaseTokenInfo class]];
}

- (BOOL)mergerTokenInfo:(BTDataBaseTokenInfo *)userInfo withUserID:(NSString *)userId
{
    return [dataBase mergeDataForTableName:DBName_TokenInfo withObject:userInfo andKey:@"user_id" andValue:userId];
}

- (BOOL)deleteTokenInfoWithUserID:(NSString *)userId
{
    return [dataBase deleteDataForTableName:DBName_TokenInfo withKey:@"user_id" andValue:userId];
}

#pragma mark - 当前用户信息相关操

- (BOOL)saveCurrUserInfo:(BTDataBaseCurrUserInfo *)userInfo
{
    if ([self getCurrUserInfoWithUserID:userInfo.user_id]) {
        return [self mergerCurrUserInfo:userInfo withUserID:userInfo.user_id];
    }
    return [dataBase insertDataForTableName:DBName_CurrUserInfo withObject:userInfo];
}

- (BTDataBaseCurrUserInfo *)getCurrUserInfoWithUserID:(NSString *)userId
{
    return [dataBase getDataForTableName:DBName_CurrUserInfo withKey:@"user_id" andValue:userId dataClass:[BTDataBaseCurrUserInfo class]];
}

- (BOOL)deleteCurrUserInfoWithUserID:(NSString *)userId
{
    return [dataBase deleteDataForTableName:DBName_CurrUserInfo withKey:@"user_id" andValue:userId];
}

- (BOOL)mergerCurrUserInfo:(BTDataBaseCurrUserInfo *)userInfo withUserID:(NSString *)userId
{
    return [dataBase mergeDataForTableName:DBName_CurrUserInfo withObject:userInfo andKey:@"user_id" andValue:userId];
}

#pragma mark - 用户信息相关操

- (BTDataBaseUserInfo *)handleSaveUserInfo:(BTDataBaseUserInfo *)userInfo
{
    BTDataBaseUserInfo *newUserInfo = [userInfo copy];
    [newUserInfo encodeDataBaseUserInfo];
    
    return newUserInfo;
}

- (BOOL)saveUserInfo:(BTDataBaseUserInfo *)userInfo
{
    BTDataBaseUserInfo *newUserInfo = [self handleSaveUserInfo:userInfo];
    if ([self getUserInfoWithUserID:newUserInfo.user_id]) {
        return [self mergerUserInfo:newUserInfo withUserID:newUserInfo.user_id];
    }
    return [dataBase insertDataForTableName:DBName_UserInfo withObject:newUserInfo];
}

- (BTDataBaseUserInfo *)getUserInfoWithUserID:(NSString *)userId
{
    BTDataBaseUserInfo *userInfo = [dataBase getDataForTableName:DBName_UserInfo withKey:@"user_id" andValue:userId dataClass:[BTDataBaseUserInfo class]];
    [userInfo decodeDataBaseUserInfo];
    return userInfo;
}

//- (BTDataBaseUserInfo *)getUserInfoWithUserID:(NSString *)userId
//{
//    return [dataBase getDataForTableName:DBName_UserInfo withKey:@"user_id" andValue:userId dataClass:[BTDataBaseUserInfo class]];
//}

- (BOOL)deleteUserInfoWithUserID:(NSString *)userId
{
    return [dataBase deleteDataForTableName:DBName_UserInfo withKey:@"user_id" andValue:userId];
}

- (BOOL)mergerUserInfo:(BTDataBaseUserInfo *)userInfo withUserID:(NSString *)userId
{
    return [dataBase mergeDataForTableName:DBName_UserInfo withObject:userInfo andKey:@"user_id" andValue:userId];
}

#pragma mark 轨迹信息

- (BOOL)saveTrackInfo:(BTDataBaseTrackInfo *)trackInfoData
{
//    [self saveTrackFile:trackInfoData.trackFile];
//    [self saveTrackPhotoArray:trackInfoData.trackPhotos];
    
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[trackInfoData objectDictionary]];
//    [obj removeObjectForKey:@"trackFile"];
//    [obj removeObjectForKey:@"trackPhotos"];
//    [obj removeObjectForKey:@"userInfo"];
    NSDictionary *kv = [dataBase getInsertKeysValuesStringByParam:obj];
    NSString *kvStr = [kv objectForKey:@"query"];
    NSArray *arg = [kv objectForKey:@"argument"];
    
    return [dataBase insertDataForTableName:DBName_TrackInfo withKeyValueString:kvStr andArgument:arg];
}

- (NSArray *)getUserUnuploadTrackInfoWithUserId:(NSString *)userId
{
    NSString *query = [NSString stringWithFormat:@"left join %@ on %@.track_guid = %@.track_guid",  DBName_UserTrackRelation,DBName_TrackInfo, DBName_UserTrackRelation];
    if (userId) {
        query = [query stringByAppendingFormat:@" where user_id = '%@'", userId];
    }
    
    query = [query stringByAppendingString:@" and upload = 0"];
    
    NSString *orderKey = @"end_time";
    if (orderKey.length) {
        query = [query stringByAppendingFormat:@" order by %@ desc", orderKey];
    }
    
    return [dataBase getDataArrayForTableName:DBName_TrackInfo dataClass:[BTDataBaseTrackInfo class] conditionQuery:query];
}

//新添加查询本地轨迹的方法（根据轨迹的upload标记查找：已上传／冲突／本地／正在上传中）
- (NSArray *)getUserTrackInfoWithUserId:(NSString *)userId upload:(NSInteger)upload
{
    NSString *query = [NSString stringWithFormat:@"left join %@ on %@.track_guid = %@.track_guid",  DBName_UserTrackRelation, DBName_TrackInfo, DBName_UserTrackRelation];
    if (userId) {
        query = [query stringByAppendingFormat:@" where user_id = '%@'", userId];
    }
    
    query = [query stringByAppendingFormat:@" and upload = %d", (int)upload];
    
    NSString *orderKey = @"end_time";
    if (orderKey.length) {
        query = [query stringByAppendingFormat:@" order by %@ desc", orderKey];
    }
    
    return [dataBase getDataArrayForTableName:DBName_TrackInfo dataClass:[BTDataBaseTrackInfo class] conditionQuery:query];
}

- (BTDataBaseTrackInfo *)getTrackInfoWithTrackGUID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_TrackInfo withKey:@"track_guid" andValue:trackId dataClass:[BTDataBaseTrackInfo class]];
}


/******** 因为 UserTrackRelation 这个表中没有存储endtime！ ********/
//- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange
//{
//    NSString *query = [NSString string];
//    query = [query stringByAppendingFormat:@"where user_id = '%@'", userId];
//    if (endTimeRange.location && endTimeRange.length) {
//        query = [query stringByAppendingFormat:@" and endtime >= %d and endtime <= %d", (int)endTimeRange.location, (int)(endTimeRange.location + endTimeRange.length)];
//    }
//    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation dataClass:[BTDataBaseUserTrackRelation class] conditionQuery:query];
//}

- (NSArray *)getAllTrackInfo
{
    return [dataBase getDataArrayForTableName:DBName_TrackInfo withKey:nil andValue:nil dataClass:[BTDataBaseTrackInfo class]];
}

- (BOOL)deleteTrackInfoWithTrackGUID:(NSString *)trackId
{
    return [dataBase deleteDataForTableName:DBName_TrackInfo withKey:@"track_guid" andValue:trackId];
}

- (BOOL)mergerTrackInfo:(BTDataBaseTrackInfo *)trackInfo
{
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[trackInfo objectDictionary]];
//    [obj removeObjectForKey:@"trackFile"];
//    [obj removeObjectForKey:@"trackPhotos"];
//    [obj removeObjectForKey:@"userInfo"];

    BTDataBaseTrackInfo *info = [[BTDataBaseTrackInfo alloc]initWithDictionary:obj];
    
    return [dataBase mergeDataForTableName:DBName_TrackInfo withObject:info andKey:@"track_guid" andValue:trackInfo.track_guid];
}

#pragma mark - 轨迹用户关联

- (BOOL)saveUserTrackRelation:(BTDataBaseUserTrackRelation *)relation
{
    return [dataBase insertDataForTableName:DBName_UserTrackRelation withObject:relation];
}

- (BTDataBaseUserTrackRelation *)getUserTrackRelationWithTrackGUID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_UserTrackRelation withKey:@"track_guid" andValue:trackId dataClass:[BTDataBaseUserTrackRelation class]];
}

- (BTDataBaseUserTrackRelation *)getUserTrackRelationWithTrackID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_UserTrackRelation withKey:@"track_id" andValue:trackId dataClass:[BTDataBaseUserTrackRelation class]];
}

- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare
{
//    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:@"user_id" andValue:userId dataClass:[BTDataBaseSummaryTrackRelation class] orderType:compare orderKey:@"starttime"];
    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:@"user_id" andValue:userId dataClass:[BTDataBaseUserTrackRelation class] orderType:compare orderKey:@"starttime"];
}

- (NSArray *)getUserTrackRelationArrayWithUserId:(NSString *)userId orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout
{
//    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:@"user_id" andValue:userId dataClass:[BTDataBaseSummaryTrackRelation class] orderType:compare orderKey:@"starttime" page:page count:cout];
    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:@"user_id" andValue:userId dataClass:[BTDataBaseUserTrackRelation class] orderType:compare orderKey:@"starttime" page:page count:cout];
}


- (NSArray *)getUserTrackRelationWithUserID:(NSString *)userId
{
    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:@"user_id" andValue:userId dataClass:[BTDataBaseUserTrackRelation class]];
}

- (NSArray *)getAllTrackRelation
{
    return [dataBase getDataArrayForTableName:DBName_UserTrackRelation withKey:nil andValue:nil dataClass:[BTDataBaseUserTrackRelation class]];
}

- (BOOL)deleteUserTrackRelationWithTrackGUID:(NSString *)trackguid
{
    return [dataBase deleteDataForTableName:DBName_UserTrackRelation withKey:@"track_guid" andValue:trackguid];
}

#pragma mark 临时轨迹

- (BOOL)saveTrackTempArray:(NSArray *)trackTempArray
{
    return [dataBase insertDataForTableName:DBName_TrackTemp withObjectArray:trackTempArray];
}

- (BOOL)saveTrackTemp:(BTDataBaseTrackTemp *)trackTempData
{
    return [dataBase insertDataForTableName:DBName_TrackTemp withObject:trackTempData];
}

- (NSArray *)getTrackTempArray
{
//    return [self getDataArrayForTableName:DBName_TrackTemp withKey:nil andValue:nil dataClass:[BTDataBaseTrackTemp class]];
    return [self getTrackTempArrayWithClass:[BTDataBaseTrackTemp class]];
}

- (NSArray *)getTrackTempArrayWithClass:(Class)objClass
{
    return [dataBase getDataArrayForTableName:DBName_TrackTemp withKey:nil andValue:nil dataClass:objClass];
}

- (BOOL)deleteTrackTemp
{
    BOOL work1 = NO, work2 = NO;
    
    work1 = [dataBase executeUpdate:[NSString stringWithFormat:@"delete from %@",DBName_TrackTemp]];
    
    work2 = [dataBase executeUpdate:[NSString stringWithFormat:@"update sqlite_sequence set seq=0 where name='%@'",DBName_TrackTemp]];
//    if ([dataBase open]) {
//        work = [dataBase executeUpdate:[NSString stringWithFormat:@"delete from %@",DBName_TrackTemp]];
//        
//        work = [dataBase executeUpdate:[NSString stringWithFormat:@"update sqlite_sequence set seq=0 where name='%@'",DBName_TrackTemp]];
//    }
    return work1 && work2;
}

#pragma mark - 轨迹相片

- (BOOL)saveTrackPhoto:(BTDataBaseTrackPhoto *)photo
{
    return [dataBase insertDataForTableName:DBName_TrackPhoto withObject:photo];
}

- (void)saveTrackPhotoArray:(NSArray *)photos
{
    [dataBase inTransitionWithBlock:^(FMDatabase *db, BOOL *rollback) {
        for (BTDataBaseTrackPhoto *photo in photos) {
            [dataBase inTransitionInsertForTableName:DBName_TrackPhoto withObject:photo withDataBase:db];
        }
    }];
}

- (BOOL)mergerTrackPhoto:(BTDataBaseTrackPhoto *)photo
{
    return [dataBase mergeDataForTableName:DBName_TrackPhoto withObject:photo andKey:@"file_guid" andValue:photo.file_guid];
}

- (BOOL)mergerTrackPhoto:(BTDataBaseTrackPhoto *)photo withFileName:(NSString *)fileName;
{
    return [dataBase mergeDataForTableName:DBName_TrackPhoto withObject:photo andKey:@"file_name" andValue:fileName];
}

- (void)mergerTrackPhotoArray:(NSArray *)photoArr
{
    [dataBase inTransitionWithBlock:^(FMDatabase *db, BOOL *rollback) {
        for (BTDataBaseTrackPhoto *photo in photoArr) {
            [dataBase inTransitionMergerForTableName:DBName_TrackPhoto withObject:photo withDataBase:db key:@"file_guid" value:photo.file_guid];
        }
    }];
}

- (NSArray *)getTrackPhotoWithTrackGUID:(NSString *)TrackID
{
    return [dataBase getDataArrayForTableName:DBName_TrackPhoto withKey:@"track_guid" andValue:TrackID dataClass:[BTDataBaseTrackPhoto class] orderType:NSOrderedAscending orderKey:@"time"];
}

- (NSArray *)getUnuploadTrackPhotoWithTrackGUID:(NSString *)track_guid
{
    NSString *query = @"";
    if (track_guid) {
        query = [query stringByAppendingFormat:@" where track_guid = '%@'", track_guid];
    }
    
    query = [query stringByAppendingString:@" and upload = 0"];
    query = [query stringByAppendingString:@" and track_id != ''"];

    NSString *orderKey = @"time";
    if (orderKey.length) {
        query = [query stringByAppendingFormat:@" order by %@ asc", orderKey];
    }
    
    return [dataBase getDataArrayForTableName:DBName_TrackPhoto dataClass:[BTDataBaseTrackPhoto class] conditionQuery:query];
}

- (NSArray *)getAllUnuploadTrackPhoto
{
    NSString *query = @"where";
    
    query = [query stringByAppendingString:@" upload = 0"];
    query = [query stringByAppendingString:@" and track_id != ''"];
    
    NSString *orderKey = @"time";
    if (orderKey.length) {
        query = [query stringByAppendingFormat:@" order by %@ desc", orderKey];
    }
    
    return [dataBase getDataArrayForTableName:DBName_TrackPhoto dataClass:[BTDataBaseTrackPhoto class] conditionQuery:query];
}

- (BOOL)deleteTrackPhotoWithTrackGUID:(NSString *)trackId
{
    return [dataBase deleteDataForTableName:DBName_TrackPhoto withKey:@"track_guid" andValue:trackId];
}

- (BOOL)deleteUploadedTrackPhotoWithTrackGUID:(NSString *)track_guid
{
    return [dataBase deleteDataForTableName:DBName_TrackPhoto withKeys:@[@"track_guid", @"upload"] andValue:@[track_guid, @(1)]];
}

- (BOOL)deleteTrackPhotoWithPhotoId:(NSString *)photoId
{
    return [dataBase deleteDataForTableName:DBName_TrackPhoto withKey:@"photo_id" andValue:photoId];
}

- (BOOL)deleteTrackPhotoWithFileGUID:(NSString *)file_guid
{
    return [dataBase deleteDataForTableName:DBName_TrackPhoto withKey:@"file_guid" andValue:file_guid];
}

#pragma mark - 轨迹文件

- (BOOL)saveTrackFile:(BTDataBaseTrackFile *)trackFile
{
    return [dataBase insertDataForTableName:DBName_TrackFile withObject:trackFile];
}

- (BTDataBaseTrackFile *)getTrackFileWithTrackGUID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_TrackFile withKey:@"track_guid" andValue:trackId dataClass:[BTDataBaseTrackFile class]];
}

- (BOOL)deleteTrackFileWithTrackGUID:(NSString *)trackId
{
    return [dataBase deleteDataForTableName:DBName_TrackFile withKey:@"track_guid" andValue:trackId];
}

- (BOOL)mergerTrackFile:(BTDataBaseTrackFile *)trackFile
{
    return [dataBase mergeDataForTableName:DBName_TrackFile withObject:trackFile andKey:@"track_guid" andValue:trackFile.track_guid];
}

#pragma mark - 摘要列表

//我的关注
- (BOOL)saveSummaryTrackRelation:(BTDataBaseSummaryTrackRelation *)relation
{
    return [dataBase insertDataForTableName:DBName_Summary_TrackRelation withObject:relation];
}

- (BTDataBaseSummaryTrackRelation *)getSummaryTrackRelationWithTrackGUID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_Summary_TrackRelation withKey:@"track_guid" andValue:trackId dataClass:[BTDataBaseSummaryTrackRelation class]];
}

- (BTDataBaseSummaryTrackRelation *)getSummaryTrackRelationWithTrackID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_Summary_TrackRelation withKey:@"track_id" andValue:trackId dataClass:[BTDataBaseSummaryTrackRelation class]];
}

- (NSArray *)getSummaryTrackRelationWithCurrentUserId:(NSString *)userId
{
    return [self getSummaryTrackRelationArrayWithCurrentUserId:userId orderType:NSOrderedDescending];
}

- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare
{
    return [dataBase getDataArrayForTableName:DBName_Summary_TrackRelation withKey:@"current_user_id" andValue:userId dataClass:[BTDataBaseSummaryTrackRelation class] orderType:compare orderKey:@"endtime"];
}

- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout
{
    return [dataBase getDataArrayForTableName:DBName_Summary_TrackRelation withKey:@"current_user_id" andValue:userId dataClass:[BTDataBaseSummaryTrackRelation class] orderType:compare orderKey:@"endtime" page:page count:cout];
}

- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)current_user_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout
{
    NSString *query = [NSString string];
    query = [query stringByAppendingFormat:@"where current_user_id = '%@'", current_user_id];
    if (user_id.intValue) {
        query = [query stringByAppendingFormat:@"and user_id = '%@'", user_id];
    }
    NSString *orderKey = @"endtime";
    if (orderKey.length) {
        switch (compare) {
            case NSOrderedAscending: {
                query = [query stringByAppendingFormat:@" order by %@ asc", orderKey];
                break;
            }
            case NSOrderedSame: {
                break;
            }
            case NSOrderedDescending: {
                query = [query stringByAppendingFormat:@" order by %@ desc", orderKey];
                break;
            }
            default: {
                break;
            }
        }
    }
    
    if (page && cout) {
        query = [query stringByAppendingFormat:@" limit %d offset %d", (int)cout, (int)((page - 1) * cout)];
    }
    
    return [dataBase getDataArrayForTableName:DBName_Summary_TrackRelation dataClass:[BTDataBaseSummaryTrackRelation class] conditionQuery:query];
}

- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)userId orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange
{
    return [self getSummaryTrackRelationArrayWithCurrentUserId:userId userId:nil orderType:compare endTimeRange:endTimeRange];
}

- (NSArray *)getSummaryTrackRelationArrayWithCurrentUserId:(NSString *)current_user_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange
{
    NSString *query = [NSString string];
    query = [query stringByAppendingFormat:@"where current_user_id = '%@'", current_user_id];
    if (user_id.intValue) {
        query = [query stringByAppendingFormat:@"and user_id = '%@'", user_id];
    }
    if (endTimeRange.location && endTimeRange.length) {
        query = [query stringByAppendingFormat:@" and endtime >= %d and endtime <= %d", (int)endTimeRange.location, (int)(endTimeRange.location + endTimeRange.length)];
    }
    return [dataBase getDataArrayForTableName:DBName_Summary_TrackRelation dataClass:[BTDataBaseSummaryTrackRelation class] conditionQuery:query];
}

- (BOOL)deleteSummaryTrackRelationWithTrackGUID:(NSString *)trackId
{
    return [dataBase deleteDataForTableName:DBName_Summary_TrackRelation withKey:@"track_guid" andValue:trackId];
}

#pragma mark - 车队

- (BOOL)saveSummaryBikeTeamTrackRelation:(BTDataBaseSummaryBikeTeamTrackRelation *)relation
{
    return [dataBase insertDataForTableName:DBName_Summary_BikeTeamTrackRelation withObject:relation];
}

- (BTDataBaseSummaryBikeTeamTrackRelation *)getSummaryBikeTeamTrackRelationWithTrackGUID:(NSString *)track_guid
{
    return [dataBase getDataForTableName:DBName_Summary_BikeTeamTrackRelation withKey:@"track_guid" andValue:track_guid dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class]];
}

- (BTDataBaseSummaryBikeTeamTrackRelation *)getSummaryBikeTeamTrackRelationWithTrackID:(NSString *)trackId
{
    return [dataBase getDataForTableName:DBName_Summary_BikeTeamTrackRelation withKey:@"track_id" andValue:trackId dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class]];
}

- (NSArray *)getSummaryBikeTeamTrackRelationAllArray
{
    return [dataBase getDataArrayForTableName:DBName_Summary_BikeTeamTrackRelation withKey:nil andValue:nil dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class] orderType:NSOrderedDescending orderKey:@"endtime"];
}

- (NSArray *)getSummaryBikeTeamTrackRelationWithTeamId:(NSString *)team_id
{
    return [self getSummaryBikeTeamTrackRelationArrayWithTeamId:team_id orderType:NSOrderedDescending];
}

- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare
{
    return [dataBase getDataArrayForTableName:DBName_Summary_BikeTeamTrackRelation withKey:@"team_id" andValue:team_id dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class] orderType:compare orderKey:@"endtime"];
}

- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout
{
    return [dataBase getDataArrayForTableName:DBName_Summary_BikeTeamTrackRelation withKey:@"team_id" andValue:team_id dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class] orderType:compare orderKey:@"endtime" page:page count:cout];
}

- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare page:(NSInteger)page count:(NSInteger)cout
{
    NSString *query = [NSString string];
    query = [query stringByAppendingFormat:@"where team_id = '%@'", team_id];
    if (user_id.intValue) {
        query = [query stringByAppendingFormat:@"and user_id = '%@'", user_id];
    }
    NSString *orderKey = @"endtime";
    if (orderKey.length) {
        switch (compare) {
            case NSOrderedAscending: {
                query = [query stringByAppendingFormat:@" order by %@ asc", orderKey];
                break;
            }
            case NSOrderedSame: {
                break;
            }
            case NSOrderedDescending: {
                query = [query stringByAppendingFormat:@" order by %@ desc", orderKey];
                break;
            }
            default: {
                break;
            }
        }
    }
    
    if (page && cout) {
        query = [query stringByAppendingFormat:@" limit %d offset %d", (int)cout, (int)((page - 1) * cout)];
    }
    
    return [dataBase getDataArrayForTableName:DBName_Summary_BikeTeamTrackRelation dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class] conditionQuery:query];
}

- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange
{
    return [self getSummaryBikeTeamTrackRelationArrayWithTeamId:team_id userId:nil orderType:compare endTimeRange:endTimeRange];
}

- (NSArray *)getSummaryBikeTeamTrackRelationArrayWithTeamId:(NSString *)team_id userId:(NSString *)user_id orderType:(NSComparisonResult)compare endTimeRange:(NSRange)endTimeRange
{
    NSString *query = [NSString string];
    query = [query stringByAppendingFormat:@"where team_id = '%@'", team_id];
    if (user_id.intValue) {
        query = [query stringByAppendingFormat:@"and user_id = '%@'", user_id];
    }
    if (endTimeRange.location && endTimeRange.length) {
        query = [query stringByAppendingFormat:@" and endtime >= %d and endtime <= %d", (int)endTimeRange.location, (int)(endTimeRange.location + endTimeRange.length)];
    }
    return [dataBase getDataArrayForTableName:DBName_Summary_BikeTeamTrackRelation dataClass:[BTDataBaseSummaryBikeTeamTrackRelation class] conditionQuery:query];
}

- (BOOL)deleteSummaryBikeTeamTrackRelationWithTrackGUID:(NSString *)trackId
{
    return [dataBase deleteDataForTableName:DBName_Summary_BikeTeamTrackRelation withKey:@"track_guid" andValue:trackId];
}

#pragma mark - 摘要动态 分页存储

- (BOOL)insertIntoSummaryDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id
{
    NSDictionary *object = @{@"user_id":user_id, @"page":@(page), @"data":pageData};
    return [dataBase insertDataForTableName:DBName_Summary_Dynamic withObject:object];
}

- (BOOL)saveSummaryDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id
{
    NSDictionary *object = @{@"user_id":user_id, @"page":@(page), @"data":pageData};
    return [dataBase mergeDataForTableName:DBName_Summary_Dynamic withObject:object andKey:@"user_id" andValue:user_id];
}

- (NSArray *)getSummaryDynamicWithUserID:(NSString *)user_id page:(NSInteger)page
{
    NSString *conditionQuery = [NSString stringWithFormat:@"where user_id = %@  and page = %ld", user_id, page];
    return [dataBase getDataArrayForTableName:DBName_Summary_Dynamic dataClass:[NSDictionary class] conditionQuery:conditionQuery];
}

- (NSArray *)getSummaryDynamicAllDataWithUserID:(NSString *)user_id
{
    return [dataBase getDataArrayForTableName:DBName_Summary_Dynamic withKey:@"user_id" andValue:user_id dataClass:[NSDictionary class]];
}

- (BOOL)deleteSummaryDynamicAllDataWithUserID:(NSString *)user_id
{
    return [dataBase deleteDataForTableName:DBName_Summary_Dynamic withKey:@"user_id" andValue:user_id];
}

/*******************/

#pragma mark - 车队动态 分页存储

- (BOOL)insertIntoTeamDynamicWithDictionary:(NSDictionary *)object;
{
    return [dataBase insertDataForTableName:DBName_Team_Dynamic withObject:object];
}

- (BOOL)insertIntoTeamDynamicWithPageData:(NSData *)pageData page:(NSInteger)page userID:(NSString *)user_id teamID:(NSInteger)team_id
{
//    NSDictionary *object = @{@"user_id":user_id, @"team_id":@(team_id), @"page":@(page), @"data":pageData};
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    DICT_PUT(object, @"user_id", user_id);
    DICT_PUT(object, @"team_id", @(team_id));
    DICT_PUT(object, @"page", @(page));
    DICT_PUT(object, @"data", pageData);
    return [dataBase insertDataForTableName:DBName_Team_Dynamic withObject:object];
}

//- (BOOL)saveTeamDynamicWithDictionary:(NSDictionary *)object page:(NSInteger)page userID:(NSString *)user_id
//{
//    return [dataBase mergeDataForTableName:DBName_Team_Dynamic withObject:object andKey:@"user_id" andValue:user_id];
//}

- (NSArray *)getTeamDynamicWithUserID:(NSString *)user_id teamID:(int)team_id page:(NSInteger)page
{
//    return [dataBase getDataArrayForTableName:DBName_Team_Dynamic withKey:@"user_id" andValue:user_id dataClass:[NSDictionary class]];
    NSString *conditionQuery = [NSString stringWithFormat:@"where user_id = %@ and team_id = %d and page = %ld", user_id, team_id, page];
    return [dataBase getDataArrayForTableName:DBName_Team_Dynamic dataClass:[NSDictionary class] conditionQuery:conditionQuery];
}

- (NSArray *)getTeamDynamicAllDataWithUserID:(NSString *)user_id teamID:(int)team_id
{
//    return [dataBase getDataArrayForTableName:DBName_Team_Dynamic withKey:@"user_id" andValue:user_id dataClass:[NSDictionary class]];
    NSString *conditionQuery = [NSString stringWithFormat:@"where user_id = %@ and team_id = %d", user_id, team_id];
    return [dataBase getDataArrayForTableName:DBName_Team_Dynamic dataClass:[NSDictionary class] conditionQuery:conditionQuery];
}

- (BOOL)deleteTeamDynamicAllDataWithUserID:(NSString *)user_id teamID:(NSInteger)team_id
{
    return [dataBase deleteDataForTableName:DBName_Team_Dynamic withKeys:@[@"user_id", @"team_id"] andValue:@[user_id, @(team_id)]];
}

#pragma mark - 批量处理

/************************ 事务 ***********************/

- (void)saveUserTrackInfoArrayInTransition:(NSArray *)array {
    [dataBase inTransitionWithBlock:^(FMDatabase *db, BOOL *rollback) {
        for (BTTrack * track in array) {
            [dataBase inTransitionInsertForTableName:DBName_UserTrackRelation withObject:track.userTrackRelation withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackInfo withObject:track.trackInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackFile withObject:track.trackFile withDataBase:db];
//            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:track.userInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:[self handleSaveUserInfo:track.userInfo] withDataBase:db];
            for (BTDataBaseTrackPhoto * photo in track.trackPhotoArr) {
                [dataBase inTransitionInsertForTableName:DBName_TrackPhoto withObject:photo withDataBase:db];
            }
        }
    }];
}

- (void)saveSummaryTrackInfoArrayInTransition:(NSArray *)array
{
    [dataBase inTransitionWithBlock:^(FMDatabase *db, BOOL *rollback) {
        for (BTSummaryTrack * track in array) {
            [dataBase inTransitionInsertForTableName:DBName_Summary_TrackRelation withObject:track.summaryTrackRelation withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackInfo withObject:track.trackInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackFile withObject:track.trackFile withDataBase:db];
//            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:track.userInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:[self handleSaveUserInfo:track.userInfo] withDataBase:db];
            for (BTDataBaseTrackPhoto * photo in track.trackPhotoArr) {
                [dataBase inTransitionInsertForTableName:DBName_TrackPhoto withObject:photo withDataBase:db];
            }
        }
    }];
}

- (void)saveSummaryBikeTeamTrackInfoArrayTransition:(NSArray *)array
{
    [dataBase inTransitionWithBlock:^(FMDatabase *db, BOOL *rollback) {
        for (BTSummaryBikeTeamTrack * track in array) {
            [dataBase inTransitionInsertForTableName:DBName_Summary_BikeTeamTrackRelation withObject:track.bikeTeamTrackRelation withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackInfo withObject:track.trackInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_TrackFile withObject:track.trackFile withDataBase:db];
//            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:track.userInfo withDataBase:db];
            [dataBase inTransitionInsertForTableName:DBName_UserInfo withObject:[self handleSaveUserInfo:track.userInfo] withDataBase:db];
            for (BTDataBaseTrackPhoto * photo in track.trackPhotoArr) {
                [dataBase inTransitionInsertForTableName:DBName_TrackPhoto withObject:photo withDataBase:db];
            }
        }
    }];
}

/***********************************************/
@end
