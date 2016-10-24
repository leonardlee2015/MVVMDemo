//
//  HomeVIewModel.m
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import "HomeVIewModel.h"
#import "NetClient.h"

@interface HomeVIewModel ()
@property (nonnull,nonatomic,readonly) NetClient *client;
@property (nonnull,nonatomic,strong) NSMutableArray <HomeModel*> *homeModels;
@property (nonatomic) NSUInteger page;
@property (nonatomic) BOOL didLoadAllData;
@end
@implementation HomeVIewModel

-(void)handleDataRestart:(BOOL)restart success:(void (^)(NSArray<HomeModel*>* _Nonnull homeModels))success failure:(void (^)(NSError * _Nonnull error))failure{
    if (restart) {
        self.page = 0;
    }

    __weak typeof(self) weakSlef = self;
    [self.client getGetHomePageListWithPageSize:20 Page:self.page complete:^(id  _Nullable respondes) {
        NSArray *homeModeDics = respondes[@"data"][@"results"];

        if (homeModeDics) {
            NSMutableArray <HomeModel*>* tempArry = @[].mutableCopy;
            for (NSDictionary *homeDic in homeModeDics) {
                HomeModel *model = [[HomeModel alloc]initWithDic:homeDic];
                [tempArry addObject:model];
            }

            if (tempArry.count < 20) {
                weakSlef.didLoadAllData = YES;
            }

            if (restart) {
                [weakSlef.homeModels removeAllObjects];
                [weakSlef.homeModels addObjectsFromArray:tempArry];

            }else{
                [weakSlef.homeModels addObjectsFromArray:tempArry];
                weakSlef.page ++;

            }
            success(weakSlef.homeModels.copy);

        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
@synthesize client = _client;
-(NetClient *)client{
    if (!_client) {
        _client = [NetClient netClient];
    }
    return _client;
}

-(NSMutableArray<HomeModel *> *)homeModels{
    if (!_homeModels) {
        _homeModels = @[].mutableCopy;
    }
    return _homeModels;
}
@end
