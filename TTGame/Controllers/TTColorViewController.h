//
//  ViewController.h
//  TTGame
//
//  Created by MrWang on 14/12/4.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

/**
 *  @Author MrWang, 14-12-4 10:34:24
 *
 *  @brief  颜色模式viewcontroller
 *
 *  @since 1.0
 */

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
#import "TTScoreView.h"

@interface TTColorViewController : TTBaseViewController

@property(nonatomic, strong)TTScoreView *scoreView;
@property(nonatomic, strong)NSArray *scoreViewColorArr;
@property(nonatomic, strong)UIColor *scoreViewColor;
@end

