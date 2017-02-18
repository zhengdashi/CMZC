//
//  CMSubscribeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeViewController.h"
#import "CMSubscribeTitleView.h"
#import "CMMoneyViewController.h"
#import "CMSubscribeTableViewCell.h"
#import "CMPurchaseProduct.h"
#import "CMCommWebViewController.h"
#import "CMSubscribeHeaderView.h"
#import "CMSubscribeDetailsViewController.h"


@interface CMSubscribeViewController ()<UITableViewDelegate,UITableViewDataSource,CMSubscribeTableViewCellDelegate>

@property (strong, nonatomic) CMSubscribeTitleView *subscribeView;//头view

@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (nonatomic,copy) CMPurchaseProduct *purchase;

@property (strong, nonatomic) NSMutableArray *productDataArr;

@end

@implementation CMSubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化tab的title
    [self initTableViewTitleHeaderView];
    
    [self addRequestDataMeans];
    
    
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    _curTableView.hidden = YES;
    [self showDefaultProgressHUD];
    //显示菊花
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = _productDataArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    [CMRequestAPI cm_applyFetchProductListOnPageIndex:page pageSize:10 success:^(NSArray *productArr, BOOL isPage) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];//结束刷新
        _curTableView.hidden = NO;
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.productDataArr removeAllObjects];
        }
        [self.productDataArr addObjectsFromArray:productArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 375;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CMSubscribeTableViewCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"CMSubscribeTableViewCell" forIndexPath:indexPath];
    
    CMSubscribeTableViewCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"CMSubscribeTableViewCell"];
    
    if (!subscribeCell) {
        subscribeCell = [[NSBundle mainBundle] loadNibNamed:@"CMSubscribeTableViewCell" owner:nil options:nil].firstObject;
    }
    subscribeCell.delegate = self;
    subscribeCell.product = _productDataArr[indexPath.row];
    subscribeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return subscribeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //http://192.168.1.225:8084/Products/Detail?pid=43011
   CMPurchaseProduct *product = _productDataArr[indexPath.row];
    
//    if (product.isNextPage) {
//        if (!CMIsLogin()) {
//            //位登录。显示登录
//            UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//            [self presentViewController:nav animated:YES completion:nil];
//        } else {
    
            CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
            webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url,CMStringWithPickFormat(@"/Products/Detail?pid=",CMStringWithFormat(product.productId)));
    //[NSString stringWithFormat:@"%@%ld",@"http://mz.58cm.com/Products/Detail?pid=",(long)product.productId];
            [self.navigationController pushViewController:webVC animated:YES];
//        }
//    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CMSubscribeHeaderView *headerView = [CMSubscribeHeaderView initByNibForClassName];
    return headerView;
}

#pragma mark - CMSubscribeTableViewCellDelegate
- (void)cm_checkRoadshowLiveUrl:(NSString *)liveUrl {
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = liveUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - strGet
//初始化tab的头
- (void)initTableViewTitleHeaderView {
    _subscribeView = [CMSubscribeTitleView initByNibForClassName];
    
    __weak typeof(self) weakSelef = self;
    _subscribeView.titleBlock = ^(NSInteger index) {
        if (index == 1000) {
            //新手指引
            CMMoneyViewController *moneyVC = (CMMoneyViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMoneyViewController"];
            [moneyVC cm_moneyViewTitleName:@"新手指引"
                              bgImageViewName:@"new_shou_yindao"
                                  imageHeight:1980.0f - 400];
            [weakSelef.navigationController pushViewController:moneyVC animated:YES];
        } else if(index == 1001) {
            //新手指引
            CMMoneyViewController *moneyVC = (CMMoneyViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMoneyViewController"];
            [moneyVC cm_moneyViewTitleName:@"赚钱秘籍"
                              bgImageViewName:@"make_money_serve"
                                  imageHeight:850.0f - 400];
            [weakSelef.navigationController pushViewController:moneyVC animated:YES];
        } else {
            CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
            newGuideVC.titName = @"新经板实力";//strength_serve_home
            [newGuideVC cm_moneyViewTitleName:@"新经板实力"
                              bgImageViewName:@"strength_serve_home"
                                  imageHeight:1400.0f - 400];
            [weakSelef.navigationController pushViewController:newGuideVC animated:YES];
        }
        
    };
    _curTableView.tableHeaderView = _subscribeView;
}

- (NSMutableArray *)productDataArr {
    if (!_productDataArr) {
        _productDataArr = [NSMutableArray array];
    }
    return _productDataArr;
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
    NSIndexPath *indexPath = [_curTableView indexPathForCell:(CMSubscribeTableViewCell *)sender];
    CMPurchaseProduct *product = _productDataArr[indexPath.row];
    CMSubscribeDetailsViewController *subscribeVC = [segue destinationViewController];
    subscribeVC.productId = product.productId;
}
*/

@end






















