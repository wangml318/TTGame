//
//  TTLevelHelper.h
//  TTGame
//
//  Created by MrWang on 14/12/11.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTColorMode,
    TTNumMode
}TTMode;

@interface TTLevelHelper : NSObject

//MARK:返回游戏参数 包括时间 半径 点数 目标分数
+ (NSDictionary *)getGameParamWithLevel:(NSInteger)level WithMode:(TTMode)mode;

//MARK:返回算式的参数 运算数 运算符
+ (NSDictionary *)getCountParamWithLevel:(NSInteger)level;
@end
