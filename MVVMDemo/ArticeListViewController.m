//
//  MainMenuViewController.m
//  MVVMDemo
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 201u6年  Leonard. All rights reserved.
//

#import "ArticeListViewController.h"
#import "HomeTableViewCell.h"
#import "HomeVIewModel.h"
#import "ArticeViewController.h"
#import "Define.h"

#import <MJRefresh.h>


@interface ArticeListViewController ()
@property(nonatomic,nonnull,strong) HomeVIewModel *viewModel;
@property(nonnull,nonatomic,strong) NSArray <HomeModel*> *homeModels;
@end

static NSString *cellId = @"home table cell";
@implementation ArticeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.clearsSelectionOnViewWillAppear = YES;
    [self configTableview];
    [self dataAccess];
    [self addRefreshHeaderAndFooter];


}

-(void)configTableview{
    /// 注册cell
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:cellId];
    /// 设置cell高度根据cell内容自动调整。
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    /// 设置背景色
    self.tableView.backgroundColor = kAppMainBgColor;

    // 为添加
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];




}

-(void)addRefreshHeaderAndFooter{
    __weak typeof(self) weakSlef = self;

    // 设置上啦刷新样式
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSlef.viewModel handleDataRestart:YES success:^(NSArray<HomeModel *> * _Nonnull homeModels) {
            weakSlef.homeModels = homeModels;

            [weakSlef.tableView.mj_header endRefreshing];
            [weakSlef.tableView reloadData];

        } failure:^(NSError * _Nonnull error) {

            [weakSlef.tableView.mj_header endRefreshing];
            NSLog(@"%@", [error localizedDescription]);
        }];
    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    header.automaticallyChangeAlpha  = YES;

    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉或按下刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"刷新中 ...." forState:MJRefreshStateRefreshing];

    self.tableView.mj_header = header;

    // 设置上啦刷新样式
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSlef.viewModel handleDataRestart:NO success:^(NSArray<HomeModel *> * _Nonnull homeModels) {
            weakSlef.homeModels = homeModels;


            [weakSlef.tableView.mj_footer endRefreshing];
            [weakSlef.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {

            [weakSlef.tableView.mj_footer endRefreshing];
            NSLog(@"%@", [error localizedDescription]);
        }];

    }];

    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];

    self.tableView.mj_footer = footer;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object==self.tableView && [keyPath isEqualToString:@"contentSize"]) {


    }
}

-(void)dataAccess{
    self.viewModel = [HomeVIewModel new];
    [self.viewModel handleDataRestart:YES success:^(NSArray<HomeModel *> * _Nonnull homeModels) {

        self.homeModels = homeModels;
        [self.tableView reloadData];

    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeModels.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

    [cell setModel:self.homeModels[indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticeViewController *vc = [ArticeViewController articeViewControllerByModel:self.homeModels[indexPath.row]];

    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
