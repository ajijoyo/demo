//
//  infoViewMessage.h
//  demo
//
//  Created by Dealjava on 3/24/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,pointCenterY){
    top,
    bottom
};

typedef NS_ENUM(NSInteger,pointCenterX){
    left,
    right
};

@interface infoViewMessage : UIView
{
    
    UIScrollView *mainScrollView;
    UILabel *messageInfo;
    CGRect rectCenter;
    
    CAShapeLayer *boundsLayer;
    pointCenterY pointcenterY;
    pointCenterX pointcenterX;
}

@property(nonatomic,weak) NSString *message;

-(instancetype)initWithString:(NSString*)message onRect:(CGRect)rect;
-(void)show;
@end
