//
//  BTDataBase.m
//  BiketoRabbit
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import "BTDataBase.h"
#import "NSObject+BTObjectMap.h"
#import <YYModel/YYModel.h>

#define DATABASE_VERSION_KEY @"database_version"

static NSString * const DB_Version = @"1.0.2"; //app_version:1.0.0

@interface BTDataBase () {
    FMDatabaseQueue *databaseQueue;
}
@end

@implementation BTDataBase

+ (instancetype) createDataBase {
    BTDataBase *database = [[BTDataBase alloc] init];
    return database;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initDataBase];
        [self checkDBVersion];
    }
    return self;
}

#pragma mark - 检查数据库是否需要升级

- (void)checkDBVersion {
    self.version = [self getLocalVersion];
    if (![self.version isEqualToString:DB_Version]) {
        [self updateDataBase];
        [self setVersion:DB_Version];
    }
}

- (void)updateDataBase {

    [self updateVersion_0_8_7_2];
    [self updateVersion_0_1_0_2];
}

//添加用户缓存数据
- (void)updateVersion_0_8_7_2 {
    [databaseQueue inDatabase:^(FMDatabase *db) {
        //我的装备列表
        NSMutableString *query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"my_equipment_list_data", @"BLOB"];
        [db executeUpdate:query];
        
        //产品库列表
        query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"brand_list_data", @"BLOB"];
        [db executeUpdate:query];
        
        //成就与勋章列表
        query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"achievement_medal_data", @"BLOB"];
        [db executeUpdate:query];
    }];
}

//添加用户年份，1.0.2版本升级
- (void)updateVersion_0_1_0_2 {
    [databaseQueue inDatabase:^(FMDatabase *db) {
        
        NSMutableString *query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"userYear", @"varchar(255)"];
        [db executeUpdate:query];
    }];
}

//update语句示例
//NSString * query = @"ALTER TABLE **(表名称) ADD ***（新加字段）VARCHA(32)";
//
//操作如下：
//[databaseQueue inDatabase:^(FMDatabase *db) {
//    NSMutableString *query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"team_list_data", @"BLOB"];
//    [db executeUpdate:query];
//    query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_follows", @"INTEGER DEFAULT 0"];
//    [db executeUpdate:query];
//    query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_fans", @"INTEGER DEFAULT 0"];
//    [db executeUpdate:query];
//    query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_currTeamID", @"INTEGER DEFAULT 0"];
//    [db executeUpdate:query];
//}];

//- (void)updateVersion_0_8_0 {
//    [databaseQueue inDatabase:^(FMDatabase *db) {
//        NSMutableString *query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_TrackInfo, @"altitudeType", @"INTEGER DEFAULT 0"];
//        [db executeUpdate:query];
//    }];
//}

//- (void)updateVersion_0_8_4 {
//    [databaseQueue inDatabase:^(FMDatabase *db) {
//        NSMutableString *query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"team_list_data", @"BLOB"];
//        [db executeUpdate:query];
//        query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_follows", @"INTEGER DEFAULT 0"];
//        [db executeUpdate:query];
//        query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_fans", @"INTEGER DEFAULT 0"];
//        [db executeUpdate:query];
//        query = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", DBName_CurrUserInfo, @"user_currTeamID", @"INTEGER DEFAULT 0"];
//        [db executeUpdate:query];
//    }];
//}

#pragma mark - 初始化数据库

- (void)initDataBase {
    databaseQueue = [self getDatabaseQueueWithName:@"DBFile"];
    
    //TokenInfo Data
    [self createTableWithName:DBName_TokenInfo sqlString:[NSString stringWithFormat:@"CREATE TABLE %@ (user_id varchar(255) PRIMARY KEY NOT NULL, access_token varchar(255), refresh_token varchar(255), expires_in long, timestame long, token_type varchar(255), scope varchar(255))",DBName_TokenInfo]];
    
    //CurrUserInfo
    [self createTableWithName:DBName_CurrUserInfo sqlString:[NSString stringWithFormat:@"CREATE TABLE %@ (user_id varchar(255) PRIMARY KEY NOT NULL, user_data BLOB, user_info BLOB, user_follows integer DEFAULT 0, user_fans integer DEFAULT 0, user_currTeamID integer DEFAULT 0, team_list_data BLOB)",DBName_CurrUserInfo]];
    
//    //UserInfo
//    [self createTableWithName:DBName_UserInfo sqlString:[NSString stringWithFormat:@"CREATE TABLE %@ (user_id varchar(255) PRIMARY KEY NOT NULL, user_name varchar(255), avatar varchar(255), city varchar(255), province varchar(255), geo varchar(255), region varchar(255), sex varchar(32))",DBName_UserInfo]];
}

- (FMDatabase *)getDataBaseWithName:(NSString *)name
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:[documentPath stringByAppendingFormat:@"/%@.sqlite",name]];
    
    LOGD(@"db path:%@",documentPath);
    
    return db;
}

- (FMDatabaseQueue *)getDatabaseQueueWithName:(NSString *)name
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:[documentPath stringByAppendingFormat:@"/%@.sqlite",name]];
    
    LOGD(@"db path:%@",documentPath);
    
    return dbQueue;
}

- (BOOL)createTableWithName:(NSString *)name sqlString:(NSString *)sql
{
    __block BOOL work = NO;
    
    [databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",name]];
        
        [set next];
        
        NSInteger count = [set intForColumnIndex:0];
        
        [set close];
        
        BOOL existTable = !!count;
        
        if (existTable) {
            // 是否更新数据库
        } else {
            // 插入新的数据库
            work = [db executeUpdate:sql];
            
            //            return res;
        }
    }];
    
    return work;
}

-(BOOL)checkName:(NSString *)name{
    
    __block BOOL exist = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",name]];
        
        [set next];
        
        NSInteger count = [set intForColumnIndex:0];
        
        [set close];
        
        BOOL existTable = !!count;
        exist = existTable;
        
    }];
    return exist;
}
#pragma mark - 版本号存储 version

- (void)setVersion:(NSString *)version {
    if (version && ![version isEqualToString:EMPTY_STRING]) {
        _version = version;
        [self saveLocalVersion];
    }
}

- (void)saveLocalVersion {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:_version forKey:DATABASE_VERSION_KEY];
}

- (void)removeLocalVersion {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DATABASE_VERSION_KEY];
}

- (NSString *)getLocalVersion {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _version = [defaults objectForKey:DATABASE_VERSION_KEY];
    
    if (!_version) {
        _version = @"1.0";
    }
    
    return _version;
}


#pragma mark - 通用方法

- (NSDictionary *)getInsertKeysValuesStringByParam:(NSDictionary *)dic {
    NSMutableString *keys = [NSMutableString stringWithString:@"("];
    NSMutableString *values = [NSMutableString stringWithString:@"("];
    NSMutableArray *argument = [NSMutableArray arrayWithCapacity:[dic allKeys].count];
    for (NSString *key in dic.allKeys) {
        NSObject *obj = [dic objectForKey:key];
        if (![obj isKindOfClass:[NSNull class]]) {
            [keys appendFormat:@"%@,",key];
            [values appendFormat:@"?,"];
            [argument addObject:obj];
        }
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    NSString * result = [NSString stringWithFormat:@" %@ values%@",
                         [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
                         [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
//    LOGD(@"Insert %@",result);
    NSDictionary *res = [NSDictionary dictionaryWithObjectsAndKeys:result, @"query", argument, @"argument", nil];
    return res;
}

- (NSString *)getMergeKeysValusStringByParam:(NSDictionary *)dic {
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < dic.allKeys.count; i++) {
        NSString *key = [dic.allKeys objectAtIndex:i];
        if ([dic objectForKey:key]) {
            NSString *k = [NSString stringWithFormat:@"%@ = :%@",key,key];
            [result appendString:k];
        }
        if (i < dic.allKeys.count - 1) {
            [result appendString:@","];
        }
    }
    
    return result;
}

- (BOOL)mergeDataForTableName:(NSString *)tableName withObject:(id)object andKey:(NSString *)key andValue:(id)value {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *query = [NSString stringWithFormat:@"update %@ set %@ where %@ = ", tableName, [self getMergeKeysValusStringByParam:[object objectDictionary]], key];
        query = [value isKindOfClass:[NSString class]] ? [query stringByAppendingFormat:@"'%@'",value] : [query stringByAppendingFormat:@"%@",value];
        work = [db executeUpdate:query withParameterDictionary:[object objectDictionary]];
    }];
    return work;
}

- (BOOL)insertDataForTableName:(NSString *)tableName withObjectArray:(NSArray *)objectArr {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        for (id object in objectArr) {
            NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[object objectDictionary]];
            NSDictionary *kv = [self getInsertKeysValuesStringByParam:obj];
            NSString *kvStr = [kv objectForKey:@"query"];
            NSArray *arg = [kv objectForKey:@"argument"];
            NSMutableString *query = [NSMutableString stringWithFormat:@"replace into %@",tableName];
            [query appendFormat:@"%@", kvStr];
            work = [db executeUpdate:query withArgumentsInArray:arg];
            LOGD(@"insert %@ : %@", tableName, work ? @"succeed" : @"fail");
            if (!work) {
                break;
            }
        }
    }];
    return work;
}

- (BOOL)insertDataForTableName:(NSString *)tableName withObject:(id)object {
    if (!object) {
        return NO;
    }
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[object objectDictionary]];
    NSDictionary *kv = [self getInsertKeysValuesStringByParam:obj];
    NSString *kvStr = [kv objectForKey:@"query"];
    NSArray *arg = [kv objectForKey:@"argument"];
    return [self insertDataForTableName:tableName withKeyValueString:kvStr andArgument:arg];
}

- (BOOL)insertDataForTableName:(NSString *)tableName withKeyValueString:(NSString *)kvStr andArgument:(NSArray *)arg {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        NSMutableString *query = [NSMutableString stringWithFormat:@"replace into %@",tableName];
        [query appendFormat:@"%@", kvStr];
        work = [db executeUpdate:query withArgumentsInArray:arg];
        LOGD(@"insert %@ : %@", tableName, work ? @"succeed" : @"fail");
    }];
    return work;
}

- (id)getDataForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class {
    FMResultSet *set = [self getResultSetForTableName:tableName withKey:key andValue:value];
    id obj = nil;
    if ([set next]) {
        obj = [class yy_modelWithDictionary:[set resultDictionary]];
    }
    [set close];
    return obj;
}

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class {
    return [self getDataArrayForTableName:tableName withKey:key andValue:value dataClass:class orderType:NSOrderedSame orderKey:nil];
}

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey {
    return [self getDataArrayForTableName:tableName withKey:key andValue:value dataClass:class orderType:compare orderKey:orderKey page:0 count:0];
}

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey page:(NSInteger)page count:(NSInteger)count {
    FMResultSet *set = [self getResultSetForTableName:tableName withKey:key andValue:value orderType:compare orderKey:orderKey page:page count:count];
    NSMutableArray *result = [NSMutableArray array];
    while ([set next]) {
        id obj = nil;
        if (class == [NSDictionary class]) {
            obj = [set resultDictionary];
        }
        else{
            obj = [[class alloc]initWithDictionary:[set resultDictionary]];
        }
        [result addObject:obj];
    }
    [set close];
    return result;
}

- (NSArray *)getDataArrayForTableName:(NSString *)tableName dataClass:(Class)class conditionQuery:(NSString *)conditionQuery {
    FMResultSet *set = [self getResultSetForTableName:tableName conditionQuery:conditionQuery];
    NSMutableArray *result = [NSMutableArray array];
    while ([set next]) {
        id obj = nil;
        if (class == [NSDictionary class]) {
            obj = [set resultDictionary];
        }
        else{
            obj = [[class alloc]initWithDictionary:[set resultDictionary]];
        }
        [result addObject:obj];
    }
    [set close];
    return result;
}

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value {
    return [self getResultSetForTableName:tableName withKey:key andValue:value orderType:NSOrderedSame orderKey:nil];
}

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey {
    return [self getResultSetForTableName:tableName withKey:key andValue:value orderType:compare orderKey:orderKey page:0 count:0];
}

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey page:(NSInteger)page count:(NSInteger)count {
    
    NSMutableString *query = [NSMutableString string];
    if (key.length && value) {
        NSString *valueStr = [value isKindOfClass:[NSString class]] ? [NSString stringWithFormat:@"'%@'",value] : [NSString stringWithFormat:@"%@",value];
        [query appendFormat:@"where %@ = %@", key, valueStr];
    }
    
    if (orderKey.length) {
        switch (compare) {
            case NSOrderedAscending: {
                [query appendFormat:@" order by %@ asc", orderKey];
                break;
            }
            case NSOrderedSame: {
                break;
            }
            case NSOrderedDescending: {
                [query appendFormat:@" order by %@ desc", orderKey];
                break;
            }
            default: {
                break;
            }
        }
    }
    
    if (page && count) {
        [query appendFormat:@" limit %d offset %d", (int)count, (int)((page - 1) * count)];
    }
    
    return [self getResultSetForTableName:tableName conditionQuery:query];
}

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName conditionQuery:(NSString *)conditionQuery {
    __block FMResultSet *set = nil;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        NSMutableString *query = [NSMutableString stringWithFormat:@"select * from %@",tableName];
        if (conditionQuery.length) {
            [query appendFormat:@" %@",conditionQuery];
        }
        set = [db executeQuery:query];
    }];
    
    return set;
}

- (BOOL)deleteDataForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        if (key.length && value) {
            NSString *query = [NSString stringWithFormat:@"delete from %@ where %@ = ", tableName, key];
            query = [value isKindOfClass:[NSString class]] ? [query stringByAppendingFormat:@"'%@'",value] : [query stringByAppendingFormat:@"%@",value];
            work = [db executeUpdate:query];
        }
    }];
    return work;
}

- (BOOL)deleteDataForTableName:(NSString *)tableName withKeys:(NSArray *)keys andValue:(NSArray *)values
{
    __block BOOL work = NO;
    NSAssert(keys.count == values.count, @"键值数量必须相同");
    [databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *query = [NSString stringWithFormat:@"delete from %@ where", tableName];
        if (keys.count && values.count) {
            for (int i = 0; i < keys.count; i++) {
                if (i != 0) {
                    query = [query stringByAppendingString:@" and"];
                }
                query  = [query stringByAppendingFormat:@" %@ =", keys[i]];
                query = [values[i] isKindOfClass:[NSString class]] ? [query stringByAppendingFormat:@" '%@'",values[i]] : [query stringByAppendingFormat:@" %@",values[i]];
            }
            work = [db executeUpdate:query];
        }
    }];
    return work;
}

- (BOOL)executeUpdate:(NSString *)sql {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        work = [db executeUpdate:sql];
    }];
    return work;
}

/*******************************************************************/
#pragma mark - 事务操作，批量写入数据
//事务操作，批量写入数据
- (BOOL)insertMultiDataForTableName:(NSString *)tableName withArray:(NSArray *)array {
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        if ([db beginTransaction]) {
            for (id object in array) {
                NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[object objectDictionary]];
                NSDictionary *kv = [self getInsertKeysValuesStringByParam:obj];
                NSString *kvStr = [kv objectForKey:@"query"];
                NSArray *arg = [kv objectForKey:@"argument"];
                NSMutableString *query = [NSMutableString stringWithFormat:@"insert into %@",tableName];
                [query appendFormat:@"%@", kvStr];
                [db executeUpdate:query withArgumentsInArray:arg];
                if (!work) {
                    break;
                }
            }
            
            if ([db commit]) {
                work = YES;
                LOGD(@"数据库批量写入成功");
            }
            else {
                [db rollback];
                LOGD(@"数据库写入数据出错");
            }
        }
    }];
    return work;
}

- (void)insertForTableName:(NSString *)tableName withObject:(id)object
{
    if (!object) {
        return;
    }
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[object objectDictionary]];
    NSDictionary *kv = [self getInsertKeysValuesStringByParam:obj];
    NSString *kvStr = [kv objectForKey:@"query"];
    NSArray *arg = [kv objectForKey:@"argument"];
    
    [self insertForTableName:tableName withKeyValueString:kvStr andArgument:arg];
}

- (void)insertForTableName:(NSString *)tableName withKeyValueString:(NSString *)kvStr andArgument:(NSArray *)arg
{
    NSMutableString *query = [NSMutableString stringWithFormat:@"replace into %@",tableName];
    [query appendFormat:@"%@", kvStr];
    //    BOOL work = [dataBase executeUpdate:query withArgumentsInArray:arg];
    __block BOOL work = NO;
    [databaseQueue inDatabase:^(FMDatabase *db) {
        work = [db executeUpdate:query withArgumentsInArray:arg];
    }];
//    LOGD(@"replace %@ : %@", tableName, work ? @"succeed" : @"fail");
}

/********* 事务方法 *********/
- (void)inTransitionInsertForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db
{
    if (!object) {
        return;
    }
    NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[object objectDictionary]];
    NSDictionary *kv = [self getInsertKeysValuesStringByParam:obj];
    NSString *kvStr = [kv objectForKey:@"query"];
    NSArray *arg = [kv objectForKey:@"argument"];
    
    [self inTransitionInsertForTableName:tableName withKeyValueString:kvStr andArgument:arg withDataBase:db];
}

- (void)inTransitionInsertForTableName:(NSString *)tableName withKeyValueString:(NSString *)kvStr andArgument:(NSArray *)arg withDataBase:(FMDatabase *)db
{
    NSMutableString *query = [NSMutableString stringWithFormat:@"replace into %@",tableName];
    [query appendFormat:@"%@", kvStr];
    [db executeUpdate:query withArgumentsInArray:arg];
//    LOGD(@"replace %@ : %@", tableName, work ? @"succeed" : @"fail");
}

- (void)inTransitionMergerForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db key:(NSString *)key value:(NSString *)value
{
    NSString *query = [NSString stringWithFormat:@"update %@ set %@ where %@ = ", tableName, [self getMergeKeysValusStringByParam:[object objectDictionary]], key];
    query = [value isKindOfClass:[NSString class]] ? [query stringByAppendingFormat:@"'%@'",value] : [query stringByAppendingFormat:@"%@",value];
    [db executeUpdate:query withParameterDictionary:[object objectDictionary]];
}

- (void)inTransitionDeleteForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db key:(NSString *)key value:(NSString *)value
{
    NSString *query = [NSString stringWithFormat:@"delete from %@ where %@ = ", tableName, key];
    query = [value isKindOfClass:[NSString class]] ? [query stringByAppendingFormat:@"'%@'",value] : [query stringByAppendingFormat:@"%@",value];
    [db executeUpdate:query withParameterDictionary:[object objectDictionary]];
}
/******************/

//此方法的事务使用的是参数的db
- (void)inTransitionWithBlock:(void (^)(FMDatabase *db, BOOL *rollback))block {
    [databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        block(db, rollback);
    }];
}

//此方法的事务使用的是自己的dataBase
- (void)doTransitionWithBlock:(void (^)())block {
    block();
}
@end
