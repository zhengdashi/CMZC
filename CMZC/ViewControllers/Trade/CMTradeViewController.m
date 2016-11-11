//
//  CMTradeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeViewController.h"
#import "CMTradeMeansTableViewCell.h"
#import "CMTradeTitleView.h"
#import "CMFunctionTableViewCell.h"
#import "CMTradeSonInterfaceController.h"
#import "CMOptionalViewController.h"
#import "CMCarryNowViewController.h"
#import "CMInstallViewController.h"
#import "CMStatementViewController.h"
#import "CMMyBankCardViewController.h"
#import "CMLoginViewController.h"
#import "CMAccountinfo.h"
#import "CMCommWebViewController.h"
#import "CMTabBarViewController.h"
#import "CMCarryDetailsViewController.h"

@interface CMTradeViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CMTradeMeansTableViewCellDelegate,CMTradeTitleViewDelegate>{
    NSArray *_titImageArr;//头图片Image
    NSArray *_titLabNameArr;//名字lab
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) CMTradeTitleView *tradeTitleView;
@property (strong, nonatomic) CMAccountinfo *tinfo;
@property (weak, nonatomic) IBOutlet UIImageView *tradeImage;


@end

@implementation CMTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tradeTitleView = [CMTradeTitleView initByNibForClassName];
    _tradeTitleView.delegate = self;
    _curTableView.tableHeaderView = _tradeTitleView;
    
    _titLabNameArr = @[@"银行卡认证",@"我的消息",@"新手交易指南",@"设置"];
    _titImageArr = @[@"bankCard_trade",@"message_trade",@"new_trade",@"set_trade"];
    //判断一下是否登录
    //if (CMIsLogin()) {
        [self addRequestDataMeans];
    //}
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:@"loginWin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchase) name:@"productPurchase" object:nil];
}
- (void)loginSuccessed {
    [_curTableView beginHeaderRefreshing];
}
- (void)productPurchase {
    //已登录显示账户
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 1;
    
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    [self showDefaultProgressHUD];
    //显示菊花
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    if (CMIsLogin()) {
        _tradeTitleView.loginView.hidden = NO;
    }
    //判断token
    [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
        [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
            [self hiddenProgressHUD];
            [_curTableView endRefresh];
            _tradeTitleView.tinfo = account;
            _tinfo = account;
        } fail:^(NSError *error) {
            [_curTableView endRefresh];
            [self hiddenProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];
        //[self showHUDWithMessage:@"请登录账户" hiddenDelayTime:2];
    }];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 190;
    } else {
        return 40;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CMTradeMeansTableViewCell *tradeMeansCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeMeansTableViewCell" forIndexPath:indexPath];
        
        tradeMeansCell.delegate = self;
        
        return tradeMeansCell;
    } else {
        CMFunctionTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"CMFunctionTableViewCell" forIndexPath:indexPath];
        [tableCell cm_functionTileLabNameStr:_titLabNameArr[indexPath.row-1]
                              titleImageName:_titImageArr[indexPath.row - 1]];
        
        if (indexPath.row == 3) {
            tableCell.tradeImage.hidden = NO;
        } else {
            tableCell.tradeImage.hidden = YES;
        }
        
        tableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return tableCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *commonalityVC ;
    if (!CMIsLogin()) {
        //没有登录过。跳转到登录界面
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else {
        switch (indexPath.row) {
            case 1://银行卡认证
                //这里需要坐下判断，是否登录过，是否是认证过的。如果是，跳转到详情，如果不是，就不跳转
            {
//                if (_tinfo.bankcardisexists) {
//                    //判断是否绑定过银行卡
//                    CMMyBankCardViewController *bankCardVC = (CMMyBankCardViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMyBankCardViewController"];
//                    commonalityVC = bankCardVC;
//                } else {
                    //没有绑定过银行卡。现在还没有m站地址
                    [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"/Account/BankCardCertification")];
//                }
            }
                break;
            case 2://我的消息
                [self performSegueWithIdentifier:idMessageViewController sender:self];
                break;
            case 3://新手交易指南
            {
                CMStatementViewController *statementVC = (CMStatementViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMStatementViewController"];
                statementVC.baserType = CMBaseViewDistinctionTypeDetails;
                statementVC.title = @"新手交易指南";
                commonalityVC = statementVC;
            }
                
                break;
            case 4://设置
            {
                //设置
                CMInstallViewController *installVC = (CMInstallViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMInstallViewController"];
                commonalityVC = installVC;
            }
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:commonalityVC animated:YES];
    }
}

#pragma mark - CMTradeTitleViewDelegate
- (void)cm_tradeViewControllerType:(CMTradeTitleViewType)type {
    if (!CMIsLogin()) {
        //没有登录过。跳转到登录界面
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else {
        switch (type) {
            case CMTradeTitleViewTypeCertification: //认证过
            {
                CMCarryDetailsViewController *carryNowVC = (CMCarryDetailsViewController *)[[UIStoryboard mainStoryboard]viewControllerWithId:@"CMCarryDetailsViewController"];
                carryNowVC.nameStr = _tinfo.realname;
                [self.navigationController pushViewController:carryNowVC animated:YES];
            }
                break;
            case CMTradeTitleViewTypeNotCertification:  //没有认证过
            {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"请先认证银行卡" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                aler.tag = 2008;
                [aler show];
                
            }
                break;
            default:
                break;
        }
    }
}
- (void)cm_tradeViewControllerLogin:(CMTradeTitleView *)titleView {
    CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
    [self presentViewController:loginVC animated:YES completion:nil];
    
}
//充值
- (void)cm_tradeViewControllerRecharge:(CMTradeTitleView *)titleView {
    [self pushCommWebViewVCUrlStr: CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Account/Recharge"])];
}
- (void)pushCommWebViewVCUrlStr:(NSString *)url {
    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    commWebVC.urlStr = url;
    [self.navigationController pushViewController:commWebVC animated:YES];
}

#pragma mark - CMTradeMeansTableViewCellDelegate
- (void)cm_tradeMeadsTableViewIndex:(NSInteger)index {
    //跳转到界面
    if (index == 100) {
        CMLoginViewController *loginVC = (CMLoginViewController *)[UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }
    
    
    if (index<5) {
        CMTradeSonInterfaceController *tradeSonVC = (CMTradeSonInterfaceController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTradeSonInterfaceController"];
        tradeSonVC.itemIndex = index;
        tradeSonVC.tinfo = _tinfo;
        [self.navigationController pushViewController:tradeSonVC animated:YES];
    } else {
         NSLog(@"----%ld",(long)index);
        //自选界面
        CMOptionalViewController *optionalVC = (CMOptionalViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMOptionalViewController"];
        //需要传入数据
        
        [self.navigationController pushViewController:optionalVC animated:YES];
    }
    
    
}

#pragma mark - btn 
//退出账号
- (IBAction)quitBtnClick:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"你确定退出账号？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    aler.tag = 2009;
    [aler show];
    
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 2008) {
        if (buttonIndex == 1) {
            [self pushCommWebViewVCUrlStr:CMStringWithPickFormat(kCMMZWeb_url, @"Account/BankCardCertification")];
        }
    } else if (alertView.tag == 2009) {
        if (buttonIndex == 1) {
            [[CMAccountTool sharedCMAccountTool] removeAccount];
            //删除
            DeleteDataFromNSUserDefaults(@"name");
            DeleteDataFromNSUserDefaults(@"value");
            _tradeTitleView.tinfo = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exitLogin" object:nil];
            UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
            CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
            tab.selectedIndex = 0;
        }
    }
    
    
}


#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginWin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"exitLogin"];
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

@end
