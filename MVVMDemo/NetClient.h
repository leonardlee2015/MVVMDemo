//
//  NetClient.h
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface NetClient : AFHTTPSessionManager
+(nullable NetClient*)netClient;
+(nullable NetClient*)shareNetClient;

-(nullable NSURLSessionDataTask *)getGetHomePageListWithPageSize:(NSUInteger)PageSize Page:(NSUInteger)page complete:(nullable void (^)( id _Nullable respondes) ) complete failure:(nullable void (^)( NSError * _Nonnull error) )failure;
@end
