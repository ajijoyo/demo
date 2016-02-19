//
//  circleLoadView.h
//  demo
//
//  Created by Dealjava on 2/19/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^circleHandler)();

@interface circleLoadView : UIView
{
    CAShapeLayer * circlePathlayer;
    CGFloat circleRadius;
    circleHandler action;

}
@property(nonatomic,assign) CGFloat progress;

-(void)circleLoadDidFinish:(circleHandler)handler;
@end
