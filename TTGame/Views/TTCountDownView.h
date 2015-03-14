//
//  TTCountDownView.h
//  TTGame
//
//  Created by MrWang on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

/**
 *  @Author MrWang, 14-12-15 11:51:24
 *
 *  @brief  游戏开始前的3-2-1倒计时view
 *
 *  @since 1.0
 */

#import <UIKit/UIKit.h>

typedef void (^StartGameCallback)();

@interface TTCountDownView : UIView

@property(nonatomic, assign)NSInteger countdownFrom;
@property(nonatomic, strong)UILabel *countdownLabel;
@property(nonatomic, copy)StartGameCallback startGame;

- (id)initWithFrame:(CGRect)frame withTiem:(NSInteger)time;
@end
