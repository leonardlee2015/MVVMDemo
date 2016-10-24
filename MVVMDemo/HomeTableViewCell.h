//
//  HomeTableViewCell.h
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/22.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface HomeTableViewCell : UITableViewCell
-(void)setModel:(nonnull HomeModel*)model;
@end
