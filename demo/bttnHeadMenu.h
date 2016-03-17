//
//  bttnHeadMenu.h
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>
//custom button head here
@interface bttnHeadMenu : UIButton
{
    CAShapeLayer *shapeLayer;
    UIColor *containerColor;
}

-(instancetype)initWithSize:(CGSize)sizeM;

@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,weak) UIColor *fillColor;
@property(nonatomic,weak) UIColor *strokeColor;
@end
