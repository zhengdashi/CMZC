//
//  CMAnalystViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnalystViewController.h"
#import "CMAnalystTableViewCell.h"
#import "CMAnalystDetailsViewController.h"


@interface CMAnalystViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
}
@property (strong, nonatomic) NSMutableArray *analystListArr;

@property (weak, nonatomic) IBOutlet UITableView *curTableView;


@end

@implementation CMAnalystViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分析师";
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addRequestDataMeans];
    
}



#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    _curTableView.hidden = YES;
    [self showDefaultProgressHUD];
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = _analystListArr.count /10+1;
        [self requestListWithPageNo:page];
    }];
}

//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
   // [self showDefaultProgressHUD];
    [CMRequestAPI cm_homePageFetchAnalystPage:page success:^(NSArray *analystArr,BOOL isPage) {
        [_curTableView endRefresh];//结束刷新
        [self hiddenProgressHUD];
        _curTableView.hidden = NO;
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.analystListArr removeAllObjects];
        }
        [self.analystListArr addObjectsFromArray:analystArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _analystListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMAnalystTableViewCell *analystCell = [tableView dequeueReusableCellWithIdentifier:@"CMAnalystTableViewCell" forIndexPath:indexPath];
    analystCell.analyst = _analystListArr[indexPath.row];
    return analystCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMAnalystMode *analyst = _analystListArr[indexPath.row];
    CMAnalystDetailsViewController  *analystVC = (CMAnalystDetailsViewController *)[CMAnalystDetailsViewController initByStoryboard];
    analystVC.analyst = analyst;
    [self.navigationController pushViewController:analystVC animated:YES];
}


#pragma mark - str get
//初始化分析师列表
- (NSMutableArray *)analystListArr {
    if (!_analystListArr) {
        _analystListArr = [NSMutableArray array];
    }
    return _analystListArr;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [_curTableView indexPathForCell:(CMAnalystTableViewCell *)sender];
    //得到数据。
    CMAnalystMode *analyst = _analystListArr[indexPath.row];
    CMAnalystDetailsViewController  *analystVC = [segue destinationViewController];
    //传数据局
    analystVC.analyst = analyst;
}
*/

@end















