//
//  TTScoreView.m
//  TTGame
//
//  Created by MrWang on 14/12/14.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTScoreView.h"

#define MIN_PROGRESS 1

@implementation TTScoreView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [REDCOLOR CGColor];
        self.backgroundColor = [UIColor clearColor];
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MIN_PROGRESS, frame.size.height)];
        _progressView.backgroundColor = REDCOLOR;
        _progressView.layer.anchorPoint = CGPointMake(0, .5);
        [self addSubview:_progressView];
        
        _scoreLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor = [UIColor colorWithRed:(255.0 / 255.0) green:(132.0 / 255.0) blue:(131.0 / 255.0) alpha:1];
//        _scoreLabel.text = @"0 / 10";
        [self addSubview:_scoreLabel];
    }
    return self;
}

- (void)updateScore:(NSNumber *)nscore
{
    NSInteger score = [nscore integerValue];
    if(score >= _maxScore)
        score = _maxScore;
    float progress = score * (self.frame.size.width - self.layer.borderWidth) / _maxScore;
    if(progress <= 0)
        progress = MIN_PROGRESS;
    
    _scoreLabel.text = [NSString stringWithFormat:@"%i / %i", score, _maxScore];
    //动画
    [UIView beginAnimations:nil context:nil];
    _progressView.transform = CGAffineTransformMakeScale(progress, 1);
    [UIView commitAnimations];
    
}

- (void)drawRect:(CGRect)rect {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}


@end
