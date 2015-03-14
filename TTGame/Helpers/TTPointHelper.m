//
//  TTPointHelper.m
//  TTGame
//
//  Created by MrWang on 14/12/5.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTPointHelper.h"
#import "AppMacro.h"


@implementation TTPointHelper


+(NSValue *)getPointFrameWithArray:(NSArray *)frameArray WithRadius:(float)radius
{
    BOOL isOK = NO;
    CGRect frame;
    while(!isOK) //循环到找到符合条件的frame为止
    {
        int x = arc4random() % (int)(MAINSCREEN_WIDTH - radius * 2 + 1);
        int y = arc4random() % (int)(MAINSCREEN_HEIGHT - radius * 2 + 1 - 64) + 64;
        frame = CGRectMake(x, y, radius * 2, radius * 2);
        
        isOK = (frameArray.count == 0);
        
        for(UIView *view in frameArray)
        {
            if(CGRectIntersectsRect(frame, view.frame))
            {
                isOK = NO;
                break;
            }
            isOK = YES;
        }
    }
    return [NSValue valueWithCGRect:frame];
}


@end
