//
//  TTReminderView.m
//  TTGame
//
//  Created by MrWang on 14/12/22.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTReminderView.h"
#import "AppMacro.h"

@implementation TTReminderView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((MAINSCREEN_WIDTH - 150) / 2, (MAINSCREEN_HEIGHT - 130) / 2, 150, 130)];
        view.backgroundColor = RGBCOLOR(167, 220, 224);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 10;
        _remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 130)];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.numberOfLines = 0;
        _remindLabel.font = [UIFont boldSystemFontOfSize:19];
        [view addSubview:_remindLabel];
        [self addSubview:view];
        self.hidden = YES;
    }
    return self;
}

- (void)showReminderWithWin:(BOOL)isWin dur:(float)time
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeUp" object:nil];
    
    self.hidden = NO;
    NSDictionary *userInfo = @{@"IsWin" : @(isWin)};
    [self.superview bringSubviewToFront:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideReminder:) userInfo:userInfo repeats:NO];
    
    if(isWin)
    {
        _remindLabel.text = @"(●′ω`●)ﾉ\r\n过关!";
    }
    else
    {
        _remindLabel.text = @"Σ(っ °Д °;)っ \r\n 时间到！";
    }
    
    //动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:@"showAnimation"];
}

- (void)hideReminder:(NSTimer *)timer
{
    BOOL isWin = [[timer userInfo][@"IsWin"]boolValue];
    self.hidden = YES;
    [self.timer invalidate];
    if(self.reminderHideCallback)
    {
        self.reminderHideCallback(isWin);
    }
}

@end
