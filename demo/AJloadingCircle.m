//
//  AJloadingCircle.m
//  demo
//
//  Created by Dealjava on 4/6/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "AJloadingCircle.h"


static CGFloat defaultCircle = 10;
static CGFloat defaultCircleSmall = 7;
static CGFloat speed = 0.7;// 0.1 - 1
@implementation AJloadingCircle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCircle];
    }
    return self;
}

-(void)setupCircle{
    centerCircle = [CAShapeLayer layer];
    centerCircle.backgroundColor = !_fillColor ? [UIColor grayColor].CGColor : _fillColor.CGColor;
    centerCircle.frame = CGRectMake((self.bounds.size.width-defaultCircle)/2, (self.bounds.size.height-defaultCircle)/2, defaultCircle, defaultCircle);
    centerCircle.cornerRadius = defaultCircle/2;
    centerCircle.masksToBounds = YES;
    [self.layer addSublayer:centerCircle];
    
    circle1 = [CAShapeLayer layer];
    circle1.backgroundColor = !_fillColor ? [UIColor grayColor].CGColor : _fillColor.CGColor;
    circle1.frame = CGRectMake((self.bounds.size.width-defaultCircleSmall)/2 + (defaultCircleSmall*2), (self.bounds.size.height-defaultCircleSmall)/2, defaultCircleSmall, defaultCircleSmall);
    circle1.cornerRadius = defaultCircleSmall/2;
    circle1.masksToBounds = YES;
    [self.layer insertSublayer:circle1 below:centerCircle];
    
    circle2 = [CAShapeLayer layer];
    circle2.backgroundColor = circle1.backgroundColor;
    circle2.frame = CGRectMake((self.bounds.size.width-defaultCircleSmall)/2 + (defaultCircleSmall*4) , (self.bounds.size.height-defaultCircleSmall)/2, defaultCircleSmall, defaultCircleSmall);
    circle2.cornerRadius = defaultCircleSmall/2;
    circle2.masksToBounds = YES;
    [self.layer insertSublayer:circle2 below:centerCircle];
    
    circle3 = [CAShapeLayer layer];
    circle3.backgroundColor = circle2.backgroundColor;
    circle3.frame = CGRectMake((self.bounds.size.width-defaultCircleSmall)/2 + (defaultCircleSmall*6), (self.bounds.size.height-defaultCircleSmall)/2, defaultCircleSmall, defaultCircleSmall);
    circle3.cornerRadius = defaultCircleSmall/2;
    circle3.masksToBounds = YES;
    [self.layer insertSublayer:circle3 below:centerCircle];

}
-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    centerCircle.backgroundColor = !_fillColor ? [UIColor grayColor].CGColor : _fillColor.CGColor;
    circle1.backgroundColor = !_fillColor ? [UIColor grayColor].CGColor : _fillColor.CGColor;
    circle2.backgroundColor = circle1.backgroundColor;
    circle3.backgroundColor = circle2.backgroundColor;
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self animationrecrusif];
}

-(void)animationrecrusif{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.fromValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    anim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.8 :0.2 :0.2 :0.8];
    anim.duration = 1*speed;
    anim.autoreverses = YES;
    anim.repeatCount = INFINITY;
    [centerCircle addAnimation:anim forKey:anim.keyPath];
    CABasicAnimation *canim = [self animationWithDuration:2 position:CGPointMake(-(defaultCircleSmall*4), 0)];
    [circle1 addAnimation:canim forKey:canim.keyPath];
    
    CABasicAnimation *canim1 =[self animationWithDuration:2 position:CGPointMake(-(defaultCircleSmall*8), 0)];
    [circle2 addAnimation:canim1 forKey:canim1.keyPath];
    
    CABasicAnimation *canim2 =[self animationWithDuration:2 position:CGPointMake(-(defaultCircleSmall*12), 0)];
    [circle3 addAnimation:canim2 forKey:canim2.keyPath];
    
}

-(CABasicAnimation*)animationWithDuration:(CFTimeInterval)duration position:(CGPoint)topos{

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    anim.toValue = [NSValue valueWithCGPoint:topos];
    anim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0.8 :0.8 :0.5];
    anim.autoreverses = YES;
    anim.duration = duration*speed;
    anim.repeatCount = INFINITY;
    return anim;
}

-(void)hide{
    [self removeFromSuperview];
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];
}

@end
