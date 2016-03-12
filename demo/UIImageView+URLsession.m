//
//  UIImageView+URLsession.m
//  demo
//
//  Created by Dealjava on 3/10/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "UIImageView+URLsession.h"

@implementation UIImageView(UIImageView_URLsession)
@dynamic loading,maxProgess,dataToDownload;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView*)downloadImageWithUrl:(NSURL*)urlLink placeHolder:(UIImage*)placeholder{
    
    [self downloadDataTask:urlLink blocks:^(id messageResponse,NSURLResponse *urlResponse,NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = [UIImage imageWithData:messageResponse];
        });
    }];
    self.image = placeholder;
    
    return self;
}

-(void)downloadDataTask:(NSURL*)urlLink blocks:(void(^)(id messageResponse,NSURLResponse *urlResponse,NSError *error))blocks{
    NSURLSessionConfiguration *configSession = [NSURLSessionConfiguration defaultSessionConfiguration];
    configSession.timeoutIntervalForRequest = 30;
    configSession.timeoutIntervalForResource = 30;
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:configSession delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL: urlLink completionHandler:^(NSData *data,NSURLResponse *urlrespon,NSError *error){
        blocks(data,urlrespon,error);
    }];

    [dataTask resume];
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
//    self.maxProgess = [response expectedContentLength];
//    self.dataToDownload = [NSMutableData data];
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
//    [self.dataToDownload appendData:data];
//    NSLog(@"%f",self.maxProgess / [self.dataToDownload length]);

}
-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
//    self.loading.progress = 0;
//    [self.loading stopAnimation];
}


@end
