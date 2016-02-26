//
//  URLsession.m
//  demo
//
//  Created by Dealjava on 2/26/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "URLsession.h"

@implementation URLsession

+(instancetype)sharedInstance{
    static URLsession *shared;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shared = [[URLsession alloc]init];
    });
    return shared;
}

-(id)init{
    if (self==[super init]) {
        queue = [NSMutableArray array];
        self.timeOut = 30.0;
    }
    return self;
}

-(void)sessionIsFinish:(sessionHandler)handler{
    actionSession = handler;
}

-(void)clearAllSession{
    for (NSURLSessionDataTask *dataTask in queue) {
        [dataTask cancel];
    }
}

-(void)sentURL:(NSString*)urlString Methods:(Methods)methods withParams:(NSDictionary*)params blocks:(void(^)(id messageResponse,NSURLResponse *urlResponse,NSError *error))blocks{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.timeOut];
    if (methods==GET) {
        request.HTTPMethod = @"GET";
    }else if (methods==POST){
        request.HTTPMethod = @"POST";
    }
    
    NSAssert(params==nil, @"parameter cannot be nil!!!");
    NSError *error;
    NSData *parsingData = [NSJSONSerialization dataWithJSONObject:params
                                    options:NSJSONWritingPrettyPrinted
                                      error:&error];

    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.HTTPBody = parsingData;
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)parsingData.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){

        id responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                blocks(responseData,response,error);
        if (self.sessionQueue == 0) {
            if (actionSession) {
                actionSession();
            }
        }
                                                
                                            }];
    [queue addObject:task];
    [task resume];
}


@end
