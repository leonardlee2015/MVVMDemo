//
//  ArticeViewController.m
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/23.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import "ArticeViewController.h"
#import "HomeModel.h"
#import "Define.h"

#import <Masonry.h>

@interface ArticeViewController ()<UIWebViewDelegate>
@property (nonatomic,nonnull,strong)UIWebView *webView;
@property (nonnull,nonatomic,strong)UIBarButtonItem *forwarkBtnItem;
@property (nonatomic,nonnull,strong)UIBarButtonItem *goBackBtnItem;

@end

@implementation ArticeViewController

+(ArticeViewController *)articeViewControllerByModel:(HomeModel *)model{
    ArticeViewController *vc = [ArticeViewController new];
    vc.model = model;

    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setup];

    if (self.model && self.model.newsLink) {
        [self requestArticeBy:self.model.newsLink];
    }


}

- (void)setup{
    self.view.backgroundColor = [UIColor whiteColor];

    UIToolbar *bar = [self createWebControlBar];

    [self.view addSubview:bar];
    [self.view addSubview:self.webView];

    __weak typeof(self) weakSlef = self;
    [bar mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.and.bottom.equalTo(weakSlef.view);
        make.height.mas_equalTo(44);
    }];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(weakSlef.view);
        make.top.equalTo(weakSlef.view.mas_topMargin).offset(44+20);
        make.bottom.equalTo(bar.mas_top);
    }];

}

-(UIToolbar *)createWebControlBar{
    UIToolbar *bar = [UIToolbar new];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn addTarget:self action:@selector(webBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    backBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];

    UIButton *forwordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forwordBtn addTarget:self action:@selector(webReflesh:) forControlEvents:UIControlEventTouchUpInside];
    [forwordBtn setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    forwordBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    forwordBtn.frame = CGRectMake(0, 0, 27, 27);
    UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc]initWithCustomView:forwordBtn];

    UIButton *refleshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [refleshBtn addTarget:self action:@selector(webReflesh:) forControlEvents:UIControlEventTouchUpInside];
    [refleshBtn setImage:[UIImage imageNamed:@"reflesh"] forState:UIControlStateNormal];
    refleshBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    refleshBtn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *refleshItem = [[UIBarButtonItem alloc]initWithCustomView:refleshBtn];

    UIBarButtonItem *flexButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];


    bar.items = @[backItem,forwardItem,refleshItem,flexButtonItem];

    backItem.enabled = NO;
    forwardItem.enabled = NO;
    self.forwarkBtnItem = forwardItem;
    self.goBackBtnItem = backItem;
    return bar;
}

-(IBAction)webBack:(id)sender{
    [self.webView goBack];

}

-(IBAction)webForword:(id)sender{
    [self.webView goForward];

}

- (IBAction)webReflesh:(id)sender{
    [self.webView reload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)setModel:(HomeModel *)model{
    _model = model;

    if (self.isViewLoaded && _model && _model.newsLink) {
        [self requestArticeBy:model.newsLink];

    }
}

-(void)requestArticeBy:(NSURL*) url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];

}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.scalesPageToFit = YES;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;

    }
    return _webView;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.forwarkBtnItem.enabled = NO;
    self.goBackBtnItem.enabled = webView.canGoBack;

}

@end
