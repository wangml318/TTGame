//
//  TTScoreView.h
//  TTGame
//
//  Created by MrWang on 14/12/14.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

/**
 *  @Author MrWang, 14-12-14 17:52:44
 *
 *  @brief  颜色模式下的分数进度条
 *
 *  @since 1.0
 */

#import <UIKit/UIKit.h>
#import "AppMacro.h"

typedef void (^PassGameCallback)();

@interface TTScoreView : UIView

@property(nonatomic, assign)NSInteger maxScore;
@property(nonatomic, assign)BOOL isPass;
@property(nonatomic, strong)UIView *progressView;
@property(nonatomic, strong)UILabel *scoreLabel;
@property(nonatomic, copy)PassGameCallback passGameCallback;

- (void)updateScore:(NSNumber *)nscore;

@end
