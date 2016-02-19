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
    if (self == [super init]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [self setup];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    circleRadius = 20;
    circlePathlayer = [CAShapeLayer layer];
    circlePathlayer.frame = self.bounds;
    circlePathlayer.lineWidth = 6;
    circlePathlayer.fillColor = [UIColor clearColor].CGColor;
    circlePathlayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:circlePathlayer];
    self.backgroundColor = [UIColor grayColor];
    
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
    CGRect rect = CGRectMake(0, 0, circleRadius * 2, circleRadius * 2);
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
