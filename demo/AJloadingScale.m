//
//  AJloadingScale.m
//  demo
//
//  Created by Dealjava on 4/6/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "AJloadingScale.h"

@implementation AJloadingScale

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.bounds.size.height-30, 30, 60)];
    image1.backgroundColor = [UIColor greenColor];
    image1.layer.anchorPoint = CGPointMake(0, 1);
    
    image2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, self.bounds.size.height-50, 40, 100)];
    image2.backgroundColor = image1.backgroundColor;
    image2.layer.anchorPoint = CGPointMake(0, 1);
    
    image3 = [[UIImageView alloc]initWithFrame:CGRectMake(80, self.bounds.size.height-30, 30, 60)];
    image3.backgroundColor = image2.backgroundColor;
    image3.layer.anchorPoint = CGPointMake(0, 1);
    
    image4 = [[UIImageView alloc]initWithFrame:CGRectMake(130, self.bounds.size.height-50, 30, 100)];
    image4.backgroundColor = image3.backgroundColor;
    image4.layer.anchorPoint = CGPointMake(0, 1);
    
    [self addSubview:image1];
    [self addSubview:image2];
    [self addSubview:image3];
    [self addSubview:image4];
    
    line = [CAShapeLayer layer];
    line.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 3);
    line.path = [self path].CGPath;
    line.strokeStart = 0;
    line.lineWidth = 3;
    line.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:line];

}

-(UIBezierPath*)path{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    return path;
}

-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        [self topMostController].view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    image1.transform = CGAffineTransformMakeScale(0.1, 0.1);
    image2.transform = CGAffineTransformMakeScale(0.1, 0.1);
    image3.transform = CGAffineTransformMakeScale(0.1, 0.1);
    image4.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        image1.transform = CGAffineTransformMakeScale(1.2, 1.2);

    } completion:^(BOOL isdone){
        image1.transform = CGAffineTransformIdentity;
    }];
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.3 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        image2.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL isdone){
        image2.transform = CGAffineTransformIdentity;
    }];
    
    [UIView animateKeyframesWithDuration:0.3 delay:1.2 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        image3.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL isdone){
        image3.transform = CGAffineTransformIdentity;
    }];
    
    [UIView animateKeyframesWithDuration:0.3 delay:1.4 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        image4.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL isdone){
        image4.transform = CGAffineTransformIdentity;
    }];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.duration = 1.5;

    [line addAnimation:anim forKey:anim.keyPath];
    
}

-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        [self topMostController].view.transform = CGAffineTransformIdentity;
    }];
    
    [self removeFromSuperview];
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
