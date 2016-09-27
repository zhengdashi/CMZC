//
//  CMTradeDetailView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTradeDetailView.h"
#import "CMTradeDetailTableViewCell.h"
#import "CMFiveSpeedTableViewCell.h"
#import "SRWebSocket.h"


@interface CMTradeDetailView ()<UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate> {
    BOOL    _isPitch;
    
}

@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIView *btomView;//时间view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btomHeightLayoutConstraint;//view的高度
@property (weak, nonatomic) IBOutlet UIButton *fiveSpeedBtn;//五档btn
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;//明细
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewLayoutConstraint;//明细

@property (strong, nonatomic) SRWebSocket *webSocket;

@property (strong, nonatomic) NSMutableArray *detailArr; //明细arr
@property (strong, nonatomic) NSArray *fiveDataArr; //五档

@end

@implementation CMTradeDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    _isPitch = NO;
    _curTableView.scrollEnabled = NO;
    _curTableView.delegate = self;
    _curTableView.dataSource = self;
    [self contrastIsPitch];
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWebSocket) name:@"closeWebSocket" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fiveSpeedBtnClick) name:@"fiveSpeeButton" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailBtnClick) name:@"detailButton" object:nil];
    
}
- (void)setCode:(NSString *)code {
    _code = code;
    //测试需要。先注销了
    [self reconnect];
}
- (void)closeWebSocket {
    if (_webSocket) {
        self.webSocket.delegate = nil;
        [self.webSocket close];
    }
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isPitch) {
        return 10;
    } else {
        return 9;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isPitch) {
        CMTradeDetailTableViewCell *tradeCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeDetailTableViewCell"];
        if (!tradeCell) {
            tradeCell = [CMTradeDetailTableViewCell cell];
        }
        if (self.detailArr.count !=0) {
            if (self.detailArr.count <indexPath.row+1) {
                [tradeCell setContDataArr:@[] openPrict:0];
            } else {
                [tradeCell setContDataArr:self.detailArr[indexPath.row] openPrict:[_fiveDataArr[3] floatValue]];
                
            }           
        } else {
            tradeCell.contDataArr = @[];
        }
        
        return tradeCell;
    } else {
        CMFiveSpeedTableViewCell *speedCell = [tableView dequeueReusableCellWithIdentifier:@"CMFiveSpeedTableViewCell"];
        if (!speedCell) {
            speedCell = [CMFiveSpeedTableViewCell cell];
        }
        [speedCell cm_fiveSpeedIndex:indexPath.row contentArr:_fiveDataArr];
        return speedCell;
    }
}

#pragma mark - btnClick
//五档btn
- (void)fiveSpeedBtnClick{
    [self fiveContrast];
    [_curTableView reloadData];
}
//明细
- (void)detailBtnClick{
    [self detailContrast];
    [_curTableView reloadData];
    [CMRequestAPI cm_marketTransferContractDetail:_code success:^(NSArray *contractArr) {
        [self.detailArr removeAllObjects];
        [self.detailArr addObjectsFromArray:contractArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        MyLog(@"明细请求失败");
    }];
    
   // [_curTableView reloadData];
}
//判断是否选中
- (void)detailContrast {
    _btomView.hidden = NO;
    _topTableViewLayoutConstraint.constant = 0.0f;
    [_fiveSpeedBtn cm_setButtonAttr:_fiveSpeedBtn];
    [_detailBtn cm_setButtonAttrWithClick:_detailBtn];
    _isPitch = NO;
}
- (void)fiveContrast {
    _btomView.hidden = YES;
    _topTableViewLayoutConstraint.constant = -20.0f;
    [_fiveSpeedBtn cm_setButtonAttrWithClick:_fiveSpeedBtn];
    [_detailBtn cm_setButtonAttr:_detailBtn];
    _isPitch = YES;
}

- (void)contrastIsPitch {
    if (_isPitch == NO) {
        _btomView.hidden = YES;
        _topTableViewLayoutConstraint.constant = -20.0f;
        [_fiveSpeedBtn cm_setButtonAttrWithClick:_fiveSpeedBtn];
        [_detailBtn cm_setButtonAttr:_detailBtn];
        
    } else {
        _btomView.hidden = NO;
        _topTableViewLayoutConstraint.constant = 0.0f;
        [_fiveSpeedBtn cm_setButtonAttr:_fiveSpeedBtn];
        [_detailBtn cm_setButtonAttrWithClick:_detailBtn];
    }
    _isPitch =!_isPitch;
}
#pragma mark - setget
- (NSMutableArray *)detailArr {
    if (!_detailArr) {
        _detailArr = [NSMutableArray array];
    }
    return _detailArr;
}
//初始化
- (void)reconnect {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CMStringWithPickFormat(kWebSocket_url, [NSString stringWithFormat:@"product/market?pcode=%@",_code])]]];
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
    //[_webSocket send:_code];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    // self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSArray *dataArr = [message componentsSeparatedByString:@";"];
    NSArray  *contentArr;
    for (NSString *titleStr in dataArr) {
         contentArr = [titleStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    }
    _fiveDataArr = contentArr;
    
    
    [_curTableView reloadData];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    MyLog(@"-五档的web--%@",reply);
}
@end
