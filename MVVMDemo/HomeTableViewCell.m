//
//  HomeTableViewCell.m
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/22.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Define.h"
#import "HomeModel.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeTableViewCell ()
@property(nonatomic,nonnull,strong) UIView *customContentView;
@property(nonnull,nonatomic,strong) UIImageView *newsimageView;
@property(nonnull,nonatomic,strong) UILabel *newstitleLabel;
@property(nonnull,nonatomic,strong) UILabel *newssourcLabel;
@property(nonnull,nonatomic,strong) UILabel *newstypeLabel;


@end
@implementation HomeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];

        [self _setup];
    }

    return  self;
}
-(void)_setup{
    self.backgroundColor = [UIColor clearColor];

    [self.customContentView addSubview:self.newsimageView];
    [self.customContentView addSubview:self.newstitleLabel];
    [self.customContentView addSubview:self.newssourcLabel];
    [self.customContentView addSubview:self.newstypeLabel];

    __weak typeof(self) weakSlef = self;
    [_newsimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 60)).multipliedBy(kConstraintsMutiplie);
        make.left.top.equalTo(weakSlef.customContentView).offset(10).multipliedBy(kConstraintsMutiplie);
        make.bottom.mas_equalTo(weakSlef.customContentView).offset(-10);

    }];

    [_newstitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.newsimageView);
        make.left.equalTo(weakSlef.newsimageView.mas_right).offset(10).multipliedBy(kConstraintsMutiplie);
        make.right.equalTo(weakSlef.customContentView.mas_rightMargin).offset(-10).multipliedBy(kConstraintsMutiplie);

    }];

    [_newssourcLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSlef.newstitleLabel);
        make.top.equalTo(weakSlef.newstitleLabel.mas_bottom).offset(5).multipliedBy(kConstraintsMutiplie);

        make.height.equalTo(weakSlef.newstitleLabel.mas_height).multipliedBy(0.5);
        make.width.equalTo(weakSlef.newstypeLabel);
        
    }];
    [_newstypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(weakSlef.newssourcLabel.mas_right);
        make.top.equalTo(weakSlef.newssourcLabel);
        make.right.equalTo(weakSlef.customContentView.mas_rightMargin).offset(-10).multipliedBy(kConstraintsMutiplie);

        make.size.equalTo(weakSlef.newssourcLabel);
        
    }];
}


-(void)awakeFromNib {

    [super awakeFromNib];
    // Initialization code
    [self _setup];
}

-(void)setModel:(HomeModel *)model{
    [self.newsimageView sd_setImageWithURL:model.newsImage placeholderImage:[UIImage imageNamed:@"tu_empty"]];
    self.newstitleLabel.text = model.newsTitle;
    self.newssourcLabel.text = model.newsSource;
    self.newstypeLabel.text = model.newsType;

}

-(UILabel *)newstitleLabel{
    if (!_newstitleLabel) {
        _newstitleLabel = [UILabel new];
        _newstitleLabel.numberOfLines = 0;
        _newstitleLabel.font = UIFont_size(12.0);
        _newstitleLabel.textAlignment = NSTextAlignmentLeft;
        _newstitleLabel.textColor = kAppDarkGrayColor;

    }
    return _newstitleLabel;
}

-(UIImageView *)newsimageView{
    if (!_newsimageView) {
        _newsimageView = [UIImageView new];

    }
    return _newsimageView;
}

-(UILabel *)newssourcLabel{
    if (!_newssourcLabel) {
        _newssourcLabel = [UILabel new];
        _newssourcLabel.textAlignment = NSTextAlignmentLeft;
        _newssourcLabel.textColor = kAppGrayColor;
        _newssourcLabel.font = UIFont_size(12.0f);
    }
    return _newssourcLabel;
}

-(UILabel *)newstypeLabel{
    if (!_newstypeLabel) {
        _newstypeLabel = [UILabel new];
        _newstypeLabel.textAlignment = NSTextAlignmentRight;
        _newstypeLabel.textColor = kAppGrayColor;
        _newstypeLabel.font = UIFont_size(12.0f);
    }
    return _newstypeLabel;
}

-(UIView *)customContentView{
    if (!_customContentView) {
        _customContentView = [UIView new];
        _customContentView.backgroundColor = [UIColor whiteColor];

        [self.contentView addSubview:_customContentView];

        __weak typeof(self) weakSlef = self;;
        [_customContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSlef.contentView).insets(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
    }
    return _customContentView;
}
@end
