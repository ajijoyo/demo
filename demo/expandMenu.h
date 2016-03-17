//
//  expandMenu.h
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bttnHeadMenu.h"
#import "bttnMenu.h"


typedef void (^bttnMenuHandler)(bttnMenu *sender);

@interface expandMenu : UIView
{
    CGFloat paddingMenu;
    NSLayoutConstraint *paddingBttm;
    NSLayoutConstraint *paddingRight;

    UIScrollView *scrollContainerBttn;
    CGFloat scrollHeight;
    CGFloat scrollWidth;
    CGFloat paddingEachBttn;
    
    UIVisualEffectView *visualEffectView;
    NSMutableArray *containerArrBttn;
    bttnMenuHandler action;

}


-(instancetype)initWithRadius:(CGFloat)radiusM paddingRadius:(CGFloat)paddingRadiusM;
-(void)bttnDidTap:(bttnMenuHandler)handler;

/** autohide after bttn did tap :default is YES: */
@property(nonatomic,assign)BOOL isAutoHide;

@property(nonatomic,weak) NSArray *listBttn;
/** custom head bttn here */
@property(nonatomic,strong,readonly) bttnHeadMenu *headBttn;

@end
