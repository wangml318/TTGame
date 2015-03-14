//
//  TTLevelHelper.m
//  TTGame
//
//  Created by MrWang on 14/12/11.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTLevelHelper.h"

@implementation TTLevelHelper

+ (NSDictionary *)getGameParamWithLevel:(NSInteger)level WithMode:(TTMode)mode
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    float time, radius;
    NSInteger pointNum, target;
    if(mode == TTColorMode)
    {
        time = pow((float)level / 5, -0.7) + 1;
//        time = 60;
        radius = 32 - level * 2;
        pointNum = 2 + level;
        target = 2 + level / 2;
    }
    else
    {
        time = 10 * pow((float)level , -0.1);
        radius = 32 - level * 2;
        pointNum = 6;
//        target = 2;
    }
    
    [dic setObject:@(time) forKey:@"Time"];
    [dic setObject:@(radius) forKey:@"Radius"];
    [dic setObject:@(pointNum) forKey:@"PointNum"];
    [dic setObject:@(target) forKey:@"Target"];
    
    return dic;
}

+ (NSDictionary *)getCountParamWithLevel:(NSInteger)level
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //运算符号
    NSInteger operatorTag = arc4random() % ((level > 4) ? 3 : 2);//前4局只有只有加法（0） 减法（1）第4局后加上乘法（2）
    //多少位
    if(operatorTag == 2)
        level -= 3;
    NSInteger length = ceilf((float)level / 2); //向上取整
    if(operatorTag == 2)
    {
        length = (length > 3) ? 3 : length; //乘法不超过2位 不然把人虐出翔
    }
    length = (length > 5) ? 5 : length; //不超过5位
    //生成两个length位内的操作数
    NSInteger ParamA = arc4random() % (int)pow(10, length);
    NSInteger ParamB = arc4random() % (int)pow(10, length);
    
    //减法要考虑不能得出负数
    if(operatorTag == 1)
    {
        if(ParamA < ParamB) //交换
        {
            ParamA = ParamA + ParamB;
            ParamB = ParamA - ParamB;
            ParamA = ParamA - ParamB;
        }
    }
    [dic setObject:@(ParamA) forKey:@"ParamA"];
    [dic setObject:@(ParamB) forKey:@"ParamB"];
    [dic setObject:@(operatorTag) forKey:@"Operator"];
    return dic;
}

@end
