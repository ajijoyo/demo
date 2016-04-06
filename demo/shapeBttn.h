//
//  shapeBttn.h
//  demo
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface shapeBttn : UIButton
{
    UIColor *containerFillColor;
    CAShapeLayer *line;
//    BOOL selected;
}
@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,assign) IBInspectable CGFloat plusWidth;
@property(nonatomic,assign) IBInspectable CGFloat plusHeight;

@property(nonatomic,strong) IBInspectable UIColor *fillColor;
@property(nonatomic,strong) IBInspectable UIColor *fillColorHighligth;
@property(nonatomic,strong) IBInspectable UIColor *strokeColor;
@end
