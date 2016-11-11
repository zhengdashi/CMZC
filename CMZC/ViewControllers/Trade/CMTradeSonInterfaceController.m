//
//  CMTradeSonInterfaceController.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeSonInterfaceController.h"
#import "CMBuyingCollectionViewCell.h"
#import "CMSaleCollectionViewCell.h"
#import "CMRevokeCollectionViewCell.h"//撤单
#import "CMHoldCollectionViewCell.h"//持有
#import "CMInquireCollectionViewCell.h"//查询
#import "CMTurnoverViewController.h"//成交查询
#import "CMTrustInquireViewController.h"//委托查询
#import "CMJackpotViewController.h"//中签查询
#import "CMSubscribeRecordViewController.h"//申购记录查询
#import "CMSubscribeGuideViewController.h"//申购指南
#import "CMCommWebViewController.h"
#import "CMTabBarViewController.h"
#import "CMHoldDetailsCMViewController.h"
#import "CMCarryDetailsViewController.h" //提现页面




@interface CMTradeSonInterfaceController ()<UICollectionViewDataSource,UICollectionViewDelegate,TitleViewDelegate,CMInquireCollectionViewCellDelegate,CMBuyingCellDelegate,CMSaleCollectionDelegate,CMHoldCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *curCollectionView;
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (strong, nonatomic) CMRevokeCollectionViewCell *revokeSaleCell;


@end

@implementation CMTradeSonInterfaceController
//买入
static NSString *const buyingIdentifer = @"CMBuyingCollectionViewCell";
//卖出
static NSString *const saleIdentifer = @"CMSaleCollectionViewCell";
//撤单
static NSString *const revokeIdentifer = @"CMRevokeCollectionViewCell";
//持有
static NSString *const holdIdentifer = @"CMHoldCollectionViewCell";
//查询
static NSString *const inquireIdentifer = @"CMInquireCollectionViewCell";

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"productPurchase"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"交易";
    [self configureCollectionView];
    [self loadTitleView];
    //这边因为刚进来vc的子界面布局还在继续，所以要runtime一下
    [self performSelector:@selector(performTime) withObject:self afterDelay:0.0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)performTime {
    if (_itemIndex == 2) {
        _itemIndex = _itemIndex +1;
    } else if (_itemIndex == 3) {
        _itemIndex = _itemIndex - 1;
    }
    
    self.titleView.selectBtnIndex = _itemIndex;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_itemIndex inSection:0];
    [_curCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}

#pragma mark - 注册 初始化
- (void)configureCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(CMScreen_width(), CMScreen_height() - 104)];
    [flowLayout setMinimumLineSpacing:0.0];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.curCollectionView setCollectionViewLayout:flowLayout];
    //买入
    [self.curCollectionView registerNib:[UINib nibWithNibName:@"CMBuyingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:buyingIdentifer];
    //卖出
    [self.curCollectionView registerNib:[UINib nibWithNibName:@"CMSaleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:saleIdentifer];
    //撤单
    [self.curCollectionView registerNib:[UINib nibWithNibName:@"CMRevokeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:revokeIdentifer];
    //持有
    [self.curCollectionView registerNib:[UINib nibWithNibName:@"CMHoldCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:holdIdentifer];
    //查询
    [self.curCollectionView registerNib:[UINib nibWithNibName:@"CMInquireCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:inquireIdentifer];
    
    self.curCollectionView.delegate = self;
    self.curCollectionView.dataSource = self;
    self.curCollectionView.pagingEnabled = YES;
    self.curCollectionView.scrollEnabled = NO;
    self.curCollectionView.showsHorizontalScrollIndicator = NO;
    
}

#pragma mark - UICollectionViewDataSource &&UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {//买入
            CMBuyingCollectionViewCell *buyingCell = [collectionView dequeueReusableCellWithReuseIdentifier:buyingIdentifer forIndexPath:indexPath];
            buyingCell.codeName = self.codeStr;
            buyingCell.delegate = self;
            return buyingCell;
        }
            break;
        case 1:
        {//卖出
            CMSaleCollectionViewCell *saleCell = [collectionView dequeueReusableCellWithReuseIdentifier:saleIdentifer forIndexPath:indexPath];
            saleCell.codeName = self.codeStr;
            saleCell.delegate = self;
            return saleCell;
        }
            break;
        case 2:
        {
            //撤单
            CMRevokeCollectionViewCell  *saleCell = [collectionView dequeueReusableCellWithReuseIdentifier:revokeIdentifer forIndexPath:indexPath];
            _revokeSaleCell = saleCell;
            return saleCell;
        }
            break;
        case 3:
        {
            //持有
            CMHoldCollectionViewCell *holdCell = [collectionView dequeueReusableCellWithReuseIdentifier:holdIdentifer forIndexPath:indexPath];
            holdCell.tinfo = _tinfo;
            holdCell.block = ^(){
                [self rechargeWebView];
            };
            holdCell.delegate = self;
            return holdCell;
        }
            break;
        default:
        {//查询
            CMInquireCollectionViewCell *saleCell = [collectionView dequeueReusableCellWithReuseIdentifier:inquireIdentifer forIndexPath:indexPath];
            saleCell.delegate = self;
            return saleCell;
        }
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.frame.size.width * 2)
//    {
        [self.view endEditing:YES];
//    }
}


#pragma mark - CMInquireCollectionViewCellDelegate
- (void)cm_inquireCollectionIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
                CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
                if (tab.selectedIndex == 2) {
                    tab.selectedIndex = 3;
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
                break;
            case 1:
            {//成家查询
                CMTurnoverViewController *turnoverVC = (CMTurnoverViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTurnoverViewController"];
                [self.navigationController pushViewController:turnoverVC animated:YES];
                
            }
                break;
            case 2:
            {//委托查询
                CMTrustInquireViewController *trustInquireVC = (CMTrustInquireViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTrustInquireViewController"];
                
                [self.navigationController pushViewController:trustInquireVC animated:YES];
            }
                break;
            
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController popViewControllerAnimated:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"productPurchase" object:self];
            }
                break;
            case 1:
            {//中奖查询
                CMJackpotViewController *jackpotVC = (CMJackpotViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMJackpotViewController"];
                
                [self.navigationController pushViewController:jackpotVC animated:YES];
            }
                break;
            case 2:
            {//申购记录查询
                CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
                commWebVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"Account/SubscribeList");
                [self.navigationController pushViewController:commWebVC animated:YES];
            }
                break;
            case 3:
            {//申购指南
                CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
                commWebVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"Account/FundSubscribeList");
                [self.navigationController pushViewController:commWebVC animated:YES];
            }
                break;
            case 4:
            {
                CMSubscribeGuideViewController *subscribeGuideVC = (CMSubscribeGuideViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSubscribeGuideViewController"];
                [self.navigationController pushViewController:subscribeGuideVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - CMBuyingCellDelegate
- (void)cm_buyingCollectionView:(CMBuyingCollectionViewCell *)buyingVC {
    [self skipTrustInquire];
}
- (void)cm_saleCollectionVC:(CMSaleCollectionViewCell *)saleVC {
    [self skipTrustInquire];
}
- (void)skipTrustInquire {
    CMTrustInquireViewController *trustInquireVC = (CMTrustInquireViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTrustInquireViewController"];
    
    [self.navigationController pushViewController:trustInquireVC animated:YES];
}
#pragma mark - CMHoldCollectionViewDelegate
- (void)cm_holdCollectionViewInquire:(CMHoldInquire *)inquire {
    CMHoldDetailsCMViewController *holdDetailsVC = (CMHoldDetailsCMViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMHoldDetailsCMViewController"];
    holdDetailsVC.inquire = inquire;
    [self.navigationController pushViewController:holdDetailsVC animated:YES];
}
#pragma mark - TitleView

- (void)loadTitleView {
    //买入
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"买入"];
    //卖出
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"卖出"];
    //撤单
    UIButton *sortRemoveButton = [UIButton cm_customBtnTitle:@"撤单"];
    //持有
    UIButton *sortHoldButton = [UIButton cm_customBtnTitle:@"持有"];
    //查询
    UIButton *sortQueryButton = [UIButton cm_customBtnTitle:@"查询"];
    
    
    [self.titleView addTabWithoutSeparator:sortNewButton];
    [self.titleView addTabWithoutSeparator:sortHotButton];
    [self.titleView addTabWithoutSeparator:sortRemoveButton];
    [self.titleView addTabWithoutSeparator:sortHoldButton];
    [self.titleView addTabWithoutSeparator:sortQueryButton];
    
    self.titleView.delegate = self;
    
    
}
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_curCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    if (index == 2) {
        [_revokeSaleCell cm_revokeCollectionRequest];
    }
    
}
//充值
- (void)rechargeWebView {
    CMCommWebViewController *commWebVC = (CMCommWebViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMCommWebViewController"];
    commWebVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, @"Account/Recharge");
    [self.navigationController pushViewController:commWebVC animated:YES];
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
