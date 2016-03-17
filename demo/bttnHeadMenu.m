//
//  bttnHeadMenu.m
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "bttnHeadMenu.h"

@implementation bttnHeadMenu


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    path.lineWidth = 1;
    [_fillColor setFill];
    [path fill];
    
}

-(instancetype)initWithSize:(CGSize)sizeM{
    if (self==[super initWithFrame:CGRectMake(0, 0, sizeM.width, sizeM.height)]) {
        _fillColor = self.tintColor;
        _strokeColor = [UIColor whiteColor];
        containerColor = _fillColor;
        
        [self shape];
    }
    return self;
}

-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    shapeLayer.strokeColor = _strokeColor.CGColor;
}

-(void)shape{
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.lineWidth = MIN(self.bounds.size.width, self.bounds.size.height)*0.08;
    shapeLayer.strokeColor = _strokeColor.CGColor;
    shapeLayer.path = [self path].CGPath;
    [self.layer addSublayer:shapeLayer];
}
-(UIBezierPath*)path{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-(self.bounds.size.height/4))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)+(self.bounds.size.height/4))];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds)-(self.bounds.size.height/4), CGRectGetMidY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)+(self.bounds.size.height/4), CGRectGetMidY(self.bounds))];
    return path;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    if (!self.isSelected) {
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        morph.duration = 0.3;
        morph.fromValue = @([self radiansFromDegree:0]);
        morph.toValue = @([self radiansFromDegree:45]);
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [shapeLayer addAnimation:morph forKey:morph.keyPath];
        self.isSelected = YES;
    }else{
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        morph.duration = 0.3;
        morph.fromValue = @([self radiansFromDegree:45]);
        morph.toValue = @([self radiansFromDegree:0]);
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [shapeLayer addAnimation:morph forKey:morph.keyPath];
        self.isSelected = NO;
    }
}
-(CGFloat)radiansFromDegree:(CGFloat)degree{
    return (M_PI/180)*degree;
}

#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.transform = CGAffineTransformMakeScale(0.9, 0.9);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

@end
