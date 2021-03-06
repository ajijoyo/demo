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
//    [self line];
}

-(void)awakeFromNib{
    containerFillColor = _fillColor;
    [self line];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
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
    if (!_isSelected) {
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.fromValue = (id)[self normal];
        morph.toValue = (id)[self setSelectedPath];
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [line addAnimation:morph forKey:morph.keyPath];
        _isSelected = YES;
    }else{
        CABasicAnimation *morph = [CABasicAnimation animationWithKeyPath:@"path"];
        morph.duration = 0.5;
        morph.fromValue = (id)[self setSelectedPath];
        morph.byValue = (id)[self normal];
        morph.fillMode = kCAFillModeForwards;
        morph.removedOnCompletion = NO;
        [line addAnimation:morph forKey:morph.keyPath];
        _isSelected = NO;
    }
}


-(CGPathRef)normal{
    UIBezierPath *plus = [UIBezierPath bezierPath];
    
    [plus moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusWidth))];
    [plus closePath];
    [plus addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusWidth))];
    
    
//    [plus moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)- (_plusHeight/2))];
//    [plus addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)+ (_plusHeight/2))];
//    [plus closePath];
    
    [plus moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/2), CGRectGetMidY(self.bounds)-(_plusWidth))];
    [plus addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/2), CGRectGetMidY(self.bounds)- (_plusWidth))];
    
    
    return plus.CGPath;
}

-(CGPathRef)setSelectedPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    //triangle
//    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
//    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)+(_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/4))];
//    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-(_plusHeight/2), CGRectGetMidY(self.bounds)+(_plusHeight/4))];
//    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-(_plusHeight/2))];
    
    //close
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/3), CGRectGetMidY(self.bounds)-(_plusHeight/3))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/3), CGRectGetMidY(self.bounds)+(_plusHeight/3))];
    
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds) - (_plusHeight/3), CGRectGetMidY(self.bounds)+(_plusHeight/3))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds) + (_plusHeight/3), CGRectGetMidY(self.bounds)-(_plusHeight/3))];
    
    [path closePath];
    return path.CGPath;
}

#pragma mark - touch delegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.state == UIControlStateNormal) {
        if (_fillColorHighligth) {
            _fillColor = _fillColorHighligth;
        }
        [self setNeedsDisplay];
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.state == UIControlStateNormal) {
        _fillColor = containerFillColor;
        [self setNeedsDisplay];
    }
    
}

@end
