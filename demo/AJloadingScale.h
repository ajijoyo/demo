//
//  AJloadingScale.h
//  demo
//
//  Created by Dealjava on 4/6/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJloadingScale : UIView
{
    UIImageView *image1,*image2,*image3,*image4,*image5,*image6;
    CAShapeLayer *line;
}
-(void)show;
-(void)hide;
@end
