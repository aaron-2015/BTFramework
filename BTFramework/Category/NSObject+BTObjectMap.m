//
//  NSObject+BTObjectMap.m
//  BTFramework
//
//  Created by aaron on 16/8/1.
//  Copyright © 2016年 aaron. All rights reserved.
//

#import "NSObject+BTObjectMap.h"
#import <YYModel/YYModel.h>

@implementation NSObject (BTObjectMap)

- (NSDictionary *)objectDictionary
{
    id jsonObject = [self yy_modelToJSONObject];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) return jsonObject;
    //    if ([jsonObject isKindOfClass:[NSArray class]]) return jsonObject;
    return nil;
}

@end
