//
//  CMProductDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kCode 800082

#import "CMProductDetailsViewController.h"
#import "CMProductDetailsTableViewCell.h"
#import "CMChartTableViewCell.h"
#import "CMCommentTableViewCell.h"
#import "CMTradeSonInterfaceController.h"
#import "CMCommWebViewController.h"
#import "SRWebSocket.h"
#import "CMTimer.h"
#import "CMProductNotion.h"
#import "CMCommentViewController.h"
#import "CMProductComment.h"

#import "CMNewCommentTableViewCell.h"
#import "CMTitleView.h"
#import "TFHpple.h"
#import "CMAnalystPoint.h"
#import "CMWebHtmlTableViewCell.h"

#import "CMShareView.h"
#import "CMAnalystViewController.h"
#import "CMTopicList.h"
#import "CMoptionReleaseTableViewCell.h" //发布话题
#import "CMReplyTableViewCell.h" //评论
#import "CMTopicReplyViewController.h"
#import "CMTopicReplyViewController.h"


@interface CMProductDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,CMCommentTableViewCellDelegate,SRWebSocketDelegate,CMProductDetailsDelegate,CMoptionReleaseTableViewCellDelegate,CMReplyTableViewCellDelegate> {
    BOOL _isFirst;
    BOOL _isShow; //展示全部
    NSString *_htmlStr; //html数据
    BOOL _isSearchOrReply; //标记内容
    NSString *_topicId; //话题id
    
    NSString *_versionPatch; //版块儿
    NSString *_earnings; //预期收益
    NSString *_guaranteed; //保底收益
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTabeViewLayout;
@property (weak, nonatomic) IBOutlet UIView *titleBgView;
@property (weak, nonatomic) IBOutlet UIView *btomView;
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *numberLab;

@property (strong, nonatomic) NSMutableArray *productArr;

@property (strong, nonatomic) NSTimer *productTimer; //定时器

@property (strong, nonatomic) SRWebSocket *webSocket;
@property (strong, nonatomic) CMTimer *timer;
@property (weak, nonatomic) IBOutlet UIView *bgView; //背景view  用于点击使用
@property (weak, nonatomic) IBOutlet UIView *btmView; //存放输入框和确定按钮
@property (weak, nonatomic) IBOutlet UITextField *numberTextField; //输入框
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;
@property (strong, nonatomic) CMTitleView *sectionView;
@property (strong, nonatomic) CMTitleView *titleSectionView;
@property (strong, nonatomic) NSMutableArray  *anounDataArr; //品论
@property (strong, nonatomic) NSArray *commDataArr; //公告
@property (nonatomic,copy) NSString *enterPrise; //企业信息
@property (strong, nonatomic) UIButton *sectionViewSelectBtn; //选中的but
@property (strong, nonatomic) NSArray *topicListArr;
@property (strong, nonatomic) NSArray *productinfoArr; //明细arr


@end

@implementation CMProductDetailsViewController

- (void)dealloc {
    //删除所有的通知
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"closeWebSocket" object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isFirstTime" object:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showDefaultProgressHUD];
    [CMCommonTool executeRunloop:^{
        [self hiddenAllProgressHUD];
    }afterDelay:3];
    _isShow = YES;
    _isSearchOrReply = YES;
    _anounDataArr = [NSMutableArray array];
    [self.titleView addSubview:self.numberLab];
    [self.titleView addSubview:self.titleLab];
    self.navigationItem.titleView = self.titleView;
    self.titleLab.text = _titleName;
    self.numberLab.text = _codeName;
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _isFirst = NO; //这个是为了判断数据请求是否是第一次，同一个界面的数据，非得给两个不同的接口来需要。不懂~！
    [_curTableView addHeaderWithFinishBlock:^{
        [CMCommonTool executeRunloop:^{
            [_curTableView endRefresh];
        }afterDelay:2];
    }];
    
    
    
    _titleSectionView = [[NSBundle mainBundle] loadNibNamed:@"CMTitleView" owner:nil options:nil].firstObject;
    _titleSectionView.hidden = YES;
    _titleSectionView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 40);
    [self.view addSubview:_titleSectionView];
    
    [self requestProductInfo];
    
    //_codeName = @"000124";
    _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Investment.aspx?pcode=", self.codeName));
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //打开定时器
    [self requestOpenTimer];  //先注释了
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭定时器
    DeleteDataFromNSUserDefaults(@"keyIndex");
    if (_timer) {
        [_timer close];
    }
    
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
    [self requestMarketProduct];
}
//分时
- (void)requestMarketProduct {
   // [self showDefaultProgressHUD];
    
    [CMRequestAPI cm_marketTransferProductCode:_codeName success:^(NSArray *productArr) {
        
        [_curTableView endRefresh];
        self.titleLab.text = productArr[0][0];
        //[_curTableView beginUpdates];
        [self.productArr removeAllObjects];
        [self.productArr addObjectsFromArray:productArr];
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        //[_curTableView endUpdates];
        if (!_isFirst) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isFirstTime" object:self userInfo:@{@"earlyMorning":productArr[0][1]}];
            _isFirst = YES;
        }
        [self hiddenProgressHUD];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        MyLog(@"请求产品行情详情接口失败");
    }];
    
}

//评论
- (void)requestComments {
    [CMRequestAPI cm_homeFetchAnswerPointAnalystId:0 pcode:[_codeName integerValue] pageIndex:1 success:^(NSArray *pointArr, BOOL isPage) {
        [_anounDataArr addObjectsFromArray:pointArr];
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    } fail:^(NSError *error) {
        MyLog(@"行情评论信息请求是吧");
    }];
}
//公告
- (void)requestAnnouncement {
    [CMRequestAPI cm_marketFetchProductNoticePCode:_codeName pageIndex:1 success:^(NSArray *noticeArr) {
        _commDataArr = noticeArr;
         [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } fail:^(NSError *error) {
        MyLog(@"行情公告信息请求失败");
    }];
}
//企业信息
- (void)requestEnterprise {
    [CMRequestAPI cm_tradeFetchProductContextPcode:_codeName success:^(NSString *dataStr) {
        _htmlStr = dataStr;
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } fail:^(NSError *error) {
        
    }];
}
//行情吧
- (void)requestTopicData {
    
    [self requestTopicPageIndex:1];
    
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = self.topicListArr.count /10 +1;
        [self requestTopicPageIndex:page];
    }];
}
- (void)requestTopicPageIndex:(NSInteger)page {
    [CMRequestAPI cm_marketFetchTopicPcode:_codeName pageIndex:page success:^(NSArray *topicArr) {
        [self.anounDataArr removeAllObjects];
        [self.anounDataArr addObjectsFromArray:topicArr];
        [_curTableView endRefresh];
        if (topicArr.count >= 5) {
            [_curTableView resetNoMoreData];
        } else {
            [_curTableView noMoreData];
        }
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } fail:^(NSError *error) {
        //[self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}

//产品明细
- (void)requestProductInfo {
    //[self showDefaultProgressHUD];
    [CMRequestAPI cm_marketFetchProductinfoPcode:_codeName success:^(NSArray *productArr) {
       // [self hiddenProgressHUD];
        [_curTableView endUpdates];
        self.productinfoArr = productArr;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [_curTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView beginUpdates];
        if (productArr.count > 0) {
            _versionPatch = productArr[1]; //版块儿名称
            _earnings = productArr[4]; //预期收益
            _guaranteed = productArr[5]; //保底收益
        }
        
        
    } fail:^(NSError *error) {
        //[self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//设置区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    } else {
        return 0;
    }
}
//设置区的单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1){
        switch (self.type) {
            case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
                return 1;
                break;
            case CMProductSelectTypeComments: //行情吧
                return _anounDataArr.count+1;
                break;
            case CMProductSelectTypeNounce: //信息披露
                return _commDataArr.count;
                break;
            case CMProductSelectTypeEnterprise: //公司概况
                return 1;
                break;
            case CMProductSelectTypeProductAndMarket: //产品与市场
                return 1;
                break;
            case CMProductSelectTypeFinancialIndicators: //财务指标
                return 1;
                break;
            case CMProductSelectTypeTeamEquity: //团队与股权
                return 1;
                break;
            case CMProductSelectTypeDetails: //产品详情
                return 1;
                break;
            default:
                break;
        }
    } else {
        return 0;
    }
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        if (self.type == CMProductSelectTypeNounce) {
            if (_commDataArr.count == 0) {
                return 100;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_isShow) {
                return 136;
            } else {
                return 256;
            }
        } else {
            return 282;
        }
    } else {
        switch (self.type) {
            case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
                return kScreen_height - 64 - 40 - 45;
                break;
            case CMProductSelectTypeComments: //行情吧
            {
                if (indexPath.row == 0) {
                    return 100;
                } else {
                    CMTopicList *topicList = _anounDataArr[indexPath.row -1];
                    CGFloat height = 100;
                    if (topicList.repliesArr.count == 1) {
                        height = height + 80;
                    } else if (topicList.repliesArr.count == 2) {
                        height = height + 160;
                    } else {
                        height = 100;
                    }
                    return height;
                }
                
            }
                break;
            case CMProductSelectTypeNounce: //信息披露
            {
                CMProductNotion *productCom = _commDataArr[indexPath.row];
                CGFloat height = [productCom.title getHeightIncomingWidth:CMScreen_width()-30  incomingFont:14];
                return 63-14 + height+10;
            }
                break;
            case CMProductSelectTypeEnterprise: //公司概况
                return kScreen_height - 64 - 40 - 45;
                break;
            case CMProductSelectTypeProductAndMarket: //产品与市场
                return kScreen_height - 64 - 40 - 45;
                break;
            case CMProductSelectTypeFinancialIndicators: //财务指标
                return kScreen_height - 64 - 40 - 45;
                break;
            case CMProductSelectTypeTeamEquity: //团队与股权
                return 470;
                break;
            case CMProductSelectTypeDetails: //产品详情
                return kScreen_height - 64 - 40 - 45;
                break;
            default:
                break;
        }
    }
}
//设置区的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CMProductDetailsTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"CMProductDetailsTableViewCell" forIndexPath:indexPath];
            if (!productCell) {
                
            }
            productCell.selectionStyle = UITableViewCellSelectionStyleNone;
            productCell.productArr = self.productArr;
            productCell.delegate = self;
            return productCell;
        } else {
            CMChartTableViewCell *chartCell = [tableView dequeueReusableCellWithIdentifier:@"CMChartTableViewCell" forIndexPath:indexPath];
            chartCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chartCell.code = _codeName;
            chartCell.productArr = self.productinfoArr;
            return chartCell;
        }
    } else {
        switch (self.type) {
            case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
                return [self productSelectTyoeHtmlTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeComments: //行情吧
                if (indexPath.row == 0) {
                    return [self productSelectTopicTableView:tableView indexPath:indexPath];
                } else {
                    return [self productSelectTopicContentTableView:tableView indexPath:indexPath];
                }
                break;
            case CMProductSelectTypeNounce: //信息披露
                return [self productSelectTypeNounceTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeEnterprise: //公司概况
                return [self productSelectTyoeHtmlTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeProductAndMarket: //产品与市场
                return [self productSelectTyoeHtmlTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeFinancialIndicators: //财务指标
                return [self productSelectTyoeHtmlTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeTeamEquity: //团队与股权
                return [self productSelectTyoeHtmlTableView:tableView indexPath:indexPath];
                break;
            case CMProductSelectTypeDetails: //产品详情
                return nil;
                break;
            default:
                break;
        }
    }
}
//设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.sectionView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
        //footerView.backgroundColor = [UIColor redColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 50, 50);
        imageView.center = footerView.center;
        //imageView.backgroundColor = [UIColor redColor];
        imageView.image = [UIImage imageNamed:@"error_trade"];
        [footerView addSubview:imageView];
        
        UILabel *footTitleLab = [[UILabel alloc] init];
        
        footTitleLab.frame = CGRectMake(0, 0, 200, 30);
        footTitleLab.center = CGPointMake(imageView.center.x, imageView.center.y+40);
        footTitleLab.font = [UIFont systemFontOfSize:15];
        footTitleLab.textAlignment = NSTextAlignmentCenter;
        footTitleLab.textColor = [UIColor cmDividerColor];
        switch (self.type) {
            case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
                
                break;
            case CMProductSelectTypeComments: //行情吧
                footTitleLab.text = @"暂无评论！";
                break;
            case CMProductSelectTypeNounce: //信息披露
                footTitleLab.text = @"暂无信息！敬请期待";
                break;
            case CMProductSelectTypeEnterprise: //公司概况
                
                break;
            case CMProductSelectTypeProductAndMarket: //产品与市场
                
                break;
            case CMProductSelectTypeFinancialIndicators: //财务指标
                
                break;
            case CMProductSelectTypeTeamEquity: //团队与股权
                
                break;
            case CMProductSelectTypeDetails: //产品详情
                
                break;
            default:
                break;
        }
        [footerView addSubview:footTitleLab];
        return footerView;
    } else {
        return nil;
    }
}


//区头的方法
- (void)cm_titleViewBlock:(CMTitleView *)titleView {
    titleView.block = ^void(NSInteger index,UIButton *selectBtn) {
        _sectionViewSelectBtn = selectBtn;
        switch (index) {
            case 0://分析师诊断
                self.type = CMProductSelecttypeAnalystsDiagnosis;
                _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Investment.aspx?pcode=", self.codeName));
                 [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                [_curTableView hideFooter];
                [self tableScrollToRow];
                break;
            case 1: //行情吧
                self.type = CMProductSelectTypeComments;
                [self requestTopicData]; //评论
                break;
            case 2: //信息披露
                self.type = CMProductSelectTypeNounce;
                [self requestAnnouncement]; //公告
                [_curTableView hideFooter];
                break;
            case 3: //公司概况
                self.type = CMProductSelectTypeEnterprise;
                _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/CompanyIntroduce.aspx?pcode=", self.codeName));
                [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                [_curTableView hideFooter];
                [self tableScrollToRow];
                break;
            case 4: //产品与市场
                self.type = CMProductSelectTypeProductAndMarket;
                _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/ProductMarket.aspx?pcode=", self.codeName));
                [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                [_curTableView hideFooter];
                [self tableScrollToRow];
                break;
            case 5: //财务指标
                self.type = CMProductSelectTypeFinancialIndicators;
                _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Financial.aspx?pcode=", self.codeName));
                [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                [_curTableView hideFooter];
                [self tableScrollToRow];
                break;
            case 6: //团队与股权
                self.type = CMProductSelectTypeTeamEquity;
                _htmlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Equity.aspx?pcode=", self.codeName));
                [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                [_curTableView hideFooter];
                [self tableScrollToRow];
                break;
            case 7: //产品详情
               // self.type = CMProductSelectTypeDetails;
                [self cm_commentCellSkipBoundary];
                break;
            default:
                break;
        }
    };
    
    /*
    switch (self.type) {
        case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
     
            break;
        case CMProductSelectTypeComments: //行情吧
       
            break;
        case CMProductSelectTypeNounce: //信息披露
            
            break;
        case CMProductSelectTypeEnterprise: //公司概况
            
            break;
        case CMProductSelectTypeProductAndMarket: //产品与市场
            
            break;
        case CMProductSelectTypeFinancialIndicators: //财务指标
            
            break;
        case CMProductSelectTypeTeamEquity: //团队与股权
            
            break;
        case CMProductSelectTypeDetails: //产品详情
            
            break;
        default:
            break;
    }
*/
    
}
- (void)tableScrollToRow {
    [_curTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//点击table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.type) {
        case CMProductSelecttypeAnalystsDiagnosis://分析师诊断
            
            break;
        case CMProductSelectTypeComments: //行情吧
        
            break;
        case CMProductSelectTypeNounce: //信息披露
            //[self cm_commentViewControllProductNotion:_commDataArr[indexPath.row]];
            break;
        case CMProductSelectTypeEnterprise: //公司概况
            
            break;
        case CMProductSelectTypeProductAndMarket: //产品与市场
            
            break;
        case CMProductSelectTypeFinancialIndicators: //财务指标
            
            break;
        case CMProductSelectTypeTeamEquity: //团队与股权
            
            break;
        case CMProductSelectTypeDetails: //产品详情
            
            break;
        default:
            break;
    }
}
#pragma mark - 创建cell
//信息披露cell
- (UITableViewCell *)productSelectTypeNounceTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CMNewCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CMNewCommentTableViewCell"];
    if (!commentCell) {
        commentCell = [[NSBundle mainBundle] loadNibNamed:@"CMNewCommentTableViewCell" owner:nil options:nil].firstObject;
    }
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    commentCell.productNotion = _commDataArr[indexPath.row];
    return commentCell;
}
//行情吧
- (UITableViewCell *)productSelectTopicTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CMoptionReleaseTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"CMoptionReleaseTableViewCell"];
    if (!optionCell) {
        optionCell = [[NSBundle mainBundle] loadNibNamed:@"CMoptionReleaseTableViewCell" owner:nil options:nil].firstObject;
    }
    optionCell.delegate = self;
    optionCell.block = ^() {
        if (self.anounDataArr.count == 0) {
            _topTabeViewLayout.constant = -230;
        }
    };
    
    return optionCell;
}
- (UITableViewCell *)productSelectTopicContentTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CMReplyTableViewCell *replyCell = [tableView dequeueReusableCellWithIdentifier:@"CMReplyTableViewCell"];
    if (!replyCell) {
        replyCell = [[NSBundle mainBundle] loadNibNamed:@"CMReplyTableViewCell" owner:nil options:nil].firstObject;
    }
    replyCell.delegate = self;
    replyCell.topicList = _anounDataArr[indexPath.row - 1];
    replyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return replyCell;
}

//加载html的数据
- (UITableViewCell *)productSelectTyoeHtmlTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CMWebHtmlTableViewCell *htmlWeb = [tableView dequeueReusableCellWithIdentifier:@"CMWebHtmlTableViewCell"];
    if (!htmlWeb) {
        htmlWeb = [[NSBundle mainBundle] loadNibNamed:@"CMWebHtmlTableViewCell" owner:nil options:nil].firstObject;
    }
    htmlWeb.block = ^() {
        [UIView animateWithDuration:(0.5) animations:^{
            self.curTableView.contentOffset = CGPointMake(0, 0);
        }];
    };
    htmlWeb.htmlString = _htmlStr;
    return htmlWeb;
}


#pragma mark - 买入卖出 btnclick
//买入
- (IBAction)buyingBtnClick:(UIButton *)sender {
    [self pushTradeSonInterVCItemIndex:0 codeName:_codeName];
}
//卖出
- (IBAction)saleBtnClick:(UIButton *)sender {
    [self pushTradeSonInterVCItemIndex:1 codeName:_codeName];
}
//咨询
- (IBAction)consultingBtnClick:(UIButton *)sender {
    CMAnalystViewController *analystVC = (CMAnalystViewController *)[CMAnalystViewController initByStoryboard];
    [self.navigationController pushViewController:analystVC animated:YES];
}
//分享
- (IBAction)shareBtnClick:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMShareView *shareView = [[NSBundle mainBundle] loadNibNamed:@"CMShareView" owner:nil options:nil].firstObject;
    shareView.center = window.center;
    shareView.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    shareView.contentUrl = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Detail?pcode=",self.codeName));
    shareView.titleConten = CMStringWithPickFormat(_versionPatch, @",100%安全投资，优质好项目10倍收益赚不停");
    NSString *content = [NSString stringWithFormat:@"预期收益%@(包含保底年收益%@+浮动)%@,具有多倍增值空间--新经版，只赚不赔的10倍原始股",_earnings,_guaranteed,_versionPatch];
    shareView.contentStr = CMStringWithPickFormat(@"100%安全和新经板，只赚不赔的10原始股是固定的",content);
    [window addSubview:shareView];
}

//确定
- (IBAction)defineBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _btmView.hidden = YES;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _bottomLayoutConstraint.constant = 0.0f;
    }];
    if (_isSearchOrReply) {
        CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
        productVC.codeName = _numberTextField.text;
        [self.navigationController pushViewController:productVC animated:YES];
    } else {
        _isSearchOrReply = YES;
        [CMRequestAPI cm_marketFetchReplyCreateTopicId:_topicId content:_numberTextField.text success:^(BOOL isWin) {
            [self hiddenAllProgressHUD];
            [self showHUDWithMessage:@"回复成功" hiddenDelayTime:2];
        } fail:^(NSError *error) {
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    }
    _numberTextField.text = @"";
}
//查找
- (IBAction)findBtnClick:(UIButton *)sender {
    [_numberTextField becomeFirstResponder];
    _btmView.hidden = NO;
    _bgView.hidden = NO;
}
//团出键盘
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
     _bottomLayoutConstraint.constant = height;
    
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    _bottomLayoutConstraint.constant = 0.0f;
    _topTabeViewLayout.constant = 0.0f;
    _btmView.hidden = YES;
    _bgView.hidden = YES;
    
}
//刷新
- (IBAction)refreshBtnClick:(UIButton *)sender {
    [_curTableView beginHeaderRefreshing];
}

- (void)pushTradeSonInterVCItemIndex:(NSInteger)index codeName:(NSString *)code{
    if (!CMIsLogin()) {
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
        
    } else {
        CMTradeSonInterfaceController *tradeSonVC = (CMTradeSonInterfaceController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTradeSonInterfaceController"];
        tradeSonVC.itemIndex = index;
        tradeSonVC.codeStr = code;
        [self.navigationController pushViewController:tradeSonVC animated:YES];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _btmView.hidden = YES;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _bottomLayoutConstraint.constant = 0.0f;
    }];
    
}

#pragma mark - CMCommentTableViewCellDelegate
//跳转到M站 详情<<
- (void)cm_commentCellSkipBoundary {
//#warning 这个先这样。到时候该
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Products/Detail?pcode=",self.codeName));
//    [NSString stringWithFormat:@"%@%d",@"http://192.168.1.15:8384/Products/Detail?pcode=",2010];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)cm_commentViewControllProductNotion:(CMProductComment *)product {
    CMCommentViewController *commentVC = (CMCommentViewController *)[CMCommentViewController initByStoryboard];
    commentVC.title = @"评论详情";
    commentVC.product = product;
    
    [self.navigationController pushViewController:commentVC animated:YES];
}
//公告
- (void)cm_commentNoticeViewNoticeId:(NSInteger)noticeId {
    //http://mz.58cm.com/Account/MessageDetail?nid=
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    webVC.urlStr = CMStringWithPickFormat(kCMMZWeb_url, CMStringWithPickFormat(@"/Account/MessageDetail?nid=",CMStringWithFormat(noticeId)));
   // [NSString stringWithFormat:@"http://mz.58cm.com/Account/MessageDetail?nid=%ld",(long)noticeId];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma mark - 发布话题
- (void)cm_optionReleaseRequestData:(NSString *)request {
    [self.view endEditing:YES];
    if (CMIsLogin()) {
        [CMRequestAPI cm_marketFetchCreateProductPcode:_codeName content:request success:^(BOOL isWin) {
            if (isWin) {
                [self showHUDWithMessage:@"回复成功" hiddenDelayTime:2];
                [self requestTopicData];
            }
        } fail:^(NSError *error) {
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    } else {
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
}
#pragma mark - 回复话题 CMReplyTableViewCellDelegate
- (void)cm_replyTableTopicList:(CMTopicList *)topic {
    if (CMIsLogin()) {
        _topicId = topic.topicid;
        _isSearchOrReply = NO;
        _numberTextField.keyboardType = UIKeyboardTypeDefault;
        [self findBtnClick:nil];
    } else {
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}
- (void)cm_replyTableLockMore:(CMTopicList *)topic {
    CMTopicReplyViewController *replyVC = (CMTopicReplyViewController *)[CMTopicReplyViewController initByStoryboard];
    replyVC.topicId = topic.topicid;
    [self.navigationController pushViewController:replyVC animated:YES];
}


#pragma mark - setGet
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    }
    return _titleView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 15)];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = [UIColor cmFontWiteColor];
        //_titleLab.text = @"开始前钱了llllll";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 200, 15)];
        _numberLab.font = [UIFont systemFontOfSize:10];
        _numberLab.textColor = [UIColor cmFontWiteColor];
        //numberLab.text = @"12345679";
        _numberLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLab;
}
//产品行情明细价格
- (NSMutableArray *)productArr {
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}
- (void)requestOpenTimer {
    __weak typeof(self) weakSelef = self;
    _timer = [[CMTimer alloc] initTimerInterval:10];
    _timer.timerMinblock = ^(){
        //产品行情明细价格
        [weakSelef requestMarketProduct];
    };
}

- (CMTitleView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[NSBundle mainBundle] loadNibNamed:@"CMTitleView" owner:nil options:nil].firstObject;
        [self cm_titleViewBlock:_sectionView];
    }
    return _sectionView;
}

- (void)requestOpenProduct {
    [self requestMarketProduct];
}



#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化
- (void)reconnect {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CMStringWithPickFormat(kWebSocket_url, @"market/product?")]]];
    self.webSocket.delegate = self;
    
    //self.title = @"Opening Connection...";
    
    [self.webSocket open];
    
}
#pragma mark - SRWebSocketDelegate
//发送请求
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
    //self.title = @"Connected!";
    //发送消息
    [_webSocket send:@":price::"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    // self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"---%@",message);
//    [self.marketArr removeAllObjects];
//    NSArray *dataArr = [message componentsSeparatedByString:@";"];
//    for (NSInteger i = 0; i <dataArr.count; i ++) {
//        NSString *smailStr = dataArr[i];
//        NSArray *smailArr = [smailStr componentsSeparatedByString:@","];
//        [self.marketArr addObject:smailArr];
//        
//        //  NSLog(@"---marketArrmarketArr-%ld",self.marketArr.count);
//    }
    [_curTableView reloadData];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    self.title = @"Connection Closed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"---%@",reply);
}
#pragma mark -  CMProductDetailsDelegate
- (void)cm_productDetailsViewCell:(CMProductDetailsTableViewCell *)product {
    //没有登录。跳转到登录页
    //位登录。显示登录
    UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)cm_productOptionType:(CMProductOptionType)type {
    switch (type) {
        case CMProductOptionTypeAddOption://添加自选
        {
            [self showDefaultProgressHUD];
            //测试用。所以写死了。
            [CMRequestAPI cm_marketTransferAddCode:_codeName  success:^(BOOL isWin) {
                [self hiddenProgressHUD];
                if (isWin == YES) {
                    [self showHUDWithMessage:@"添加成功" hiddenDelayTime:2];
                    [self addRequestDataMeans];
                } else {
                    [self showHUDWithMessage:@"添加失败" hiddenDelayTime:2];
                }
                
            } fail:^(NSError *error) {
                [self hiddenProgressHUD];
                [self showHUDWithMessage:error.message hiddenDelayTime:2];
            }];
        }
            break;
        case CMProductOptionTypeDeleteOption: //删除自选
        {
            [self showDefaultProgressHUD];
            //测试用。所以写死了。
            [CMRequestAPI cm_marketTransferDeleteCode:_codeName success:^(BOOL isWin) {
                [self hiddenProgressHUD];
                if (isWin == YES) {
                    [self showHUDWithMessage:@"删除成功" hiddenDelayTime:2];
                    [self addRequestDataMeans];
                } else {
                    [self showHUDWithMessage:@"删除失败" hiddenDelayTime:2];
                }
            } fail:^(NSError *error) {
                [self hiddenProgressHUD];
                [self showHUDWithMessage:error.message hiddenDelayTime:2];
            }];
        }
            break;
        case CMProductOptionTypeShow:
        {
            _isShow =! _isShow;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_curTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        default:
            break;
    }
    
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
