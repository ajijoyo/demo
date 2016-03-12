//
//  circleLoadView.h
//  demo
//
//  Created by Dealjava on 2/19/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
typedef void(^circleHandler)();

@interface circleLoadView : UIView
{
    CAShapeLayer * circlePathlayer;
    circleHandler action;

}
@property(nonatomic,assign) IBInspectable CGFloat circleRadius;
@property(nonatomic,assign) IBInspectable CGFloat lineWidth;
@property(nonatomic,assign) CGFloat progress;

-(void)circleLoadDidFinish:(circleHandler)handler;
-(void)startAnimation;
-(void)stopAnimation;
@end
