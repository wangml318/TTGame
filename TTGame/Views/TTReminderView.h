//
//  TTReminderView.h
//  TTGame
//
//  Created by MrWang on 14/12/22.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

/**
 *  @Author MrWang, 14-12-22 14:54:24
 *
 *  @brief  游戏过关/失败后弹出的提示view
 *
 *  @since 1.0
 */

#import <UIKit/UIKit.h>

typedef void (^ReminderHideCallback)(BOOL);

@interface TTReminderView : UIView

@property(nonatomic, strong)UILabel *remindLabel;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, copy)ReminderHideCallback reminderHideCallback;

- (void)showReminderWithWin:(BOOL)isWin dur:(float)time;

@end
