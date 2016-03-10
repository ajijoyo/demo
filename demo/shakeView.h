//
//  shakeView.h
//  demo
//
//  Created by Dealjava on 2/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(shakeView)
/** shake view (-10.f to 10.f) */
-(void)shakeView;
@end




@interface METHODS : NSObject

/** perform blocks with delay (CGFloat) */
+(void)performWithDelay:(CGFloat)delay blocks:(void(^)())blocks;

@end