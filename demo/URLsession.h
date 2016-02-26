//
//  URLsession.h
//  demo
//
//  Created by Dealjava on 2/26/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    POST = 1,
    GET,
} Methods;

typedef void (^sessionHandler)();

@interface URLsession : NSObject
{
    sessionHandler actionSession;
}
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong)NSMutableArray *queue;

/** get n SET timeout request */
@property(nonatomic,assign)NSTimeInterval timeOut;

/** GET count current session */
@property(nonatomic,assign,readonly) NSInteger sessionQueue;

-(void)sentURL:(NSString*)urlString Methods:(Methods)methods withParams:(NSDictionary*)params blocks:(void(^)(id messageResponse,NSURLResponse *urlResponse,NSError *error))blocks;

+(instancetype)sharedInstance;
/** called when all session is finish */
-(void)sessionIsFinish:(sessionHandler)handler;
/**  cancel all session */
-(void)clearAllSession;

@end
