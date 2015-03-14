//
//  TTNumViewController.h
//  TTGame
//
//  Created by MrWang on 14/12/16.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//


/**
 *  @Author MrWang, 14-12-16 22:14:23
 *
 *  @brief  数字模式viewcontroller
 *
 *  @since 1.0
 */
#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"

@interface TTNumViewController : TTBaseViewController

@property(nonatomic, strong)UILabel *countLabel;
@property(nonatomic, copy)NSString *correctResultStr;
@property(nonatomic, copy)NSMutableString *resultStr;

@end

