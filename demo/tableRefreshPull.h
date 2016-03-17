//
//  tableRefreshPull.h
//  demo
//
//  Created by Dealjava on 3/17/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rectangleLoadView.h"

@protocol tableRefreshPullDelegate <NSObject>

-(void)refreshDidTrigger;

@end

@interface tableRefreshPull : UITableView
{
    UIRefreshControl *pullrefresh;
    rectangleLoadView *loadingview;
}
@property(nonatomic,weak) id<tableRefreshPullDelegate> pullDelegate;
-(void)tableRefreshPullDidScroll:(UIScrollView*)scrollview;
@end
