//
//  TTBasePointView.h
//  TTGame
//
//  Created by MrWang on 14/12/13.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//


/**
 *  @Author MrWang, 14-12-13 10:12:08
 *
 *  @brief  点父类
 *
 *  @since 1.0
 */
#import <UIKit/UIKit.h>


@interface TTBreakLayer : CALayer

@property(nonatomic, strong)UIBezierPath *bezierPath;

@end

@class TTBasePointView;

typedef void (^AnimationStopCallback)(UIView *);
typedef void (^PointTap)(TTBasePointView *);

@interface TTBasePointView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic, assign)float radius;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, copy)AnimationStopCallback animationCallback;
@property(nonatomic, copy)PointTap pointTap;
@property(nonatomic, assign)BOOL isTap;


- (void)handleTap;
- (void)breakAnimWithCornerRadius:(BOOL)isRadius;
@end
