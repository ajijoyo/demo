//
//  drawPath.h
//  test
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 oirignesia. All rights reserved.
//

#import <UIKit/UIKit.h>

#define radians(x) (M_PI/180)*x

@interface drawPath : UIView

@property(nonatomic,assign) CGFloat angle;
@property(nonatomic,assign) CGFloat startAngle;
@property(nonatomic,assign) CGFloat radius;
@end
