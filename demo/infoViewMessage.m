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
        
        messageInfo = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, mainScrollView.bounds.size.width, mainScrollView.bounds.size.height-15)];
        messageInfo.textAlignment = NSTextAlignmentCenter;
        messageInfo.textColor = [UIColor whiteColor];
        messageInfo.font = [UIFont systemFontOfSize:15];
        messageInfo.backgroundColor = [UIColor clearColor];
        messageInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        messageIcon = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"info"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        messageIcon.frame = CGRectMake(2.5, 0, 10, 10);
        messageIcon.contentMode = UIViewContentModeScaleAspectFit;
        messageIcon.tintColor = [UIColor whiteColor];

        [self addSubview:mainScrollView];
        
        [mainScrollView addSubview:messageInfo];
        [mainScrollView addSubview:messageIcon];
        
        messageInfo.center = mainScrollView.center;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [mainScrollView addGestureRecognizer:pan];
    }
   return self;
}

-(void)calculateMessage{
    messageInfo.text = _message;
    CGSize size = [messageInfo sizeThatFits:CGSizeMake(self.bounds.size.width - 54, MAXFLOAT)];
    mainScrollView.frame = CGRectMake(0, 0, size.width + 24, size.height + 8);
    mainScrollView.center = self.center;
    messageInfo.frame = CGRectMake(15, 0, size.width, mainScrollView.bounds.size.height);
    
    CGPoint centerIcon = messageIcon.center;
    centerIcon.y = mainScrollView.bounds.size.height/2;
    messageIcon.center = centerIcon;
    
}

-(void)createBoundsLayer{
    [self calculateMessage];
    boundsLayer = [CAShapeLayer layer];
    boundsLayer.path = [self boundsPath].CGPath;
    boundsLayer.fillColor = self.tintColor.CGColor;
    [mainScrollView.layer insertSublayer:boundsLayer below:messageInfo.layer];
}

-(UIBezierPath*)boundsPath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:mainScrollView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    return path;
}


-(void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint point = [sender translationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(point));
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateBegan) {
        mainScrollView.transform = CGAffineTransformMakeTranslation(point.x, point.y);

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
    [self createBoundsLayer];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hide{
    [self removeFromSuperview];
}

@end
