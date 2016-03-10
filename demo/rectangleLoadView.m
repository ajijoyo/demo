//
//  rectangleLoadView.m
//  demo
//
//  Created by Dealjava on 3/9/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "rectangleLoadView.h"

@implementation rectangleLoadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self==[super init]) {
        [self prepareUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

-(void)awakeFromNib{
    [self prepareUI];
}

-(void)prepareUI{
    //default value
    _boundsRect = self.bounds.size.width;
    _radiusRect = self.bounds.size.width/5;
    _isRotate = YES;
    _strokeColor = self.tintColor;
    //
    
    rectPathlayer = [CAShapeLayer layer];
    rectPathlayer.frame = self.bounds;
    rectPathlayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:rectPathlayer];
    
    [self setProgress:0];//reset;
}

-(void)startAnimationonComplete:(rectangleHandler)handler{
    self.alpha = 1;
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    rectPathlayer.lineWidth = _radiusRect;
    rectPathlayer.strokeColor = _strokeColor.CGColor;
    rectPathlayer.strokeStart = 0;
    rectPathlayer.strokeEnd = 0;
    if (_isRotate) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anim.repeatCount = INFINITY;
        anim.duration = 3;
        anim.byValue = [NSNumber numberWithFloat:2 * M_PI];
        [rectPathlayer addAnimation:anim forKey:@"animation.rotate"];
    }
    action = handler;
}
-(void)startAnimation{
    [self startAnimationonComplete:nil];
    rectPathlayer.strokeStart = 0;
    rectPathlayer.strokeEnd = 1;
    [self setStrokeStart];
    
}

-(void)setStrokeStart{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5;
    group.repeatCount = INFINITY;
    group.autoreverses = YES;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    anim.duration = 0.2;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.byValue = [NSNumber numberWithFloat:_radiusRect];
    anim.toValue = [NSNumber numberWithFloat:10];
    
    group.animations = @[anim];
    
    [rectPathlayer addAnimation:group forKey:@"lineWidth"];
}

-(void)stopAnimation{
    [rectPathlayer removeAllAnimations];
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3, 1.3);
    } completion:^(BOOL isdone){
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
            self.alpha = 0;
        } completion:^(BOOL isdone){

        }];
    }];
}

-(UIBezierPath*)pathRect{
    CGRect rect = CGRectMake((self.bounds.size.width - _boundsRect) /2, (self.bounds.size.height - _boundsRect) /2, _boundsRect, _boundsRect);
    return [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(_radiusRect, _radiusRect)];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    rectPathlayer.frame = self.bounds;
    rectPathlayer.path = [self pathRect].CGPath;
}
-(CGFloat)progress{
    return rectPathlayer.strokeEnd;
}

-(void)setProgress:(CGFloat)progress{
    if (progress >= 1) {
        rectPathlayer.strokeEnd = 1;
        if (action) {
            [self stopAnimation];
            action();
        }
    }else if(progress < 0){
        rectPathlayer.strokeEnd = 0;
    }else{
        rectPathlayer.strokeEnd = progress;
    }
}

-(void)dealloc{
    NSLog(@"dealloc");
}

@end
