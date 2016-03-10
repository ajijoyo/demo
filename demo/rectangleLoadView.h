//
//  rectangleLoadView.h
//  demo
//
//  Created by Dealjava on 3/9/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^rectangleHandler)();

@interface rectangleLoadView : UIView
{
    CAShapeLayer * rectPathlayer;
    rectangleHandler action;
    
    CABasicAnimation *anim1,*anim2,*anim3,*anim4,*anim5;
}

@property(nonatomic,assign) CGFloat boundsRect;
@property(nonatomic,assign) CGFloat radiusRect;
@property(nonatomic,assign) CGFloat progress;
@property(nonatomic,weak) UIColor *strokeColor;
@property(nonatomic,assign) BOOL isRotate;
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
