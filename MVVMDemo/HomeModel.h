//
//  HomeModel.h
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeModel : JSONModel
@property (nullable,nonatomic,strong) NSString <Optional>*createdAt;
@property (nullable,nonatomic,strong) NSString <Optional>*newsCreateTime;
@property (nullable,nonatomic,strong) NSString <Optional>*newsId;
@property (nullable,nonatomic,strong) NSURL <Optional>*newsImage;
@property (nullable,nonatomic,strong) NSURL <Optional>*newsLink;
@property (nullable,nonatomic,strong) NSString <Optional>*newsNum;
@property (nullable,nonatomic,strong) NSString <Optional>*newsSource;
@property (nullable,nonatomic,strong) NSString <Optional>*newsTitle;
@property (nullable,nonatomic,strong) NSString <Optional>*newsType;
@property (nullable,nonatomic,strong) NSString <Optional>*newsTypeName;
@property (nullable,nonatomic,strong) NSString <Optional>*objectId;
@property (nullable,nonatomic,strong) NSString <Optional>*updatedAt;

-(nullable instancetype)initWithDic:(nonnull NSDictionary*)dic;
@end
