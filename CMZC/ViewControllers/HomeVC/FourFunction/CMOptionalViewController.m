//
//  CMOptionalViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define iOS8  [[[UIDevice currentDevice] systemVersion] floatValue]

#import "CMOptionalViewController.h"
#import "CMOptionalTableViewCell.h"
#import "APNumberPad.h"
#import "CMTabBarViewController.h"
#import "CMWebSocket.h"
#import "CMProductDetailsViewController.h"
#import "SRWebSocket.h"

@interface CMOptionalViewController ()<UITableViewDelegate,UITableViewDataSource,APNumberPadDelegate,CMWebSocketDelegate,SRWebSocketDelegate> {
    BOOL _isConvert;
    
    BOOL _isPushOptional;
   // BOOL _isAddOptional; //知否是点击了添加自选
    
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UITextField *encodingTextField;//输入编码textfield
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btomViewBotLayout;
@property (weak, nonatomic) IBOutlet UIView *btmView;
@property (weak, nonatomic) IBOutlet UIView *clickBgView;
@property (nonatomic,assign) BOOL isPitch;  //判断选中btnview的状态
@property (weak, nonatomic) IBOutlet UIView *btnView; //自选 行情
@property (nonatomic,copy) UIButton *doneInKeyboardButton;

@property (weak, nonatomic) IBOutlet UIImageView *optionImage; //上下图片
@property (strong, nonatomic) NSMutableArray *optionalArr; //数组
@property (strong, nonatomic) UIView *errorView;
@property (strong, nonatomic) NSMutableArray *proictArr;
//@property (strong, nonatomic) CMWebSocket *webSocket;
@property (strong, nonatomic) SRWebSocket *webSocket;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation CMOptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isPushOptional = YES;
    _curTableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor cmMarkBlock];
    _encodingTextField.inputView = ({
        APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
        [numberPad.leftFunctionButton setTitle:@"清除" forState:UIControlStateNormal];
        numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        numberPad;
        
    });
    
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [_curTableView addHeaderWithFinishBlock:^{
        [CMCommonTool executeRunloop:^{
            [_curTableView endRefresh];
        }afterDelay:2];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //测试先不用 先注销了
//    NSString *phoneName = [CMAccountTool sharedCMAccountTool].currentAccount.userName;
//    _webSocket = [[CMWebSocket alloc] initRequestUrl:[NSString stringWithFormat:@"%@%@",@"ws://zcapi.58cm.com:8081/product/collect?m=",phoneName]];
//    
//    _webSocket.delegate = self;
    [self reconnect];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_webSocket close];
   
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_isPushOptional == NO) {
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


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionalArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMOptionalTableViewCell *optionalCell = [tableView dequeueReusableCellWithIdentifier:@"CMOptionalTableViewCell" forIndexPath:indexPath];
    optionalCell.optionalArr = self.optionalArr[indexPath.row];
    return optionalCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *optional = self.optionalArr[indexPath.row];
    NSString *nameStr = optional[1];
    NSString *codeStr = optional[0];
    
    CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
    productVC.codeName = codeStr;
    productVC.titleName = nameStr;
    [self.navigationController pushViewController:productVC animated:YES];
    
}



#pragma mark - APNumberPadDelegate
- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:self.encodingTextField]) {
        _encodingTextField.text = @"";
    }
}
#pragma mark - CMWebSocketDelegate 
- (void)cm_webScketMessage:(NSString *)message {
    
   
}
//初始化
- (void)reconnect {
    self.webSocket.delegate = nil;
    [self.webSocket close];
     NSString *phoneName = [CMAccountTool sharedCMAccountTool].currentAccount.userName;
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CMStringWithPickFormat(kWebSocket_url, @"product/collect?m="),phoneName]]]];
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
    [_webSocket send:@"range:desc:1:20"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    // self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    [self.optionalArr removeAllObjects];
    NSString *messag = message;
    
    NSString *contStr = [messag substringWithRange:NSMakeRange(2, messag.length - 2)];
    if (contStr.length == 0) {
        [_webSocket close];
        [self.view addSubview:self.errorView];
        return;
    }
    
    
    NSArray *marketArr = [contStr componentsSeparatedByString:@";"];
    for (NSString *dataStr in marketArr) {
        NSArray *marketIndexArr = [dataStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        [self.optionalArr addObject:marketIndexArr];
    }
    
    [_curTableView reloadData];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"---%@",reply);
}

#pragma mark - self Click
- (IBAction)searchBtnClick:(UIButton *)sender {
    [_encodingTextField becomeFirstResponder];
    [self.view bringSubviewToFront:_btmView];
    _btmView.hidden = NO;
    _clickBgView.hidden = NO;//因为需要点击屏幕让键盘下落，而屏幕上方是个表。所以只能在键盘弹出的瞬间在window上放一个view
    [UIView animateWithDuration:0.25 animations:^{
        //由于这边只有一个数字几盘。切高度不会切换，所以，就固定一个高度了。如果是多中键盘，就不能这么搞
        _btomViewBotLayout.constant = 216.0f;
    }];
}
//点击确定按钮
- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    [self keyboardLanding];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self keyboardLanding];
    _btnView.hidden = YES;
    _isPitch = NO;
}
- (IBAction)moreBtnClick:(UIButton *)sender {
    _isPitch =! _isPitch;
    if (_isPitch) {
        _btnView.hidden = NO;
        _clickBgView.hidden = YES;
    } else{
        _btnView.hidden = YES;
        _clickBgView.hidden = NO;
    }
    
}
//添加自选
- (IBAction)addOptionalBtnClick:(id)sender {
    _btnView.hidden = YES;
    _isPushOptional = NO;
    [self addCollectBtnClick];
    
    
}
//上下排序
- (IBAction)optionUpOrFallBtnClick:(UIButton *)sender {
    _isConvert =!_isConvert;
    
    NSString *codeStr;
    if (!_isConvert) {
        _optionImage.transform=CGAffineTransformMakeRotation(M_PI*2);
        
            codeStr = [NSString stringWithFormat:@"range:desc:1:20"];
       
    } else {
        _optionImage.transform=CGAffineTransformMakeRotation(M_PI);
        
            codeStr = [NSString stringWithFormat:@"range:asc:1:20"];
    }
    if (self.webSocket) {
        [self.webSocket send:codeStr];
    }
}
//刷新数据
- (IBAction)refreshBtnClick:(id)sender {
    _btnView.hidden = YES;
    [_curTableView beginHeaderRefreshing];
    
}
//键盘下落
- (void)keyboardLanding {
    [self.view endEditing:YES];
    
    _clickBgView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _btomViewBotLayout.constant = 0.0f;
    } completion:^(BOOL finished) {
        _btmView.hidden = YES;
    }];
    //添加自选
    if (_codeTextField.text.length != 0) {
        [self addOptional];
    }
    
}
- (void)addOptional {
    CMProductDetailsViewController *productVC = (CMProductDetailsViewController *)[CMProductDetailsViewController initByStoryboard];
    productVC.codeName = _codeTextField.text;
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark - getset
- (NSMutableArray *)optionalArr {
    if (!_optionalArr) {
        _optionalArr = [NSMutableArray array];
    }
    return _optionalArr;
}

- (UIView *)errorView {
    if (!_errorView) {
        _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CMScreen_width(), CMScreen_height() - 109)];
        _errorView.backgroundColor = [UIColor cmMarkBlock];
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(CMScreen_width()/2-50, (CMScreen_height() - 109)/ 2-70, 100, 100);
        [bgBtn addTarget:self action:@selector(addCollectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgBtn setBackgroundImage:[UIImage imageNamed:@"add_option_home"] forState:UIControlStateNormal];
       // bgBtn.backgroundColor = [UIColor redColor];
        [_errorView addSubview:bgBtn];
        UILabel *contentNamelab = [[UILabel alloc] init];
        contentNamelab.center = CGPointMake(bgBtn.center.x+20, bgBtn.center.y + 100);
        contentNamelab.bounds = CGRectMake(0, 0, 250, 40);
        contentNamelab.textColor = [UIColor whiteColor];
        contentNamelab.font = [UIFont systemFontOfSize:14];
        contentNamelab.text = @"您还没有添加自选产品，请添加!";
        [_errorView addSubview:contentNamelab];
    }
    return _errorView;
}

- (NSMutableArray *)proictArr {
    if (_proictArr) {
        _proictArr = [NSMutableArray array];
    }
    return _proictArr;
}

- (void)addCollectBtnClick {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 2;
   
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
#pragma mark - 数据请求
//改成实时刷新了这个暂时不用了
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    //显示菊花
    _curTableView.hidden = YES;
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    __weak typeof(self) weakSelef = self;
    [CMRequestAPI cm_marketFetchCollectOnPage:page success:^(NSArray *collectArr, BOOL isPage) {
        [self hiddenProgressHUD];
        [_curTableView endRefresh];//结束刷新
        
        if (collectArr.count == 0) {
            [weakSelef.view addSubview:weakSelef.errorView];
        } else {
            _curTableView.hidden = NO;
        }
        
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.optionalArr removeAllObjects];
        }
        [self.optionalArr addObjectsFromArray:collectArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}



@end
