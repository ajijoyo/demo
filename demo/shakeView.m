//
//  shakeView.m
//  demo
//
//  Created by Dealjava on 2/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "shakeView.h"

@implementation UIView(shakeView)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)shakeView{
    dispatch_async(dispatch_get_main_queue(), ^{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        [animation setDuration:0.05];
        [animation setRepeatCount:3];
        [animation setAutoreverses:YES];
        [animation setFromValue:[NSNumber numberWithFloat:-10.0f]];
        [animation setToValue:[NSNumber numberWithFloat:+10.0f]];
        [self.layer addAnimation:animation forKey:@"transform.translation.x"];
    });
    
}

@end
