//
//  TTNumPointView.m
//  TTGame
//
//  Created by MrWang on 14/12/13.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTNumPointView.h"
#import "AppMacro.h"
@implementation TTNumPointView

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = REDCOLOR;
        
        
        int num = arc4random() % 9;
        self.tag = num;
        _numLabel = [[UILabel alloc]init];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.minimumScaleFactor = .2;
        _numLabel.font = [UIFont systemFontOfSize:80];
        _numLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _numLabel.numberOfLines = 1;
        [_numLabel setText:[NSString stringWithFormat:@"%i", num]];
        [self addSubview:_numLabel];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_numLabel setFrame:CGRectMake(15, 0, frame.size.width - 30, frame.size.height)];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.layer.masksToBounds = !self.isTap;
    self.layer.cornerRadius = self.frame.size.width / 2;
}

- (void)handleTap
{
    [super handleTap];
    self.isTap = YES;
    self.pointTap(self);
}

@end
