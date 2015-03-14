//
//  ViewController.m
//  TTGame
//
//  Created by MrWang on 14/12/4.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTColorViewController.h"
#import "TTCountDownView.h"
#import "TTColorPointView.h"
#import "TTPointHelper.h"
#import "TTLevelHelper.h"
#import "TTTimerHelper.h"
#import "AppMacro.h"

@interface TTColorViewController ()



@end

@implementation TTColorViewController

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = YELLOWCOLOR;
    
    //计分条
    _scoreViewColorArr = @[RGBCOLOR(256, 67, 101),
                           RGBCOLOR(252, 157, 154),
                           RGBCOLOR(119, 52, 96),
                           RGBCOLOR(131, 175, 155),
                           RGBCOLOR(38, 181, 213)];
    _scoreViewColor = _scoreViewColorArr[arc4random() % 5];
    _scoreView = [[TTScoreView alloc]initWithFrame:CGRectMake((MAINSCREEN_WIDTH - 150) / 2, 30, 150, 20)];
    _scoreView.layer.borderColor = [_scoreViewColor CGColor];
    _scoreView.progressView.backgroundColor = _scoreViewColor;
    [self.view addSubview:_scoreView];
    [super viewDidLoad];
    
    //游戏玩法提示
    self.tipLabel.text = @"请点击与进度条颜色相同的方块";
}

- (void)ready
{
    
    
    self.gameParam = [TTLevelHelper getGameParamWithLevel:self.currentLevel WithMode:TTColorMode];
    
    _scoreView.maxScore = [self.gameParam[@"Target"] integerValue];
    _scoreViewColor = _scoreViewColorArr[arc4random() % 5];
    _scoreView.layer.borderColor = [_scoreViewColor CGColor];
    _scoreView.progressView.backgroundColor = _scoreViewColor;
    
    [super ready];
    
    [_scoreView performSelector:@selector(updateScore:) withObject:@(self.currenrScore) afterDelay:1];
    
}

//生成点
- (void)creatViewWithRadius:(NSInteger)radius
{
    if(self.pointArray.count < [self.gameParam[@"PointNum"] integerValue])
    {
        CGRect frame = [[TTPointHelper getPointFrameWithArray:self.pointArray WithRadius:[self.gameParam[@"Radius"] integerValue]] CGRectValue];
        
        self.totalPointNum ++;
        
        TTColorPointView *view = [[TTColorPointView alloc]init];
        view.frame = frame;
        if(self.totalPointNum % 2 == 0)
        {
            view.backgroundColor = _scoreViewColor;
            view.isRight = YES;
        }
        else
        {
            view.backgroundColor = RANDOMCOLOR;
            view.isRight = NO;
        }
        
        view.animationCallback = ^(UIView *view)
        {
            [view removeFromSuperview];
            [self.pointArray removeObject:view];
            
            if(self.totalPointNum < 1000 && !self.isStop) //需要出现的PointView总数
            {
                [self creatViewWithRadius:radius];
            }
        };
        view.pointTap = ^(TTBasePointView *view)
        {
            TTColorPointView *colorPoint = (TTColorPointView *)view;
            [self updateScore:colorPoint.isRight];
        };
        [self.pointArray addObject:view];
        [self.view addSubview:view];
    }
}

- (void)updateScore:(BOOL)isRight
{
    if(isRight)
        self.currenrScore ++; //点正确后加分策略
    else
        self.currenrScore -= 2; //点错误后失败策略
    if(self.currenrScore <= 0)
        self.currenrScore = 0;
    if(self.currenrScore >= self.scoreView.maxScore)
    {
        self.currenrScore = self.scoreView.maxScore;
        [super stopGame:YES];
    }
    
    [self.scoreView updateScore:@(self.currenrScore)];
}

- (IBAction)goBack:(id)sender
{
    [[TTTimerHelper shareInstance]cancelTimer];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
