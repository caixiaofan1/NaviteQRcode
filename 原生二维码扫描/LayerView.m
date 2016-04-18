//
//  LayerView.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/23.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "LayerView.h"

@implementation LayerView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
//            UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//            UIVisualEffectView * lefteffe = [[UIVisualEffectView alloc]initWithEffect:blur];
//            lefteffe.frame = frame;
//            // 把要添加的视图加到毛玻璃上
//            [self addSubview:lefteffe];
        //    10.1.扫描框

        _boxView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.2f, self.bounds.size.height * 0.2f, self.bounds.size.width - self.bounds.size.width * 0.4f, self.bounds.size.width - self.bounds.size.width * 0.4f)];
        _boxView.layer.borderColor = [UIColor greenColor].CGColor;
        _boxView.layer.borderWidth = 1.0f;
        [self addSubview:_boxView];
        //10.2.扫描线
        _scanLayer = [[CALayer alloc] init];
        _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
        _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
        [_boxView.layer addSublayer:_scanLayer];
        
      
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    CGRect cutrect = _boxView.frame;
    CGContextClearRect(context, cutrect);

}

/**
 *  @author Whde
 *
 *  添加扫码动画
 */
- (void)addAnimation{
    
    
    _scanLayer.hidden = NO;
    CABasicAnimation *animation = [LayerView moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:_boxView.bounds.size.height] rep:OPEN_MAX];
    [_scanLayer addAnimation:animation forKey:@"LineAnimation"];
}
/**
 *  @author Whde
 *
 *  去除扫码动画
 */
- (void)removeAnimation{
    
    [_scanLayer removeAnimationForKey:@"LineAnimation"];
    _scanLayer.hidden = YES;
}

+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}


@end
