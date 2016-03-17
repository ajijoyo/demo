//
//  circleLoadView.m
//  demo
//
//  Created by Dealjava on 2/19/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "circleLoadView.h"

@implementation circleLoadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self=[super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
//    [self setup];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    _circleRadius = 20;
    _lineWidth = 6;
    circlePathlayer = [CAShapeLayer layer];
    circlePathlayer.frame = self.bounds;
    circlePathlayer.lineWidth = _lineWidth;
    circlePathlayer.strokeStart = 0;
    circlePathlayer.fillColor = [UIColor blueColor].CGColor;
    circlePathlayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:circlePathlayer];
    self.backgroundColor = [UIColor clearColor];
    
}

-(void)revelar{
    self.backgroundColor = [UIColor clearColor];
    [circlePathlayer removeAnimationForKey:@"strokeEnd"];
    [circlePathlayer removeFromSuperlayer];

    if (self.superview) {
        self.superview.layer.mask = circlePathlayer;
    }
}

-(void)circleLoadDidFinish:(circleHandler)handler{
    action = handler;
}

-(CGRect)circleFrame{
    CGRect rect = CGRectMake(0, 0, _circleRadius * 2, _circleRadius * 2);
    rect.origin.x = CGRectGetMidX(circlePathlayer.bounds) - CGRectGetMidX(rect);
    rect.origin.y = CGRectGetMidY(circlePathlayer.bounds) - CGRectGetMidY(rect);
    return rect;
}

-(UIBezierPath *)circlePath{
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    circlePathlayer.frame = self.bounds;
    circlePathlayer.path = [self circlePath].CGPath;
}

-(void)startAnimation{
    circlePathlayer.strokeEnd = 0.5;
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spin.repeatCount = INFINITY;
    spin.duration = 3;
    spin.byValue = [NSNumber numberWithFloat:2.0 * M_PI];
    [circlePathlayer addAnimation:spin forKey:@"spinanimation"];

}
-(void)stopAnimation{
    [circlePathlayer removeAnimationForKey:@"spinanimation"];
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spin.repeatCount = 1;
    spin.duration = 1;
    spin.byValue = [NSNumber numberWithFloat:2.0 * M_PI];
    [circlePathlayer addAnimation:spin forKey:@"spinanimation"];

}

#pragma mark - getter setter progress

-(CGFloat)progress{
    return circlePathlayer.strokeEnd;
}
-(void)setProgress:(CGFloat)progress{
    if (progress > 1) {
        circlePathlayer.strokeEnd = 1;
        if (action) {
            [self revelar];
            action();
        }
    }else if(progress < 0){
        circlePathlayer.strokeEnd = 0;
    }else{
        circlePathlayer.strokeEnd = progress;
    }
}

#pragma mark ----
@end
