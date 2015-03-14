//
//  TTBaseViewController.h
//  TTGame
//
//  Created by MrWang on 14/12/16.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

/**
 *  @Author MrWang, 14-12-16 21:32:35
 *
 *  @brief  颜色模式vc与数字模式vc的父vc
 *
 *  @since 1.0
 */

#import <UIKit/UIKit.h>
#import "TTReminderView.h"

@interface TTBaseViewController : UIViewController

@property(nonatomic, assign)NSInteger currentLevel; //当前关卡
@property(nonatomic, strong)NSMutableArray *pointArray;
@property(nonatomic, assign)NSInteger totalPointNum;
@property(nonatomic, assign)BOOL isStop;

@property(nonatomic, strong)NSDictionary *gameParam;//游戏参数 包括时间 点半径等

@property(nonatomic, assign)NSInteger currenrScore;
@property(nonatomic, assign)NSInteger totalScore;

@property(nonatomic, strong)TTReminderView *reminderView;
@property(nonatomic, strong)UILabel *tipLabel;

- (void)stopGame:(BOOL)isWin;
- (void)ready;
@end