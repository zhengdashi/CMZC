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
}
- (void)viewWillAppear:(BOOL)animated {
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
        [_curTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView endUpdates];
        if (!_isFirst) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isFirstTime" object:self userInfo:@{@"earlyMorning":productArr[0][1]}];
            _isFirst = YES;
        }
        
    } fail:^(NSError *error) {
        MyLog(@"请求产品行情详情接口失败");
    }];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140;
    } else if (indexPath.row == 1) {
        return 259;
    } else {
        return 311;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            CMProductDetailsTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"CMProductDetailsTableViewCell" forIndexPath:indexPath];
            productCell.selectionStyle = UITableViewCellSelectionStyleNone;
            productCell.productArr = self.productArr;
            productCell.delegate = self;
            return productCell;
        }
            break;
        case 1:
        {
            CMChartTableViewCell *chartCell = [tableView dequeueReusableCellWithIdentifier:@"CMChartTableViewCell" forIndexPath:indexPath];
            chartCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chartCell.code = _codeName;
            return chartCell;
        }
            break;
        default:
        {
            CMCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CMCommentTableViewCell" forIndexPath:indexPath];
            commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            commentCell.delegate = self;
            commentCell.code = _codeName;
            return commentCell;
        }
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
