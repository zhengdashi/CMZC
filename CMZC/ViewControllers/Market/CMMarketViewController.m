//
//  CMMarketViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMarketViewController.h"
#import "CMMarketTableViewCell.h"
#import "CMProductDetailsViewController.h"
#import "SRWebSocket.h"
#import "CMProductType.h"
#import "CMMarketTitleView.h"
#import "CMErrorView.h"


@interface CMMarketViewController ()<TitleViewDelegate,UITableViewDelegate,UITableViewDataSource,SRWebSocketDelegate> {
    BOOL _isConvert;//标记是否旋转
    NSString    *nameStr;
    //分类
    NSString *_ccodeId; //分类
    //涨跌幅
    NSString *_sorting;
    
}
@property (weak, nonatomic) IBOutlet CMMarketTitleView *marketTitleView;
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIImageView *indicateImageView;//调整imageview
@property (strong, nonatomic) NSMutableArray *marketArr;
@property (strong, nonatomic)  SRWebSocket *webSocket;
@property (strong, nonatomic) CMErrorView *errorView; //错误view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *botmViewbtomLayout; //下约束
@property (weak, nonatomic) IBOutlet UITextField *codeTextField; //编码
@property (weak, nonatomic) IBOutlet UIView *bottmView;
@property (weak, nonatomic) IBOutlet UIView *bgView; //点击的view

@property (strong, nonatomic) NSString *descRange;

@end

@implementation CMMarketViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // _isConvert = NO;
   
    nameStr = @"000000";
    _titleView.backgroundColor = [UIColor blackColor];
    /*不用这个了
    [self showDefaultProgressHUD];
    [self addRequestDataMeans];
    */
    _curTableView.tableFooterView = [[UIView alloc] init];
    
    [self requestTitle];
    //上边四个title
    [self titleViewBtnClick];
    [_curTableView addHeaderWithFinishBlock:^{
        [CMCommonTool executeRunloop:^{
            [_curTableView endRefresh];
        }afterDelay:2];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //测试。先注销
    //行情详情
    [self reconnect];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.webSocket) {
        self.webSocket.delegate = nil;
        [self.webSocket close];
        
    }
}

#pragma mark - 数据请求

- (void)requestTitle {
    [CMRequestAPI cm_marketFetchProductTypeSuccess:^(NSArray *typeArr) {
        self.marketTitleView.titleArr = typeArr;
    } fail:^(NSError *error) {
        MyLog(@"请求title str失败");
    }];
}

//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    _curTableView.hidden = YES;
    [self requestListWithPageNo:1 code:@"" sorting:@"price"];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1 code:_ccodeId sorting:_sorting];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = self.marketArr.count / 10 +1;
        [self requestListWithPageNo:page code:_ccodeId sorting:_sorting];
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page code:(NSString *)code sorting:(NSString *)sort{
    
    [CMRequestAPI cm_marketFetchProductMarketCcode:code sizePage:page sorting:sort success:^(NSArray *marketArr, BOOL isPage) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];//结束刷新
        _curTableView.hidden = NO;
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.marketArr removeAllObjects];
        }
        [self.marketArr addObjectsFromArray:marketArr];
        [_curTableView reloadData];
        
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];//结束刷新
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marketArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMarketTableViewCell *marketCell = [tableView dequeueReusableCellWithIdentifier:@"CMMarketTableViewCell" forIndexPath:indexPath];
    marketCell.numberLab.text = nameStr;
    marketCell.dataListArr = self.marketArr[indexPath.row];
    return marketCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //为了测试。先注销了。
    
    NSArray *dataArr = self.marketArr[indexPath.row];
    CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
    productVC.titleName = dataArr[1];
    productVC.codeName = dataArr[0];
    
    [self.navigationController pushViewController:productVC animated:YES];
    
}


#pragma mark - btnClick
//涨跌幅
- (IBAction)adjustBtnClick:(UIButton *)sender {
    _isConvert =!_isConvert;
    
    NSString *codeStr;
    if (!_isConvert) {
        _indicateImageView.transform=CGAffineTransformMakeRotation(M_PI*2);
        
        if (_descRange.length>0) {
            codeStr = [NSString stringWithFormat:@"%@:range:asc:",_descRange];
        } else {
            codeStr = [NSString stringWithFormat:@":range:asc:"];
        }
    } else {
        _indicateImageView.transform=CGAffineTransformMakeRotation(M_PI);
        if (_descRange.length>0) { //判断上边选项的四个分类是否是。如果是，就加上分类，如果不是，就不要用分类
            codeStr = [NSString stringWithFormat:@"%@:range:desc:",_descRange];
        } else {
            codeStr = [NSString stringWithFormat:@":range:desc:"];
        }
       
    }
    if (self.webSocket) {
        [self.webSocket send:codeStr];
    }
}
//查找
- (IBAction)findCodeBtnClick:(UIButton *)sender {
    [_codeTextField becomeFirstResponder];
    _bottmView.hidden = NO;
    _bgView.hidden = NO;
    
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        _botmViewbtomLayout.constant = height;
    }];

}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    _botmViewbtomLayout.constant = 0.0f;
    _bottmView.hidden = YES;
    _bgView.hidden = YES;
}


//刷新
- (IBAction)refreshBtnClick:(UIButton *)sender {
    [_curTableView beginHeaderRefreshing];
}

#pragma mark - 数据请求
//点击确定
- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _bottmView.hidden = YES;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _botmViewbtomLayout.constant = 0.0f;
    }];
    CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
    productVC.codeName = _codeTextField.text;
    [self.navigationController pushViewController:productVC animated:YES];
}


#pragma mark - initTitle
- (void)titleViewBtnClick {
    //上边四个的按钮block
    __weak typeof(self) weakSelef = self;
    _marketTitleView.marketBlock = ^(NSInteger index) {
        NSString *codeStr;
        if (index == 1020) {
            _descRange = nil;
            [weakSelef reconnect];
        } else {
            _descRange = CMStringWithFormat(index);
            codeStr = [NSString stringWithFormat:@"%ld:range:desc:1:10",(long)index];
            if (self.webSocket) {
                [self.webSocket send:codeStr];
            }
        }
    };
}


#pragma mark - getter
- (NSMutableArray *)marketArr {
    if (!_marketArr) {
        _marketArr = [NSMutableArray array];
    }
    return _marketArr;
}
- (CMErrorView *)errorView {
    if (!_errorView) {
        _errorView = [[CMErrorView alloc] initWithFrame:CGRectMake(0, 144, CMScreen_width(), CMScreen_height()) bgImageName:@"chiyou_trade"];
    }
    return _errorView;
}
#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _bottmView.hidden = YES;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _botmViewbtomLayout.constant = 0.0f;
    }];
    
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
//初始化
- (void)reconnect {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CMStringWithPickFormat(kWebSocket_url, @"market/product?")]]];//@"ws://zcapi.58cm.com:8081/market/product?"
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
    [_webSocket send:@":range:asc:1:20"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
   // self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
   // NSLog(@"---%@",message);
    [self.marketArr removeAllObjects];
    NSString *messag = (NSString *)message;
     NSString *contStr = [message substringWithRange:NSMakeRange(2, messag.length - 2)];
    if (contStr.length == 0) {
        _curTableView.hidden = YES;
        [self.view addSubview:self.errorView];
    } else {
        if (_errorView) {
            [self.errorView removeView];
        }
        _curTableView.hidden = NO;
        NSArray *dataArr = [contStr componentsSeparatedByString:@";"];
        for (NSInteger i = 0; i <dataArr.count; i ++) {
            NSString *smailStr = dataArr[i];
            NSArray *smailArr = [smailStr componentsSeparatedByString:@","];
            [self.marketArr addObject:smailArr];
        }
        [_curTableView reloadData];
    }
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"---%@",reply);
}

#pragma mark - SendButton Response
- (IBAction)sendAction:(id)sender {
    [self.view endEditing:YES];
    // WebSocket
    if (self.webSocket) {
        [self.webSocket send:@"test success"];
    }
}

@end

























