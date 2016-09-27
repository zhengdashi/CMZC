//
//  CMJackpotViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMJackpotViewController.h"
#import "CMJackpotTableViewCell.h"
#import "CMMixNumberViewController.h"
#import "CMWinning.h"


@interface CMJackpotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *winningListArr;

@end

@implementation CMJackpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRequestDataMeans];
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    [self showDefaultProgressHUD];
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = self.winningListArr.count / 10 +1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_tradeFetchDrawProductPage:page success:^(NSArray *dataArr,BOOL isPage) {
        [_curTableView endRefresh];
        [self hiddenProgressHUD];
        kCurTableView_foot;
        if (page == 1) {
            [self.winningListArr removeAllObjects];
        }
        if (dataArr.count == 0) {
            [_curTableView hideFooter];
            [self showHUDWithMessage:@"暂时没有中签" hiddenDelayTime:2];
        }
        
        [self.winningListArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
    
    
}



#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.winningListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMJackpotTableViewCell *jackpotCell = [tableView dequeueReusableCellWithIdentifier:@"CMJackpotTableViewCell" forIndexPath:indexPath];
    jackpotCell.win = self.winningListArr[indexPath.row];
    jackpotCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return jackpotCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMMixNumberViewController *mixNumberVC = (CMMixNumberViewController *)[CMMixNumberViewController initByStoryboard];
    CMWinning *winning = self.winningListArr[indexPath.row];
    mixNumberVC.win = winning;
    
    [self.navigationController pushViewController:mixNumberVC animated:YES];
}

#pragma mark - setget
- (NSMutableArray *)winningListArr {
    if (!_winningListArr) {
        _winningListArr = [NSMutableArray array];
    }
    return _winningListArr;
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}
*/

@end






























