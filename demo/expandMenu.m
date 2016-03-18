//
//  expandMenu.m
//  demo
//
//  Created by Dealjava on 3/16/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "expandMenu.h"

CGFloat radius = 40;
CGFloat paddingRadius = 25;


@implementation expandMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

}
*/


-(instancetype)initWithRadius:(CGFloat)radiusM paddingRadius:(CGFloat)paddingRadiusM{
    
    return [self initWithRadius:radiusM paddingRadius:paddingRadiusM andALigtment:0];
}

-(instancetype)initWithRadius:(CGFloat)radiusM paddingRadius:(CGFloat)paddingRadiusM andALigtment:(Aligment)aligment{
    if (self==[super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - radiusM - paddingRadiusM, [UIScreen mainScreen].bounds.size.height - radiusM - paddingRadiusM, radiusM, radiusM)]) {
        radius = radiusM;
        paddingRadius = paddingRadiusM;
        paddingMenu = 15;
        paddingEachBttn = 15;
        _isAutoHide = YES;
        _aligment = aligment;

        _headBttn = [[bttnHeadMenu alloc]initWithSize:CGSizeMake(radius, radius)];
        [_headBttn addTarget:self action:@selector(headBttnListener:) forControlEvents:UIControlEventTouchUpInside];
        _headBttn.translatesAutoresizingMaskIntoConstraints = NO;
        
        scrollContainerBttn = [[UIScrollView alloc]initWithFrame:_headBttn.bounds];
        scrollContainerBttn.contentSize = CGSizeZero;
        scrollContainerBttn.showsHorizontalScrollIndicator = NO;
        scrollContainerBttn.showsVerticalScrollIndicator = NO;
        
        [self addSubview:scrollContainerBttn];
        [self addSubview:_headBttn];
        [self autoLayout];
        
        containerArrBttn  = [NSMutableArray array];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

-(instancetype)initWithAligment:(Aligment)aligment{
    return [self initWithRadius:radius paddingRadius:paddingRadius andALigtment:aligment];
}

-(instancetype)init{
    return [self initWithRadius:radius paddingRadius:paddingRadius];
}
-(void)autoLayout{
    paddingBttm = [NSLayoutConstraint constraintWithItem:_headBttn
                                                attribute:NSLayoutAttributeBottom
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeBottom
                                               multiplier:1
                                                 constant:0];
    
    [self addConstraint:paddingBttm];
    
    paddingRight = [NSLayoutConstraint constraintWithItem:_headBttn
                                                attribute:NSLayoutAttributeRight
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeRight
                                               multiplier:1
                                                 constant:0];
    [self addConstraint:paddingRight];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_headBttn
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:0
                                                    multiplier:1
                                                      constant:radius]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_headBttn
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:0
                                                    multiplier:1
                                                      constant:radius]];
}

-(void)setAligment:(Aligment)aligment{
    _aligment = aligment;
    
}

-(void)setListBttn:(NSArray *)listBttn{
    _listBttn = listBttn;
    [self createButton];

}
-(void)setListCustomBttn:(NSArray<UIView *> *)listCustomBttn{
    _listCustomBttn = listCustomBttn;
    [containerArrBttn removeAllObjects];
    scrollHeight = 0;
    CGFloat ybttnx = 8;
    int i = 0;
    for (UIView *bttn in _listCustomBttn) {
        scrollWidth = bttn.bounds.size.width;
        bttn.frame = CGRectMake(0, 0, bttn.bounds.size.width, bttn.bounds.size.height);
        bttn.layer.shadowOffset = CGSizeMake(1.5, 1.5);
        bttn.layer.shadowColor = [UIColor blackColor].CGColor;
        bttn.layer.shadowOpacity = 0.5;
        
        ybttnx += bttn.bounds.size.height + paddingEachBttn;
        
        CGPoint center = bttn.center;
        center.x = (scrollWidth*1.3)/2;
        bttn.center = center;
        bttn.tag = i;
        [containerArrBttn addObject:bttn];
        
        i++;
        scrollHeight = ybttnx + paddingEachBttn;
    }
}

-(void)createButton{
    [containerArrBttn removeAllObjects];
    int i = 0;
    scrollHeight = 0;
    CGFloat ybttnx = 8;//add offset bttn first
    for (NSString *title in _listBttn) {
        bttnMenu *bttn = [[bttnMenu alloc]init];
        scrollWidth = bttn.bounds.size.width;
        bttn.frame = CGRectMake(0, 0, bttn.bounds.size.width, bttn.bounds.size.height);
        ybttnx += bttn.bounds.size.height + paddingEachBttn;
        
        CGPoint center = bttn.center;
        center.x = (scrollWidth*1.3)/2;
        bttn.center = center;
        
        bttn.title = title;
        bttn.tag = i;
        
        [bttn addTarget:self action:@selector(bttnMenuDidTap:) forControlEvents:UIControlEventTouchUpInside];
        [containerArrBttn addObject:bttn];
        i++;
        scrollHeight = ybttnx + paddingEachBttn;
    }
}

-(void)bttnDidTap:(bttnMenuHandler)handler{
    action = handler;
}

-(void)bttnMenuDidTap:(bttnMenu*)sender{
    if (action) {
        action(sender);
    }
    if (_isAutoHide) {
        [self dismiss];
    }
}

-(void)dismiss{
    [self headBttnListener:_headBttn];
}

-(void)headBttnListener:(bttnHeadMenu*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self showMenu];
    }else{
        [self hideMenu];
    }
}

-(UIImage*)blurEffect{

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 1);

    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];

    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

-(void)showMenu{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGFloat outofScreen = 0;
    if ([UIScreen mainScreen].bounds.size.height - scrollHeight - radius - paddingMenu >= 0) {
        outofScreen = [UIScreen mainScreen].bounds.size.height - scrollHeight - radius - paddingMenu;
    }else{
        outofScreen = 35;
    }
    
    scrollContainerBttn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - (scrollWidth*1.3) - paddingRadius, outofScreen, scrollWidth*1.3, MIN(scrollHeight,[UIScreen mainScreen].bounds.size.height - paddingMenu - radius - 35));
    scrollContainerBttn.contentSize = CGSizeMake(scrollWidth, scrollHeight);
    
    paddingBttm.constant = -paddingMenu;
    paddingRight.constant = -paddingMenu;
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [self animationBttn];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
//    [self insertSubview:visualEffectView atIndex:0];
}

-(void)animationBttn{
    int ybttnx = 8;
    for ( int i=0; i<containerArrBttn.count; i++) {
        UIView *bttn = containerArrBttn[i];
        CGRect frame = bttn.frame;
        frame.origin.y = scrollContainerBttn.bounds.size.height;
        bttn.frame = frame;
        [scrollContainerBttn addSubview:bttn];
        CGPoint position;
        CGFloat positionxDefault;
        switch (_aligment) {
            case Right:
                position = CGPointMake(scrollContainerBttn.bounds.size.width - paddingMenu - bttn.bounds.size.width, ybttnx);
                positionxDefault = position.x;
                break;
            case Center:
                position = CGPointMake(((scrollWidth*1.3)-bttn.bounds.size.width)/2, ybttnx);
                positionxDefault = (scrollWidth*1.3)/2;
                break;
            case Left:
                position = CGPointMake(paddingMenu, ybttnx);
                positionxDefault = position.x;
                break;
            default:
                break;
        }

        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL,scrollContainerBttn.bounds.size.width, scrollContainerBttn.bounds.size.height);
//        CGPathAddLineToPoint(path, NULL, (scrollWidth*1.3)/2, ybttnx);
        CGPathAddQuadCurveToPoint(path, NULL, 0, scrollContainerBttn.bounds.size.height/2, positionxDefault, ybttnx);
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = path;
        anim.duration = 0.5;
        
        [bttn.layer addAnimation:anim forKey:anim.keyPath];
        
        CGRect posi = bttn.frame;
        posi.origin = position;
        bttn.frame = posi;
        
        CGPathRelease(path);
        ybttnx += bttn.bounds.size.height + paddingEachBttn;
    }
}

-(void)hideMenu{
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - radius - paddingRadius, [UIScreen mainScreen].bounds.size.height - radius - paddingRadius, radius, radius);
    scrollContainerBttn.frame = self.bounds;
    
    paddingBttm.constant = 0 ;
    paddingRight.constant = 0;

    for (id bttn in containerArrBttn) {
        [bttn removeFromSuperview];
    }
    
    self.backgroundColor = [UIColor clearColor];
    [visualEffectView removeFromSuperview];
    visualEffectView = nil;
}

@end
