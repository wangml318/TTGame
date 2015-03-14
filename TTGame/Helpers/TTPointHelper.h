//
//  TTPointHelper.h
//  TTGame
//
//  Created by MrWang on 14/12/5.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPointHelper : NSObject

//返回一个与frameArray中frame不重叠的frame value radius点的半径
+(NSValue *)getPointFrameWithArray:(NSArray *)frameArray WithRadius:(float)radius;

@end
