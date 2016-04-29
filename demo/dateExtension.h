//
//  dateExtension.h
//  demo
//
//  Created by Dealjava on 4/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(dateExtension)

/** change nsdate to string with format dd MM yyyy */
@property(nonatomic,weak,readonly) NSString *toString;

/** change nsdate to string with compare current date */
@property(nonatomic,weak,readonly) NSString *toStringCurrentTime;
@end
