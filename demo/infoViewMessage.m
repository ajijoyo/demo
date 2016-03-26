//
//  infoViewMessage.m
//  demo
//
//  Created by Dealjava on 3/24/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "infoViewMessage.h"

@implementation infoViewMessage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initonRect:(CGRect)rect{
    return [self initWithString:@"" onRect:rect];
}

-(instancetype)initWithString:(NSString*)message onRect:(CGRect)rect{
    if (self==[super initWithFrame:[UIScreen mainScreen].bounds]) {
        _message = message;
        rectCenter = rect;
        
        mainScrollView = [[UIScrollView alloc]init];
        
        messageInfo = [[UILabel alloc]initWithFrame:mainScrollView.bounds];
        messageInfo.textAlignment = NSTextAlignmentCenter;
        messageInfo.textColor = [UIColor blackColor];
        messageInfo.backgroundColor = [UIColor clearColor];
        messageInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        [self addSubview:mainScrollView];
        [mainScrollView addSubview:messageInfo];
        
        messageInfo.center = mainScrollView.center;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        //testing
        messageInfo.backgroundColor = [UIColor yellowColor];
        mainScrollView.backgroundColor = [UIColor brownColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [mainScrollView addGestureRecognizer:pan];
    }
   return self;
}

-(void)calculateMessage{
    messageInfo.text = _message;
    CGSize size = [messageInfo sizeThatFits:CGSizeMake(self.bounds.size.width - 54, MAXFLOAT)];
    mainScrollView.frame = CGRectMake(0, 0, size.width + 20, size.height + 32);
    mainScrollView.center = self.center;
    
}

-(void)createBoundsLayer{
    [self calculateMessage];
}

-(UIBezierPath*)boundsPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
//    path moveToPoint:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    return path;
}


-(void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint point = [sender translationInView:self];
    NSLog(@"%@",NSStringFromCGPoint(point));
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateBegan) {
        mainScrollView.transform = CGAffineTransformMakeTranslation(point.x*0.8, point.y*0.8);

    }else{
        [UIView animateWithDuration:0.2 animations:^{
            mainScrollView.transform = CGAffineTransformIdentity;
        }];
    }
    
    if ((point.y < -90 || point.y > 90 || point.x < -50 || point.x > 50)&& (sender.state != UIGestureRecognizerStateChanged)) {
        
        [UIView animateWithDuration:0.4 animations:^{
            mainScrollView.transform = CGAffineTransformMakeTranslation(point.x*5, point.y*5);
        }completion:^(BOOL isdone){
            [self hide];
        }];
        
    }
    
}

-(void)show{
    [self calculateMessage];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hide{
    [self removeFromSuperview];
}

@end
