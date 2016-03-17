//
//  extensionBttn.m
//  demo
//
//  Created by Dealjava on 3/14/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "extensionBttn.h"

@implementation UIButton(extensionBttn)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
