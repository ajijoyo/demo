//
//  bttnMenu.m
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "bttnMenu.h"

@implementation bttnMenu


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    titleBar.text = _title;
}


-(instancetype)init{
    if (self==[super initWithFrame:CGRectMake(0, 0, 100, 30)]) {
        [self circle];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self circle];
    }
    return self;
}

-(void)circle{
    circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3;
    circleLayer.strokeColor = self.tintColor.CGColor;
    circleLayer.fillColor = [UIColor whiteColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    circleLayer.path = path.CGPath;
    circleLayer.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
    circleLayer.shadowOffset = CGSizeMake(1.5, 1.5);
    circleLayer.shadowColor = [UIColor blackColor].CGColor;
    circleLayer.shadowOpacity = 0.5;
    
    [self.layer addSublayer:circleLayer];
    
    titleBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-self.bounds.size.height - 4, self.bounds.size.height)];
    
    titleBar.textAlignment = NSTextAlignmentRight;
    titleBar.textColor = self.tintColor;
    titleBar.layer.shadowOpacity = 0.5;
    titleBar.layer.shadowColor = [UIColor blackColor].CGColor;
    titleBar.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    [self addSubview:titleBar];
}


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
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
}
@end
