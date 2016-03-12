//
//  rectangleLoadView.h
//  demo
//
//  Created by Dealjava on 3/9/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
typedef void (^rectangleHandler)();

@interface rectangleLoadView : UIView
{
    CAShapeLayer * rectPathlayer;
    rectangleHandler action;
}

@property(nonatomic,assign)IBInspectable CGFloat boundsRect;
@property(nonatomic,assign)IBInspectable CGFloat radiusRect;
@property(nonatomic,assign)IBInspectable CGFloat progress;
@property(nonatomic,weak)IBInspectable UIColor *strokeColor;
@property(nonatomic,assign)IBInspectable BOOL isRotate;
/** 
 call when using progress 0 - 1 DO NOT CALL 'startAnimation'
 */
-(void)startAnimationonComplete:(rectangleHandler)handler;
/** call stop when infinity progress */
-(void)stopAnimation;
/**
 call start when infinity progress DO NOT CALL 'startAnimationonComplete:(rectangleHandler)handler'
 */
-(void)startAnimation;
@end
