//
//  TTNumViewController.m
//  TTGame
//
//  Created by MrWang on 14/12/16.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTNumViewController.h"
#import "TTPointHelper.h"
#import "TTNumPointView.h"
#import "TTLevelHelper.h"
#import "AppMacro.h"


@implementation TTNumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YELLOWCOLOR;
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 25, 150, 30)];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    
    _countLabel.numberOfLines = 1;
    [self.view addSubview:_countLabel];
    [super viewDidLoad];
    
    //游戏玩法提示
    self.tipLabel.text = @"请依次点击正确答案的数字";
}

- (void)ready
{
    self.gameParam = [TTLevelHelper getGameParamWithLevel:self.currentLevel WithMode:TTNumMode];
    NSDictionary *numParam = [TTLevelHelper getCountParamWithLevel:self.currentLevel];
    NSInteger paramA = [numParam[@"ParamA"]integerValue];
    NSInteger paramB = [numParam[@"ParamB"]integerValue];
    NSString *operator;
    switch ([numParam[@"Operator"]integerValue]) {
        case 0:
            operator = @"+";
            _correctResultStr = [NSString stringWithFormat:@"%i", paramA + paramB];
            break;
        case 1:
            operator = @"-";
            _correctResultStr = [NSString stringWithFormat:@"%i", paramA - paramB];
            break;
        case 2:
            operator = @"*";
            _correctResultStr = [NSString stringWithFormat:@"%i", paramA * paramB];
            break;
        default:
            break;
    }
    _countLabel.text = [NSString stringWithFormat:@"%i %@ %i = ?", paramA ,operator ,paramB];
    _countLabel.adjustsFontSizeToFitWidth = YES;
    _countLabel.minimumScaleFactor = .2;
    _countLabel.font = [UIFont systemFontOfSize:100];
    _countLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _resultStr = [NSMutableString stringWithString:@""];
    [super ready];
}

//生成点
- (void)creatViewWithRadius:(NSInteger)radius
{
    if(self.pointArray.count < [self.gameParam[@"PointNum"] integerValue])
    {
        CGRect frame = [[TTPointHelper getPointFrameWithArray:self.pointArray WithRadius:[self.gameParam[@"Radius"] integerValue]] CGRectValue];
        
        self.totalPointNum ++;
        
        TTNumPointView *view = [[TTNumPointView alloc]init];
        view.frame = frame;
        //出现正确的数字
        if(self.totalPointNum % 7 == 0)
        {
            view.numLabel.text = [_correctResultStr substringWithRange:NSMakeRange(arc4random() % _correctResultStr.length, 1)];
            view.tag = [view.numLabel.text integerValue];
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
        view.pointTap = ^(TTBasePointView *view) //点击点
        {
            NSString *prefix = [NSString stringWithFormat:@"%@%@", _resultStr, [NSString stringWithFormat:@"%i", view.tag]];
            
            if([_correctResultStr hasPrefix:prefix])
            {
                [view breakAnimWithCornerRadius:YES];
                [_resultStr appendString:[NSString stringWithFormat:@"%i", view.tag]];
                _countLabel.text = _resultStr;
                _countLabel.adjustsFontSizeToFitWidth = NO;
                _countLabel.font = [UIFont systemFontOfSize:30];
                
                if([_resultStr isEqualToString:_correctResultStr])
                {
                    [self stopGame:YES];
                }
            }
        };
        [self.pointArray addObject:view];
        [self.view addSubview:view];
    }
}

@end
