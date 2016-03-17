//
//  bttnMenu.h
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

// edit custom bttn here
@interface bttnMenu : UIButton
{
    CAShapeLayer *circleLayer;
    UILabel *titleBar;
}
@property(nonatomic,strong) NSString *title;
@end
