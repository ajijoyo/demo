//
//  drawPath.m
//  test
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 oirignesia. All rights reserved.
//

#import "drawPath.h"

@implementation drawPath


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddRelativeArc(path, NULL, CGRectGetMidX(rect), CGRectGetMidY(rect), _radius, _angle, _startAngle);
    CGPathAddQuadCurveToPoint(path, NULL, 0, rect.size.height, rect.size.width, _radius);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.size.width, 0);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextSetStrokeColorWithColor(ctx,[UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    CGPathRelease(path);
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)awakeFromNib{
    self.backgroundColor = [UIColor whiteColor];

}
-(void)setStartAngle:(CGFloat)startAngle{
    _startAngle = startAngle;
    [self setNeedsDisplay];
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self setNeedsDisplay];
}

-(void)setAngle:(CGFloat)angle{
    _angle = angle;
    [self setNeedsDisplay];
}

@end
