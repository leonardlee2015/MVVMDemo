//
//  HomeVIewModel.h
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import "HomeModel.h"

@interface HomeVIewModel : NSObject
-(void)handleDataRestart:(BOOL)restart success:(nullable void (^)(NSArray<HomeModel*>* _Nonnull homeModels))success failure:(nullable void (^)(NSError * _Nonnull error)) failure;

@end
