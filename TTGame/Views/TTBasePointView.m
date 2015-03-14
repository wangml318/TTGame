//
//  TTBasePointView.m
//  TTGame
//
//  Created by MrWang on 14/12/13.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTBasePointView.h"

@implementation TTBasePointView

- (id)init
{
    self = [super init];
    if(self)
    {
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        tapGR.delegate = self;
        [self addGestureRecognizer:tapGR];
        
        double time = (arc4random() % 200) / 100.0 + 0.5;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideAnimation) userInfo:nil repeats:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (timeup) name:@"TimeUp" object:nil];
    }
    return self;
}

- (void)timeup
{
    self.userInteractionEnabled = NO;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if(!self.isTap)
        [self showAnimation];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //    NSLog(@"%i", gestureRecognizer.numberOfTouches);
    NSLog(@"tag:%li",(long)self.tag);
    return YES;
}

- (void)handleTap
{
    self.userInteractionEnabled = NO;
}

#pragma mark - 动画
- (void)showAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:@"showAnimation"];
}

- (void)hideAnimation
{
    self.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
    animation.values = values;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"hideAnimation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animationCallback)
        self.animationCallback(self);
}

- (void)breakAnimWithCornerRadius:(BOOL)isRadius
{
    float breakLayerWidth = self.frame.size.width / 4;
    
    //    CGSize breakSize = CGSizeMake(breakLayerWidth, breakLayerWidth);
    
    int cols = self.frame.size.width / breakLayerWidth; //列数
    int rows = self.frame.size.height / breakLayerWidth; //行数
    
    CGImageRef imageOfView = [self imageFromLayer:self.layer].CGImage;
    
    [[self.layer sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer *layer = (CALayer *)obj;
        layer.hidden = YES;
    }];
    
    self.backgroundColor = [UIColor clearColor];
    
    for(int x = 0; x < cols; x ++)
    {
        for(int y = 0; y < rows; y ++)
        {
            CGRect breakLayerFrame = CGRectMake(x * breakLayerWidth, y * breakLayerWidth, breakLayerWidth, breakLayerWidth);
            CGImageRef breakLayerImage = CGImageCreateWithImageInRect(imageOfView, breakLayerFrame);
            
            TTBreakLayer *layer = [TTBreakLayer layer];
            layer.frame = breakLayerFrame;
            layer.contents = (__bridge id)breakLayerImage;
            if(isRadius)
            {
                layer.masksToBounds = YES;
                layer.cornerRadius = breakLayerWidth / 2;
            }
            
            layer.bezierPath = [self pathForLayer:layer parentRect:self.frame];
            
            [self.layer addSublayer:layer];
            CGImageRelease(breakLayerImage);
        }
    }
    
    //动画
    [[self.layer sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[TTBreakLayer class]])
        {
            TTBreakLayer *layer = (TTBreakLayer *)obj;
            
            CAKeyframeAnimation *pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnim.path = layer.bezierPath.CGPath;
            
            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(1);
            scaleAnim.toValue = @(0);
            
            CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
            opacityAnim.fromValue = @(1);
            opacityAnim.toValue = @(0);
            
            CAAnimationGroup *animGroup = [CAAnimationGroup animation];
            animGroup.animations = @[pathAnim, scaleAnim, opacityAnim];
            animGroup.duration = rand()/(float)RAND_MAX + 0.3;
            animGroup.removedOnCompletion = NO;
            animGroup.fillMode = kCAFillModeForwards;
            animGroup.delegate = self;
            [animGroup setValue:layer forKey:@"breakAnim"];
            [layer addAnimation:animGroup forKey:nil];
        }
    }];
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

-(UIBezierPath *)pathForLayer:(CALayer *)layer parentRect:(CGRect)rect
{
    UIBezierPath *particlePath = [UIBezierPath bezierPath];
    [particlePath moveToPoint:layer.position];
    
    
    CGPoint curveToPoint = CGPointZero;
    CGPoint controlPoint = CGPointZero;
    
    float random = rand()/(float)RAND_MAX; //0~1的随机浮点数
    
    
    
    float radius = 200.f; //半径范围
    
    if(layer.position.x < rect.size.width / 2)
    {
        //往左边
        curveToPoint = CGPointMake(-radius * random, self.superview.frame.size.height-self.frame.origin.y);
        controlPoint = CGPointMake(-radius * random / 2, - radius * random);
    }
    else
    {
        //往右边
        curveToPoint = CGPointMake(radius * random, self.superview.frame.size.height-self.frame.origin.y);
        controlPoint = CGPointMake(radius * random / 2, - radius * random);
    }
    [particlePath addQuadCurveToPoint:curveToPoint
                         controlPoint:controlPoint];
    return particlePath;
}


@end


@implementation TTBreakLayer

@end

