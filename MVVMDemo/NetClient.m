//
//  NetClient.m
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import "NetClient.h"
#import "Urls.h"
@implementation NetClient
-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];

    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 10;
        

    }
    return self;
}

+(NetClient *)netClient{
    return [[NetClient alloc]initWithBaseURL:[NSURL URLWithString:kApi_Get_HomePageList]];
}

+(instancetype)shareNetClient{
    static NetClient *netClient;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netClient = [[NetClient alloc]initWithBaseURL:[NSURL URLWithString:kApi_Get_HomePageList]];
    });

    return netClient;

}

-(NSURLSessionDataTask *)getGetHomePageListWithPageSize:(NSUInteger)PageSize Page:(NSUInteger)page complete:(void (^)(id _Nullable))complete failure:(void (^)( NSError * _Nonnull))failure{
    NSDictionary *parameters = @{
                                  @"limit":@(PageSize),
                                  @"skip":@(page)
                                  };
    return  [self GET:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"status"] isEqual:@(1)]) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:10001 userInfo:@{NSLocalizedDescriptionKey:@"獲取數據失敗"}];
            failure(error);
        }
        complete(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
