//
//  ArticeViewController.h
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/23.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@interface ArticeViewController : UIViewController
@property (nonnull,nonatomic,strong) HomeModel *model;

+(nullable ArticeViewController*)articeViewControllerByModel:(nonnull HomeModel*)model;
@end
