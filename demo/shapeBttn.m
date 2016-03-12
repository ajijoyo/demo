//
//  shapeBttn.m
//  demo
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "shapeBttn.h"

@implementation shapeBttn


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [_fillColor setFill];
    [path fill];
    
}

-(void)awakeFromNib{
    containerFillColor = _fillColor;
    [self line];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self setTitle:@"" forState:UIControlStateNormal];
    _fillColor = self.tintColor;
    _strokeColor = [UIColor whiteColor];
    _plusWidth = 3.0;
    _plusHeight = MIN(self.bounds.size.width, self.bounds.size.height) * 0.6 ;
    containerFillColor = _fillColor;
    [self line];
}

-(void)line{
    line = [CAShapeLayer layer];
    line.lineWidth = _plusWidth;
    line.strokeColor = _strokeColor.CGColor;
    line.fillColor = [UIColor clearColor].CGColor;
    line.path = [self normal];
    line.frame = self.bounds;
    [self.layer addSublayer:line];
    
}

-(void)setSelected:(BOOL)select{
    if (!selected) {
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.toValue = (id)[self setSelectedPath];
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [line addAnimation:morph forKey:@"path"];
        selected = YES;
    }else{
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.fromValue = (id)[self setSelectedPath];
        morph.byValue = (id)[self normal];
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [line addAnimation:morph forKey:@"path"];
        selected = NO;
    }
}


-(CGPathRef)normal{
    UIBezierPath *plus = [UIBezierPath bezierPath];
    
    [plus moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/2), CGRectGetMidY(self.bounds))];
    [plus addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/2), CGRectGetMidY(self.bounds))];
    [plus closePath];
    
    [plus moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)- (_plusHeight/2))];
    [plus addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)+ (_plusHeight/2))];
    [plus closePath];
    
    return plus.CGPath;
}

-(CGPathRef)setSelectedPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    //triangle
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)+(_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/4))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-(_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/4))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
    
    //close
//    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/2), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
//    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/2))];
//    
//    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/2))];
//    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/2), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
    
    [path closePath];
    return path.CGPath;
}

#pragma mark - touch delegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIControlStateNormal) {
        if (_fillColorHighligth) {
            _fillColor = _fillColorHighligth;
        }
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
        [self setNeedsDisplay];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.state == UIControlStateNormal) {
        _fillColor = containerFillColor;
        self.transform = CGAffineTransformMakeScale(1, 1);
        [self setNeedsDisplay];
    }
    
}

@end
