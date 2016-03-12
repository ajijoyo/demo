//
//  UIImageView+URLsession.h
//  demo
//
//  Created by Dealjava on 3/10/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "rectangleLoadView.h"

typedef void(^handler)(id messageResponse,NSURLResponse *urlResponse,NSError *error);

@interface UIImageView(UIImageView_URLsession)<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

-(UIImageView*)downloadImageWithUrl:(NSURL*)urlLink placeHolder:(UIImage*)placeholder;

@property(nonatomic,strong) handler action;
@property (nonatomic, retain) NSMutableData *dataToDownload;
@property(nonatomic) CGFloat maxProgess;
@property(nonatomic,strong) rectangleLoadView *loading;
@end
