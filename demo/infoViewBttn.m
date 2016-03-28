//
//  infoViewBttn.m
//  demo
//
//  Created by Dealjava on 3/24/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "infoViewBttn.h"

@implementation infoViewBttn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(infobttn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)infobttn{
    CGRect frame2 = [self convertRect:self.bounds toView:self.superview];
    messageView = [[infoViewMessage alloc]initWithString:@"tesasdasdasd adsadt" onRect:frame2];
    [messageView show];
    
}

@end
