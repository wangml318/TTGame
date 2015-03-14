//
//  TTTimerHelper.m
//  TTGame
//
//  Created by KayWong on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTTimerHelper.h"
#import "AppDelegate.h"
#import "AppMacro.h"
@implementation TTTimerHelper
/**
 *  @Author KayWong, 14-12-15 10:12:49
 *
 *  @brief  获取计时器的实例
 *
 *  @return 计时器实例
 *
 *  @since 1.0
 */
+ (TTTimerHelper *)shareInstance
{
    static TTTimerHelper *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TTTimerHelper alloc] init];
    });
    
    return _instance;
}
/**
 *  @Author KayWong, 14-12-15 10:12:28
 *
 *  @brief  返回当前剩余时间
 *
 *  @return 当前剩余时间
 *
 *  @since 1.0
 */
-(double)currentTime{
    return [self.timeLabel.text doubleValue];
}

-(double)usedTime
{
    return self.countdownTiem - [self currentTime];
}

/**
 *  @Author KayWong, 14-12-15 09:12:37
 *
 *  @brief  倒计时方法，传入double类型的总倒计时时间
 *
 *  @param time 倒计时总时间
 *
 *  @since 1.0
 */
-(void)countDownWithTimeInterval:(double)time andViewController:(UIViewController *)viewController{
    if (!self.timeLabel) {
        
        self.timeLabel = [[TTTimeLable alloc]initWithFrame:CGRectMake(MAINSCREEN_WIDTH - 90, 30, 100, 20)];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = REDCOLOR;
        [viewController.view addSubview:self.timeLabel];
    }
    BOOL shouldAddView = YES;
    for(UIView *view in [viewController.view subviews])
    {
        if([view isKindOfClass:[TTTimeLable class]])
            shouldAddView = NO;
    }
    [self.timeLabel setText:[NSString stringWithFormat:@"%.2f",time]];
    if(shouldAddView)
        [viewController.view addSubview:self.timeLabel];
    
    self.countdownTiem = time; //倒计时时间
    self.delegate = viewController;
}

-(void)startTimer
{
    __block double timeout = self.countdownTiem * 1000;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_MSEC, 0); //每毫秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                self.timeLabel.text = @"0.00";
                if ([self.delegate conformsToProtocol:@protocol(countDownDelegate)]) {
                    [self.delegate stopGame:NO];
                }
            });
        }else{
            //			int minutes = timeout / 60;
            double seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%1.2f", seconds/1000];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
#ifdef DEBUG
                //                NSLog(@"____%@",strTime);
#endif
                self.timeLabel.text =[NSString stringWithFormat:@"%@",strTime];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

-(void)cancelTimer{
    if (self.timer!=nil) {
        dispatch_source_cancel(self.timer);
    }

}
@end

@implementation TTTimeLable

@end