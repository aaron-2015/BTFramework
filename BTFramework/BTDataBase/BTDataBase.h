//
//  BTDataBase.h
//  BiketoRabbit
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

static NSString * const DBName_TokenInfo = @"TokenInfo";
static NSString * const DBName_CurrUserInfo = @"CurrUserInfo";

@interface BTDataBase : NSObject

@property (nonatomic, strong) NSString *version;

+ (instancetype)createDataBase;

- (NSDictionary *)getInsertKeysValuesStringByParam:(NSDictionary *)dic;

- (NSString *)getMergeKeysValusStringByParam:(NSDictionary *)dic;

- (BOOL)mergeDataForTableName:(NSString *)tableName withObject:(id)object andKey:(NSString *)key andValue:(id)value;

- (BOOL)insertDataForTableName:(NSString *)tableName withObjectArray:(NSArray *)objectArr;

- (BOOL)insertDataForTableName:(NSString *)tableName withObject:(id)object;

- (BOOL)insertDataForTableName:(NSString *)tableName withKeyValueString:(NSString *)kvStr andArgument:(NSArray *)arg;

- (id)getDataForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class;

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class;

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey;

- (NSArray *)getDataArrayForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value dataClass:(Class)class orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey page:(NSInteger)page count:(NSInteger)count;

- (NSArray *)getDataArrayForTableName:(NSString *)tableName dataClass:(Class)class conditionQuery:(NSString *)conditionQuery;

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value;

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey;

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value orderType:(NSComparisonResult)compare orderKey:(NSString *)orderKey page:(NSInteger)page count:(NSInteger)count;

- (FMResultSet *)getResultSetForTableName:(NSString *)tableName conditionQuery:(NSString *)conditionQuery; 

- (BOOL)deleteDataForTableName:(NSString *)tableName withKey:(NSString *)key andValue:(id)value;

- (BOOL)deleteDataForTableName:(NSString *)tableName withKeys:(NSArray *)keys andValue:(NSArray *)values;

- (BOOL)executeUpdate:(NSString *)sql;

//利用事务批量存入数据库
- (BOOL)insertMultiDataForTableName:(NSString *)tableName withArray:(NSArray *)array;

//没有打开数据库的方法，用于SQL语句批量操作
- (void)insertForTableName:(NSString *)tableName withObject:(id)object;

- (void)inTransitionWithBlock:(void (^)(FMDatabase *db, BOOL *rollback))block;
- (void)doTransitionWithBlock:(void (^)())block;

//事务
- (void)inTransitionInsertForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db;

//更新事务
- (void)inTransitionMergerForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db key:(NSString *)key value:(NSString *)value;

//删除事务
- (void)inTransitionDeleteForTableName:(NSString *)tableName withObject:(id)object withDataBase:(FMDatabase *)db key:(NSString *)key value:(NSString *)value;
@end
