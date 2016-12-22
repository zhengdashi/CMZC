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


@interface CMProductDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,CMCommentTableViewCellDelegate,SRWebSocketDelegate,CMProductDetailsDelegate> {
    BOOL _isFirst;
}
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

@property (strong, nonatomic) NSArray  *anounDataArr; //品论
@property (strong, nonatomic) NSArray *commDataArr; //公告
@property (nonatomic,copy) NSString *enterPrise; //企业信息
@property (strong, nonatomic) UIButton *sectionViewSelectBtn; //选中的but


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
    [self requestComments]; //评论
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //打开定时器
    [self requestOpenTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭定时器
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
    [_curTableView addFooterWithFinishBlock:^{
        switch (self.type) {
            case CMProductSelectTypeNounce: //公告
            {
                [self requestComments];
            }
                break;
            case CMProductSelectTypeComments: //评论
            {
                
            }
                break;
            default: //企业详情
                
                
                break;
        }
    }];
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [self requestMarketProduct];
}
//分时
- (void)requestMarketProduct {
    [CMRequestAPI cm_marketTransferProductCode:_codeName success:^(NSArray *productArr) {
        [_curTableView endRefresh];
        self.titleLab.text = productArr[0][0];
        [self.productArr removeAllObjects];
        [self.productArr addObjectsFromArray:productArr];
        [_curTableView beginUpdates];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView endUpdates];
        if (!_isFirst) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isFirstTime" object:self userInfo:@{@"earlyMorning":productArr[0][1]}];
            _isFirst = YES;
        }
        
    } fail:^(NSError *error) {
        MyLog(@"请求产品行情详情接口失败");
    }];
    
}

//评论
- (void)requestComments {
    [CMRequestAPI cm_homeFetchAnswerPointAnalystId:0 pcode:[_codeName integerValue] pageIndex:1 success:^(NSArray *pointArr, BOOL isPage) {
        _anounDataArr = pointArr;
        [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [UIView animateWithDuration:0.3 animations:^{
            _sectionView.markView.frame = CGRectMake(CGRectGetMinX(_sectionViewSelectBtn.frame), CGRectGetHeight(_sectionViewSelectBtn.frame)+3, CGRectGetWidth(_sectionViewSelectBtn.frame), 3);
        }];
    } fail:^(NSError *error) {
        MyLog(@"行情评论信息请求是吧");
    }];
}
//公告
- (void)requestAnnouncement {
    [CMRequestAPI cm_marketFetchProductNoticePCode:_codeName pageIndex:1 success:^(NSArray *noticeArr) {
        _commDataArr = noticeArr;
         [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [UIView animateWithDuration:0.3 animations:^{
        _sectionView.markView.frame = CGRectMake(CGRectGetMinX(_sectionViewSelectBtn.frame), CGRectGetHeight(_sectionViewSelectBtn.frame)+3, CGRectGetWidth(_sectionViewSelectBtn.frame), 3);
        }];
    } fail:^(NSError *error) {
        MyLog(@"行情公告信息请求失败");
    }];
}
//企业信息
- (void)requestEnterprise {
    //_businessView.webStr = @"http://zcapi.58cm.com/api/product/context/800082";
    NSString *urlScheme = [NSString stringWithFormat:@"%@%@",kMProductContextURL,CMNumberWithFormat([_codeName integerValue])];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kCMBaseApiURL,urlScheme];
    
    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
    NSData *htemlData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *temParser = [[TFHpple alloc] initWithHTMLData:htemlData];
    NSArray *dataArray = [temParser searchWithXPathQuery:@"//span"];
    NSString *contentStr = @"公司简介：\n";
    for (TFHppleElement *hppleElement in dataArray) {
        NSLog(@"-dataArray--%@",hppleElement.text);
        NSString *str = hppleElement.text;
        if ([str isEqual:@"\\n"]) {
            str = @"\n";
        }
        
        if (str.length >1) {//拼接字符串
            contentStr = [contentStr stringByAppendingString:str];
        }
    }
    _enterPrise = contentStr;
    [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.3 animations:^{
        _sectionView.markView.frame = CGRectMake(CGRectGetMinX(_sectionViewSelectBtn.frame), CGRectGetHeight(_sectionViewSelectBtn.frame)+3, CGRectGetWidth(_sectionViewSelectBtn.frame), 3);
    }];
    NSLog(@"--contentStr--%@",contentStr);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//设置区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        switch (self.type) {
            case CMProductSelectTypeComments: //评论
                return _anounDataArr.count > 0?0:40;
                break;
            case CMProductSelectTypeNounce: //公告
                return _commDataArr.count > 0?0:40;
                break;
            case CMProductSelectTypeEnterprise:
                return _enterPrise.length > 0?0:40;
                break;
            default: //企业信息
                return 0;
                break;
        }
    } else {
        return 0;
    }
}

//设置区的单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        switch (self.type) {
            case CMProductSelectTypeComments: //评论
                return _anounDataArr.count;
                break;
            case CMProductSelectTypeNounce: //公告
                return _commDataArr.count;
                break;
            case CMProductSelectTypeEnterprise:
                return 1;
            default: //企业信息
                return 0;
                break;
        }
    }
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 140;
        } else {
            return 259;
        }
    } else {
        switch (self.type) {
            case CMProductSelectTypeComments: //评论
            {
                CMAnalystPoint *notion = _anounDataArr[indexPath.row];
                CGFloat height = [notion.content getHeightIncomingWidth:CMScreen_width()-30 incomingFont:14];
                if (height>34) {
                    height = 34;
                }
                CGFloat titHeight = 64;
                if (notion.title.length > 1) {
                    titHeight = 80;
                }
                return titHeight-17 + height+16;
            }
                break;
            case CMProductSelectTypeNounce: //公告
            {
                CMProductNotion *productCom = _commDataArr[indexPath.row];
                CGFloat height = [productCom.title getHeightIncomingWidth:CMScreen_width()-30  incomingFont:14];
                return 63-14 + height+10;
            }
                break;
            case CMProductSelectTypeEnterprise:
            {
                CGFloat height = [_enterPrise getHeightIncomingWidth:CMScreen_width()-30  incomingFont:14];
                return 63-14 + height+25;
            }
                break;
            default: //企业信息
            {
                return 0;
            }
                break;
        }
    }
}
//设置区的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CMProductDetailsTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"CMProductDetailsTableViewCell" forIndexPath:indexPath];
            productCell.selectionStyle = UITableViewCellSelectionStyleNone;
            productCell.productArr = self.productArr;
            productCell.delegate = self;
            return productCell;
        } else {
            CMChartTableViewCell *chartCell = [tableView dequeueReusableCellWithIdentifier:@"CMChartTableViewCell" forIndexPath:indexPath];
            chartCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chartCell.code = _codeName;
            return chartCell;
        }
    } else {
        CMNewCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CMNewCommentTableViewCell"];
        if (!commentCell) {
            commentCell = [[NSBundle mainBundle] loadNibNamed:@"CMNewCommentTableViewCell" owner:nil options:nil].firstObject;
        }
        
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (self.type) {
            case CMProductSelectTypeComments: //评论
            {
                commentCell.analystPoint = _anounDataArr[indexPath.row];
            }
                break;
            case CMProductSelectTypeNounce: //公告
            {
                commentCell.productNotion = _commDataArr[indexPath.row];
            }
                break;
            case CMProductSelectTypeEnterprise:
                commentCell.introduceStr = _enterPrise;
                break;
            default: //企业信息
                break;
        }
        return commentCell;
    }
}
//设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        _sectionView = [[NSBundle mainBundle] loadNibNamed:@"CMTitleView" owner:nil options:nil].firstObject;
        [self cm_titleViewBlock:_sectionView];
        return _sectionView;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
        //footerView.backgroundColor = [UIColor redColor];
        UILabel *footTitleLab = [[UILabel alloc] init];
        footTitleLab.center = footerView.center;
        footTitleLab.frame = CGRectMake(0, 0, 120, 30);
        footTitleLab.font = [UIFont systemFontOfSize:15];
        footTitleLab.textColor = [UIColor cmDividerColor];
        switch (self.type) {
            case CMProductSelectTypeComments: //评论
            {
                footTitleLab.text = @"暂无评论！";
            }
                break;
            case CMProductSelectTypeNounce: //公告
            {
                footTitleLab.text = @"暂无公告！";
            }
                break;
            case CMProductSelectTypeEnterprise:
            {
                footTitleLab.text = @"暂无企业信息！";
            }
                break;
            default: //企业信息
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
            case 0:
                self.type = CMProductSelectTypeComments;
                [self requestComments]; //评论
                
                break;
            case 1:
                self.type = CMProductSelectTypeNounce;
                [self requestAnnouncement]; //公告
                
                break;
            case 2:
                self.type = CMProductSelectTypeEnterprise;
                [self requestEnterprise];
                break;
            default:
                self.type = CMProductSelectTypeDetails;
                [self cm_commentCellSkipBoundary];
                break;
        }
    };
}


//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.type) {
        case CMProductSelectTypeNounce: //公告
        {
            CMProductNotion *product = _commDataArr[indexPath.row];
            [self cm_commentNoticeViewNoticeId:product.notionId];
        }
            break;
        case CMProductSelectTypeComments://评论
            [self cm_commentViewControllProductNotion:_anounDataArr[indexPath.row]];
            break;
        case CMProductSelectTypeDetails: //公司详情
            [self cm_commentCellSkipBoundary];
        default: //公司详情
            break;
    }
    
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
//确定
- (IBAction)defineBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _btmView.hidden = YES;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _bottomLayoutConstraint.constant = 0.0f;
    }];
    CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
    productVC.codeName = _numberTextField.text;
    [self.navigationController pushViewController:productVC animated:YES];
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
    _timer = [[CMTimer alloc] initTimerInterval:5];
    _timer.timerMinblock = ^(){
        //产品行情明细价格
        [weakSelef requestMarketProduct];
    };
    
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
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://zcapi.58cm.com:8081/market/product?"]]];
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
