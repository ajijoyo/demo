//
//  tableRefreshPull.m
//  demo
//
//  Created by Dealjava on 3/17/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "tableRefreshPull.h"

@implementation tableRefreshPull

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self==[super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    pullrefresh =[UIRefreshControl new];
    pullrefresh.tintColor = [UIColor clearColor];
    pullrefresh.backgroundColor = [UIColor yellowColor];
    [pullrefresh addTarget:self action:@selector(refreshPull) forControlEvents:UIControlEventValueChanged];
    pullrefresh.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    loadingview  = [[rectangleLoadView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    loadingview.center = pullrefresh.center;
    
    [pullrefresh addSubview:loadingview];
    
    [self addSubview:pullrefresh];
}

-(void)tableRefreshPullDidScroll:(UIScrollView *)scrollview{

    CGFloat scale = scrollview.contentOffset.y/60;
    if (scale>1.0) {
        scale=1;
    }
    pullrefresh.transform = CGAffineTransformMakeScale(ABS(scale), ABS(scale));
}

-(void)refreshPull{
    [loadingview startAnimation];
    [_pullDelegate refreshDidTrigger];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [pullrefresh endRefreshing];
    });
}

-(void)refreshEnd{
    [loadingview stopAnimation];
    [pullrefresh endRefreshing];
}

@end
