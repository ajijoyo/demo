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

typedef NS_ENUM(NSUInteger,Aligment) {
    Center = 0,
    Left,
    Right
};

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

-(instancetype)initWithRadius:(CGFloat)radiusM paddingRadius:(CGFloat)paddingRadiusM andALigtment:(Aligment)aligment;
-(instancetype)initWithRadius:(CGFloat)radiusM paddingRadius:(CGFloat)paddingRadiusM;
-(instancetype)initWithAligment:(Aligment)aligment;

-(void)bttnDidTap:(bttnMenuHandler)handler;

/** autohide after bttn did tap :default is YES: */
@property(nonatomic,assign)BOOL isAutoHide;

@property(nonatomic,weak) NSArray *listBttn;
/** custom head bttn here */
@property(nonatomic,strong,readonly) bttnHeadMenu *headBttn;

@property(nonatomic,weak) NSArray<UIView *> *listCustomBttn;

@property(nonatomic,assign) Aligment aligment;

@end
