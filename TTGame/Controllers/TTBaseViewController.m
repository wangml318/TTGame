//
//  TTBaseViewController.m
//  TTGame
//
//  Created by MrWang on 14/12/16.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTNumPointView.h"
#import "AppMacro.h"
#import "TTLevelHelper.h"
#import "TTTimerHelper.h"
#import "TTCountDownView.h"
#import "EndViewController.h"

@interface TTBaseViewController ()<countDownDelegate>

@end

@implementation TTBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pointArray = [NSMutableArray array];
    _currentLevel = 1;
    
    [self ready];
    
    //游戏玩法提示
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, MAINSCREEN_WIDTH, 20)];
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_tipLabel];
    
    //3-2-1-GO倒数
    TTCountDownView *countdownView = [[TTCountDownView alloc]initWithFrame:self.view.bounds withTiem:3];
    __weak TTCountDownView *wcountdowView = countdownView;
    countdownView.startGame = ^()
    {
        _isStop = NO;
        _totalPointNum = 0;
        [self startGame];
        [wcountdowView removeFromSuperview];
    };
    [self.view addSubview:countdownView];
    
    //通关/时间到 提示
    _reminderView = [[TTReminderView alloc]init];
    _reminderView.frame = self.view.bounds;
    __weak TTBaseViewController *wSelf = self;
    _reminderView.reminderHideCallback = ^(BOOL isWin)
    {
        if(isWin)//过关 下一局
        {
            wSelf.currentLevel ++;
            dispatch_async(dispatch_get_main_queue(), ^{
                [wSelf ready];
            });
            //计分
            double usedTime = [[TTTimerHelper shareInstance]usedTime];
            wSelf.totalScore += 10 / usedTime;
            
            TTCountDownView *countdownView = [[TTCountDownView alloc]initWithFrame:wSelf.view.bounds withTiem:3];
            __weak TTCountDownView *wcountdowView = countdownView;
            
            countdownView.startGame = ^()
            {
                wSelf.isStop = NO;
                wSelf.totalPointNum = 0;
                [wSelf startGame];
                [wcountdowView removeFromSuperview];
            };
            [wSelf.view addSubview:countdownView];
        }
        else //挂了 跳转
        {
            [wSelf performSegueWithIdentifier:@"numPresentEndVC" sender:nil];
        }
        
    };
    [self.view addSubview:_reminderView];
}

- (void)creatViewWithRadius:(NSInteger)radius
{
    
}

- (void)ready
{
    _currenrScore = 0;
    
    [[TTTimerHelper shareInstance] countDownWithTimeInterval:[self.gameParam[@"Time"] floatValue] andViewController:self];
}

- (void)startGame
{
    
    [[TTTimerHelper shareInstance]startTimer];
    
    while(_pointArray.count < [self.gameParam[@"PointNum"] integerValue]) //屏幕上最多同时出现的PointView数
    {
        [self creatViewWithRadius:[self.gameParam[@"PointNum"] integerValue]];
    }
}

- (void)stopGame:(BOOL)isWin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimeUp" object:nil];
    [[TTTimerHelper shareInstance]cancelTimer];
    
    _isStop = YES;
    [_pointArray removeAllObjects];
    
    [_reminderView showReminderWithWin:isWin dur:2];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EndViewController *endVC = segue.destinationViewController;
    endVC.level = self.currentLevel - 1;
    endVC.score = self.totalScore;
    endVC.delegate = self;
}
@end
