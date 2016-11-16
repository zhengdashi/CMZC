//
//  CMHomeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHomeViewController.h"
#import "CMEditionTableViewCell.h"
#import "CMBannerHeaderView.h"
#import "CMOptionTableViewCell.h"
#import "CMNewQualityTableViewCell.h"
#import "CMLatestTableViewCell.h"
#import "CMHomeTableFootView.h"
#import "CMOptionalViewController.h"
#import "CMProductDetailsViewController.h"
#import "CMAllServeViewController.h"
#import "CMAnalystViewController.h"
#import "CMBulletinViewController.h"
#import "CMMoneyViewController.h"
#import "CMTabBarViewController.h"
#import "CMCommWebViewController.h"
#import "CMCommentTableViewCell.h"
#import "CMWebSocket.h"
#import "CMRegisterViewController.h"


#import "CMMediaNews.h"
#import "CMNoticeModel.h"

@interface CMHomeViewController ()<UITableViewDelegate,UITableViewDataSource,CMEditionTableViewCellDelegate,CMOptionTableViewCellDelegate,CMNewQualityCellDelegate,CMWebSocketDelegate,CMAllServerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *curTableView;//表

@property (strong, nonatomic) CMBannerHeaderView *headerView;//表头

@property (strong, nonatomic) CMHomeTableFootView *footerView;//表尾

@property (strong, nonatomic) NSMutableArray *trendsArr; //请求动态

@property (nonatomic,strong) NSMutableArray *proictArr; //三个动态

@property (strong, nonatomic) NSMutableArray *manyFulfilArr; //众筹宝

@property (strong, nonatomic) CMWebSocket *webSocket; //webSocket


@end

@implementation CMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelef = self;
    //效果需要，等有接口和数据之后，放到请求数据结束后显示
    _headerView = [[CMBannerHeaderView alloc] init];
    _headerView.didSelectedBlack = ^(NSString *link) {
        [weakSelef cm_commWebViewURL:link];
    };
    _curTableView.tableHeaderView = _headerView;
    
    _footerView = [CMHomeTableFootView initByNibForClassName];
    _curTableView.tableFooterView = _footerView;
    //请求轮播图数据
    [self requestTitleBannesData];
    
    //请求数据
    //[self addRequestDataMeans];
    //众筹宝
    [self requestProductFundlist];
    
    //[self requestPrictThree];
    //广告
   [self requestTrends];
    
    //监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful) name:@"loginWin" object:nil];
    //监听退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessful) name:@"exitLogin" object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开启定时器
    [_headerView restartScrollBanner];
    //开启websocket
    [self initWebSocket];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭定时器
    [_headerView stopScrollBanner];
    //关闭websocket
    [_webSocket close];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
}

#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    
}




- (void)requestTrends {
    
//    [CMRequestAPI cm_trendsFetchMediaCoverDataPage:1 pageSize:4 success:^(NSArray *dataArr, BOOL isPage) {
//        
//    } fail:^(NSError *error) {
//        
//    }];
    
    [CMRequestAPI cm_trendsFetchNoticeDataPage:1 success:^(NSArray *dataArr, BOOL isPage) {
        [self.trendsArr removeAllObjects];
        [self.trendsArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
         MyLog(@"最新动态请求失败");
    }];
}

- (void)requestProductFundlist {
    
    [CMRequestAPI cm_homeFetchProductFundlistPageSize:3 success:^(NSArray *fundlistArr) {
        [self.manyFulfilArr removeAllObjects];
        [self.manyFulfilArr addObjectsFromArray:fundlistArr];
        [_curTableView beginUpdates];
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
        [_curTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView endUpdates];
    } fail:^(NSError *error) {
        MyLog(@"众筹产品请求失败");
    }];
}


//请求轮播图
- (void)requestTitleBannesData {
    [CMRequestAPI cm_homeFetchBannersSuccess:^(NSArray *bannersArr) {
        _headerView.banners = bannersArr;
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"轮播图请求失败");
    }];
}
//产品三个
- (void)requestPrictThree {
    
    [CMRequestAPI cm_homeFetchProductThreePageSize:3 success:^(NSArray *threeArr) {
        [self.proictArr removeAllObjects];
        [self.proictArr addObjectsFromArray:threeArr];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [_curTableView beginUpdates];
        [_curTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView endUpdates];
        
    } fail:^(NSError *error) {
        MyLog(@"请求三个产品失败");
    }];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.proictArr.count == 0 || self.proictArr.count == 1) {
            return 0;
        } else {
            return 111;
        }
    } else if (indexPath.row == 1) {
        return 208;
    } else if (indexPath.row == 2) {
        return 231;
    } else if (indexPath.row == 3) {
        return 181;
    } else {
        return 36;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.proictArr.count == 0 || self.proictArr.count == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            return cell;
        } else {
            //产品
            CMEditionTableViewCell *editionCell = [tableView dequeueReusableCellWithIdentifier:@"CMEditionTableViewCell" forIndexPath:indexPath];
            editionCell.prictArr = self.proictArr;
            editionCell.delegate = self;
            return editionCell;
        }
    } else if (indexPath.row == 1) {
        //四个选项
        CMOptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"CMOptionTableViewCell" forIndexPath:indexPath];
        optionCell.delegate = self;
        return optionCell;
    } else if (indexPath.row == 2) {
        //众筹宝
        CMNewQualityTableViewCell *qualityCell = [tableView dequeueReusableCellWithIdentifier:@"CMNewQualityTableViewCell" forIndexPath:indexPath];
        if (self.manyFulfilArr.count > 0) {
            qualityCell.munyArr = self.manyFulfilArr;
        }
        qualityCell.delegate = self;
        qualityCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return qualityCell;
    } else if (indexPath.row == 3) {
        //最新动态
        CMLatestTableViewCell *latestCell = [tableView dequeueReusableCellWithIdentifier:@"CMLatestTableViewCell" forIndexPath:indexPath];
        latestCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.trendsArr.count > 0) {
            latestCell.notice = self.trendsArr[0];
        }
        return latestCell;
    } else {
        UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!tableCell) {
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (_trendsArr.count !=0) {
            CMNoticeModel *media = self.trendsArr[indexPath.row-3];
            tableCell.textLabel.text = media.title;
        }
        tableCell.textLabel.font = [UIFont systemFontOfSize:14];
        tableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        tableCell.textLabel.textColor = [UIColor cmTacitlyFontColor];
        
        return tableCell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= 3) {
        CMNoticeModel *media = self.trendsArr[indexPath.row-3];
        CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
        NSString *strUrl = CMStringWithPickFormat(kCMMZWeb_url,[NSString stringWithFormat:@"Account/MessageDetail?nid=%ld",(long)media.noticId])
        ;
        commWebVC.urlStr = strUrl;
        [self.navigationController pushViewController:commWebVC animated:YES];
    }
    
}


#pragma mark - CMEditionTableViewCellDelegate
//产品delegate CMEditionTableViewCellDelegate
- (void)cm_editionTableViewProductId:(NSString *)productId nameTitle:(NSString *)name{
    CMProductDetailsViewController *productDetailsVC = (CMProductDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMProductDetailsViewController"];
    productDetailsVC.titleName = name;
    productDetailsVC.codeName = productId;
    
    [self.navigationController pushViewController:productDetailsVC animated:YES];
}

#pragma mark - CMNewQualityCellDelegate
//众筹宝
- (void)cm_newQualityProductId:(NSInteger)productid {
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    NSString *webUrl = CMStringWithPickFormat(kCMMZWeb_url, [NSString stringWithFormat:@"Products/Detail?pid=%ld",(long)productid]);
    webVC.urlStr = webUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - CMOptionTableViewCellDelegate 
//四个选项
- (void)cm_optionTableViewCellButTag:(NSInteger)btTag {
    
    switch (btTag) {
        case 0://登录或者注册
            [self cm_homeLoginOrAccountMethods];
            break;
        case 1://自选
            [self cm_homeOptionalMethods];
            break;
        case 2://分析师
            [self cm_homeOptionAnalyst];
            break;
        case 3://动态
            [self cm_homeOptionBulletin];
            break;
        case 4://众筹宝
        {
//            if (!CMIsLogin()) {
//                //位登录。显示登录
//                UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//                [self presentViewController:nav animated:YES completion:nil];
//            } else {
                [self cm_commWebViewURL:CMStringWithPickFormat(kCMMZWeb_url, @"Products/FundList")];
           // }
        }
            break;
        default://更多
            [self cm_homeOptionMore];
            break;
    }
}
//注册或者我的账户按钮
- (void)cm_homeLoginOrAccountMethods {
//    UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
//    [self presentViewController:nav animated:YES completion:nil];
    
    if (CMIsLogin()) {
        //已登录显示账户
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
        tab.selectedIndex = 3;
        
    } else {
        //位登录。显示登录
        //位登录。显示登录
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentTabBarIndex) name:@"loginWin" object:nil];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
}
- (void) presentTabBarIndex {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 3;
}

//自选的跳转
- (void)cm_homeOptionalMethods {
    if (CMIsLogin()) {
        CMOptionalViewController *optionalVC = (CMOptionalViewController *)[CMOptionalViewController initByStoryboard];
        //optionalVC.name = @"财猫";
        [self.navigationController pushViewController:optionalVC animated:YES];

    } else {
        //位登录。显示登录
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
}
//更多
- (void)cm_homeOptionMore {
    CMAllServeViewController *optionalVC = (CMAllServeViewController *)[CMAllServeViewController initByStoryboard];
    optionalVC.delegate = self;
    [self.navigationController pushViewController:optionalVC animated:YES];
}
//分析师
- (void)cm_homeOptionAnalyst {
    CMAnalystViewController *analystVC = (CMAnalystViewController *)[CMAnalystViewController initByStoryboard];
    [self.navigationController pushViewController:analystVC animated:YES];
}
//动态 公告
- (void)cm_homeOptionBulletin {
    CMBulletinViewController *bulletin = (CMBulletinViewController *)[CMBulletinViewController initByStoryboard];
    [self.navigationController pushViewController:bulletin animated:YES];
}
//跳转到web站 
- (void)cm_commWebViewURL:(NSString *)url {
    if ([url isEqualToString:CMStringWithPickFormat(kCMMZWeb_url, @"/About/Description")]) {
        CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
        newGuideVC.titName = @"新经板实力";//strength_serve_home
        [newGuideVC cm_moneyViewTitleName:@"新经板实力"
                          bgImageViewName:@"strength_serve_home"
                              imageHeight:1400.0f - 400];
        [self.navigationController pushViewController:newGuideVC animated:YES];
    } else {
        CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
        NSString *webUrl =url;
        webVC.urlStr = webUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)cm_allServerViewControllerPopHomeVCType:(CMAllServerViewType)type {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 1;
}
#pragma mark - btnClick
//更多动态
- (IBAction)moreBtnClick:(id)sender {
    [self cm_homeOptionBulletin];
}
#pragma mark - 登陆成功后的通知
- (void)loginSuccessful {
    NSIndexPath *tmpIndexpath=[NSIndexPath indexPathForRow:1 inSection:0];
    [_curTableView beginUpdates];
    [_curTableView reloadRowsAtIndexPaths:@[tmpIndexpath] withRowAnimation:UITableViewRowAnimationNone];
    [_curTableView endUpdates];
}

#pragma mark - set get
- (NSMutableArray *)trendsArr {
    if (!_trendsArr) {
        _trendsArr = [NSMutableArray array];
    }
    return _trendsArr;
}
//三个
- (NSMutableArray *)proictArr {
    if (!_proictArr) {
        _proictArr = [NSMutableArray array];
    }
    return _proictArr;
}
//众筹宝
- (NSMutableArray *)manyFulfilArr {
    if (!_manyFulfilArr) {
        _manyFulfilArr = [NSMutableArray array];
    }
    return _manyFulfilArr;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"loginWin"];
}

#pragma mark - cmwebSocket
//后边也有页面用到。不想改了。以前粘贴复制。这个方法可以代替。
- (void)initWebSocket {
    if (!CMIsLogin()) {
        _webSocket = [[CMWebSocket alloc] initRequestUrl:CMStringWithPickFormat(kWebSocket_url, @"market/index")];
        _webSocket.delegate = self;
    } else {
        
        _webSocket = [[CMWebSocket alloc] initRequestUrl:CMStringWithPickFormat(kWebSocket_url, [NSString stringWithFormat:@"market/index?m=%@",[CMAccountTool sharedCMAccountTool].currentAccount.userName])];
        _webSocket.delegate = self;
    }
    
}
- (void)cm_webScketMessage:(NSString *)message {
    [self.proictArr removeAllObjects];
    NSString *contStr = [message substringWithRange:NSMakeRange(2, message.length - 2)];
    NSArray *marketArr = [contStr componentsSeparatedByString:@";"];
    for (NSString *dataStr in marketArr) {
        NSArray *marketIndexArr = [dataStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        [self.proictArr addObject:marketIndexArr];
    }
    [_curTableView beginUpdates];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [_curTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    [_curTableView endUpdates];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

*/
@end















