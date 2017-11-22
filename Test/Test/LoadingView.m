//
//  LoadingView.m
//  Test
//
//  Created by zhangyapeng on 16/7/7.
//  Copyright © 2016年 zhangyapeng. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        startA = 0.f;
        endA = 0.f;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        UIButton *btn;
    }
    return self;
}
- (void)startLoading
{
    self.hidden = NO;
    if (!timer) {
        [self startR];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(roatation:) userInfo:nil repeats:YES];
    }
}
- (void)cancelLoading
{
    self.hidden = YES;
    if (timer) {
        [timer invalidate];
        timer = nil;
        [self.layer removeAllAnimations];
    }
}
- (void)roatation:(NSTimer *)t
{
    endA += M_PI/40;
    if (endA > M_PI*2*3/4)
    {
        endA = M_PI/4;
        startA = M_PI/7;
    }

    [self setNeedsDisplay];
    
}
- (void)startR
{
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    basic.removedOnCompletion = NO;
    basic.duration = 1;
    basic.repeatCount = INFINITY;
    basic.fromValue = @(0);
    basic.toValue = @(M_PI*2);
    basic.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:basic forKey:nil];
}
- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    UIBezierPath *apath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0, height/2.0) radius:width/2-5 startAngle:startA endAngle:endA clockwise:YES];
    apath.lineWidth = 2;
    apath.lineCapStyle = kCGLineCapRound;
    apath.lineJoinStyle = kCGLineCapRound;
    [[UIColor redColor] set];
    [apath stroke];
}
- (void)dealloc
{
    [self cancelLoading];
    NSLog(@"死了");
}


@end
