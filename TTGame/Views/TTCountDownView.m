//
//  TTCountDownView.m
//  TTGame
//
//  Created by MrWang on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTCountDownView.h"

@implementation TTCountDownView

- (id)initWithFrame:(CGRect)frame withTiem:(NSInteger)time
{
    self = [super initWithFrame:frame];
    if(self)
    {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        effectview.alpha = 0.95;
        [self addSubview:effectview];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _countdownFrom = time;
        
        _countdownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _countdownLabel.center = self.center;
        _countdownLabel.font = [UIFont boldSystemFontOfSize:40];
        _countdownLabel.text = [NSString stringWithFormat:@"%i", time];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countdownLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self startCount];
}

- (void)startCount
{
    __block int timeout = _countdownFrom;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,dispatch_time(DISPATCH_TIME_NOW, 0), 0.7 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //动画组
            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
            //淡出动画
            CABasicAnimation *fadeoutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            fadeoutAnimation.fromValue = @1;
            fadeoutAnimation.toValue = @0;
            
            //放大动画
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @1;
            scaleAnimation.toValue = @4;
            
            if(timeout <= 0)
            { //倒计时结束，关闭
                dispatch_source_cancel(timer);
                animationGroup.removedOnCompletion = NO;
                animationGroup.fillMode = kCAFillModeForwards;
                animationGroup.delegate = self;
                _countdownLabel.text = @"Go";
            }
            else
            {
                _countdownLabel.text =[NSString stringWithFormat:@"%i",timeout];
                timeout --;
            }
            
            animationGroup.animations = @[fadeoutAnimation, scaleAnimation];
            animationGroup.duration = 0.6;
            animationGroup.removedOnCompletion = NO;
            animationGroup.fillMode = kCAFillModeForwards;
            [_countdownLabel.layer addAnimation:animationGroup forKey:[NSString stringWithFormat:@"%i", timeout]];
        });
    });
    dispatch_resume(timer);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
        self.startGame();
}
@end
