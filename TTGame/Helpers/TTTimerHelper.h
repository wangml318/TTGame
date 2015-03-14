//
//  TTTimerHelper.h
//  TTGame
//
//  Created by KayWong on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol countDownDelegate <NSObject>
- (void)stopGame:(BOOL)isWin;
@end


@interface TTTimeLable : UILabel

@end

@interface TTTimerHelper : NSObject
@property dispatch_source_t timer;

@property (nonatomic , strong) TTTimeLable *timeLabel;
@property (nonatomic , assign) id delegate;
@property (nonatomic , assign) double countdownTiem;
+ (TTTimerHelper *)shareInstance;
-(double)currentTime;
-(double)usedTime;
-(void)countDownWithTimeInterval:(double)time andViewController:(UIViewController *)viewController;
-(void)cancelTimer;
-(void)startTimer;
@end
