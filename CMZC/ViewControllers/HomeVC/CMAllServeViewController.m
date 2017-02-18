//
//  CMAllServeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAllServeViewController.h"
#import "CMServerCollectionViewCell.h"
#import "CMServeReusableView.h"
#import "CMClientServeViewController.h"
#import "CMFeedbackViewController.h"
#import "CMInstallViewController.h"
#import "CMHelpCoreViewController.h"
#import "CMMoneyViewController.h"//新手指引
#import "CMTradeSonInterfaceController.h" //买入


#import "CMOptionalViewController.h"//自选
#import "CMBulletinViewController.h"//公告
#import "CMAnalystViewController.h"//分析师

#import "CMTabBarViewController.h"
#import "CMSortwareShareViewController.h" //分享
#import "CMRegisterViewController.h"
#import "CMServerPromptView.h" //提示框
#import "CMServiceApplicationViewController.h" //服务申请
#import "CMCommWebViewController.h"



@interface CMAllServeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *allServeCollectionView;


@end

@implementation CMAllServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化view
    [self initializationLayoutUI];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.allType == CMAllServerViewTypeMarket || self.allType == CMAllServerViewTypeSubscribe || self.allType == CMAllServerViewTypeAccount) {
        NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in vcs) {
            if ([vc isKindOfClass:[self class]]) {
                [vcs removeObject:vc];
                break;
            }
        }
        self.navigationController.viewControllers = vcs;
    }
    
}


#pragma mark - 初始化布局

- (void)initializationLayoutUI {
    // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake(self.view.width/3,100);
    layout.headerReferenceSize = CGSizeMake(0, 40);
    // 3.设置整个collectionView的内边距
    //    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    // 4.设置每一行之间的间距
    layout.minimumLineSpacing = 0.5;
    // 设置cell之间的间距
    layout.minimumInteritemSpacing = 0;
    
    _allServeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
   // iPhone5
    if (iOS7) {
        _allServeCollectionView.frame = CGRectMake(0, 67, CMScreen_width(), CMScreen_height()-66);
    } else {
        _allServeCollectionView.frame = self.view.frame;
    }
    
    
    _allServeCollectionView.backgroundColor = [UIColor cmBackgroundGrey];
    // 设置头部并给定大小
    [layout setHeaderReferenceSize:CGSizeMake(self.view.width, 40)];
    
    _allServeCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _allServeCollectionView.dataSource = self;
    _allServeCollectionView.delegate = self;
    
    // 注册UICollectionViewCell
    [_allServeCollectionView registerNib:[UINib nibWithNibName:@"CMServerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CMServerCollectionViewCell"];
    
    // 注册头部视图
    [_allServeCollectionView registerClass:[CMServeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMServeReusableView"];
    [self.view addSubview:_allServeCollectionView];
    
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self headerTitArr].count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self sourceDataArr][section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMServerCollectionViewCell *serverCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMServerCollectionViewCell" forIndexPath:indexPath];
    serverCell.titleImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self sourceDataArr][indexPath.section][indexPath.row]]];
    return serverCell;
}

// 设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        // 定制头部视图的内容
        CMServeReusableView *serveView = (CMServeReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMServeReusableView" forIndexPath:indexPath];
        reusableView = serveView;
        serveView.titleLab.text = [self headerTitArr][indexPath.section];
    }
    return reusableView;
}

//点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self brandIntroduceIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        [self tradeServeIndexPath:indexPath];
    } else if (indexPath.section == 2) {
        [self financingServeIndexPath:indexPath];
    } else {
        [self moreSeveIndexPath:indexPath];
    }
    
}

//品牌介绍
- (void)brandIntroduceIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    
    switch (indexPath.row) {
        case 0:
        {//财猫实力
            CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
            newGuideVC.titName = @"新经板实力";//strength_serve_home
            viewController = newGuideVC;
            [newGuideVC cm_moneyViewTitleName:@"新经板实力"
                              bgImageViewName:@"strength_serve_home"
                                  imageHeight:1400.0f - 400];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
        {//安全保障
            CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
            viewController = newGuideVC;
            [newGuideVC cm_moneyViewTitleName:@"安全保障"
                              bgImageViewName:@"insurance_serve_home"
                                  imageHeight:2900.0f - 400];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:
        {
            CMBulletinViewController *bulletinVC = (CMBulletinViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMBulletinViewController"];
            
            viewController = bulletinVC;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            
            break;
//        case 3://赚钱秘籍
//        {
//            CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
//            [newGuideVC cm_moneyViewTitleName:@"赚钱秘籍"
//                              bgImageViewName:@"make_money_serve"
//                                  imageHeight:750-400];
//            viewController = newGuideVC;
//            [self.navigationController pushViewController:viewController animated:YES];
//        }
//            break;
        default:
            break;
    }
    
}
//融资服务
- (void)financingServeIndexPath:(NSIndexPath *)indexPath {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMServerPromptView *serverView = [[NSBundle mainBundle] loadNibNamed:@"CMServerPromptView" owner:nil options:nil].firstObject;
    serverView.center = window.center;
    serverView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    switch (indexPath.row) {
        case 0:
            serverView.imageNameStr = @"prompt_serve_listed";
            [window addSubview:serverView];
            break;
        case 1:
            serverView.imageNameStr = @"prompt_serve_ziben";
            [window addSubview:serverView];
            break;
        case 2:
            serverView.imageNameStr = @"prompt_serve_xinjingji";
            [window addSubview:serverView];
            break;
        case 3:
            serverView.imageNameStr = @"prompt_serve_luyan";
            [window addSubview:serverView];
            break;
        case 4:
        {
            CMServiceApplicationViewController *serviceVC = (CMServiceApplicationViewController *)[CMServiceApplicationViewController initByStoryboard];
            [self.navigationController pushViewController:serviceVC animated:YES];
        }
            break;
        case 5:
        {
            return;
        }
            break;
            
        default:
            break;
    }
    if (indexPath.row <5) {
        __weak typeof(self) weakSelef = self;
        serverView.typeBlock = ^() {
            CMServiceApplicationViewController *serviceVC = (CMServiceApplicationViewController *)[CMServiceApplicationViewController initByStoryboard];
            [weakSelef.navigationController pushViewController:serviceVC animated:YES];
        };
    }
    
    
    
}

//交易服务
- (void)tradeServeIndexPath:(NSIndexPath *)indexPath {

    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    switch (indexPath.row) {
        case 1:
            //申购新品
        {
            self.allType = CMAllServerViewTypeSubscribe;
            CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
            tab.selectedIndex = 1;
            
        }
            break;
        case 2:
            //行情
        {
            self.allType = CMAllServerViewTypeMarket;
            CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
            tab.selectedIndex = 2;
        }
            break;
        case 3://倍利宝
        {
           
                //自选 http://m.xinjingban.com/Products/FundList
                CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
                
                webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"/Products/FundList");
                [self.navigationController pushViewController:webVC animated:YES];
            
        }
            break;
        case 5:
        {
            //公告
            CMBulletinViewController *bulletinVC = (CMBulletinViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMBulletinViewController"];
            [self.navigationController pushViewController:bulletinVC animated:YES];
        }
            break;
        case 4:
        {
         //分析师
            CMAnalystViewController *analystVC = (CMAnalystViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMAnalystViewController"];
            
            [self.navigationController pushViewController:analystVC animated:YES];
        }
            break;
        case 0:
            //开户注册 CMRegisterViewController
        {
            if (CMIsLogin()) {
                [self showHUDWithMessage:@"已登录，无需注册开户" hiddenDelayTime:2];
            } else {
                CMRegisterViewController *registerVC = (CMRegisterViewController *)[[UIStoryboard loginStoryboard] viewControllerWithId:@"CMRegisterViewController"]; //(CMRegisterViewController *)[CMRegisterViewController initByStoryboard];
                [self.navigationController pushViewController:registerVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
    
}

//更多服务
- (void)moreSeveIndexPath:(NSIndexPath *)indexPath {
    UIViewController *commonalityVC = nil;
        
    switch (indexPath.row) {
        case 0:
            //我的账户
        {
            if (!CMIsLogin()) {
                [self isLoginVC];
            } else {
                self.allType = CMAllServerViewTypeAccount;
                UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
                CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
                tab.selectedIndex = 3;
            }
            
        }
            break;
        case 1://帮助中心
        {
            //帮助中心
            CMHelpCoreViewController *helpCoreVC = [[CMHelpCoreViewController alloc] init];
            commonalityVC = helpCoreVC;
        }
            break;
        case 2://客户服务
        {
            CMClientServeViewController *lientServeVC = (CMClientServeViewController*)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMClientServeViewController"];
            commonalityVC = lientServeVC;
            /*
            //新手指引
            CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMMoneyViewController"];
            [newGuideVC cm_moneyViewTitleName:@"新手指引"
                              bgImageViewName:@"new_shou_yindao"
                                  imageHeight:2000.0f - 400];
            commonalityVC = newGuideVC;
             */
        }
            break;
        case 3://意见反馈
        {
            //意见反馈
            CMFeedbackViewController *feedbackVC = [[CMFeedbackViewController alloc] init];
            commonalityVC = feedbackVC;
        }
            break;
        case 4://客户服务
        {//客户服务
            CMClientServeViewController *lientServeVC = [[CMClientServeViewController alloc] init];
            commonalityVC = lientServeVC;
        }
            break;
        case 5:
            //分享
        {
            CMSortwareShareViewController *shareVC = (CMSortwareShareViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSortwareShareView"];
            
            commonalityVC = shareVC;
        }
            
            break;
        case 6://设置
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

#pragma mark - setGet
//头view title
- (NSArray *)headerTitArr {
    return @[@"品牌介绍",
             @"交易服务",
             @"融资服务",
             @"更多服务"];
}
//cell data
- (NSArray *)sourceDataArr {
    return @[@[@"strength_brand_home",@"safety_brand_home",@"media_brand_home"],
             @[@"ask_trade_home",@"price_trade_home",@"option_trade_home",@"notice_trade_home",@"analyst_trade_home",@"trade_trade_home"],
             @[@"finan_listed_serve",@"finan_capital_serve",@"finan_economy_serve",@"finan_roadshow_serve",@"finan_apply_serve",@""],
             @[@"couple_serve_home",@"server_serve_home",@"shear_serve_home"]];
}
- (void)isLoginVC {
    UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)popHomeViewControllerType:(CMAllServerViewType)type {
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(cm_allServerViewControllerPopHomeVCType:)]) {
        [self.delegate cm_allServerViewControllerPopHomeVCType:type];
    }
    
    
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
























