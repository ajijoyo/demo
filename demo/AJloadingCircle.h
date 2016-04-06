//
//  AJloadingCircle.h
//  demo
//
//  Created by Dealjava on 4/6/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJloadingCircle : UIView
{
    CAShapeLayer *centerCircle;
    CAShapeLayer *circle1,*circle2,*circle3;
}
@property(nonatomic,strong) UIColor *fillColor;

/** show animation */
-(void)show;
/** hide animation */
-(void)hide;

/*
 #use
 
 let coba1 = AJloadingCircle(frame: CGRect(x: 0, y: 300, width: 150, height: 100));
 coba1.show()
 coba1.hide()
 
 */

@end
