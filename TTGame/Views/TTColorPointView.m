//
//  TTPointView.m
//  TTGame
//
//  Created by MrWang on 14/12/5.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTColorPointView.h"

@implementation TTColorPointView

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}




- (void)handleTap
{
    [super handleTap];
    [self.timer invalidate];
    
    self.isTap = YES;
    
    self.pointTap(self);
    
    [self breakAnimWithCornerRadius:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"TimeUp"];
    TTBreakLayer *layer = [anim valueForKey:@"breakAnim"];
    [layer removeFromSuperlayer];
    if(self.animationCallback)
        self.animationCallback(self);
}

@end