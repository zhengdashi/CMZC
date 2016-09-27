//
//  CMChartTableViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/15.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMChartTableViewCell.h"
#import "EverChart.h"
#import "CMTradeDetailView.h"
#import "SRWebSocket.h"
#import "CMLineView.h"
#import "CMTimer.h"


@interface CMChartTableViewCell () {
    BOOL _isFirst;
    NSString *_earlyMorning;
}

@property (weak, nonatomic) IBOutlet UIView *fiveSpeedView;//五档明细
@property (strong, nonatomic) EverChart *fenshiChart;
@property (weak, nonatomic) IBOutlet UIView *btomView;
@property (strong, nonatomic) CMTradeDetailView *tradeDetail;
@property (strong, nonatomic) SRWebSocket *webSocket;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (strong, nonatomic) CMLineView *lineView;

@property (strong, nonatomic) CMTimer *timer;


@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView; //scroll

@property (weak, nonatomic) IBOutlet UIView *sixBtnView; //有五档 和明细按钮
@property (weak, nonatomic) IBOutlet UIView *sixBtomView; //下方指示条view
@property (weak, nonatomic) IBOutlet UIButton *fiveSpeedBtn; //五档
@property (weak, nonatomic) IBOutlet UIButton *detailsBtn; //明细
@property (weak, nonatomic) IBOutlet UIView *timeShareChart;//显示分时的view
@property (weak, nonatomic) IBOutlet UIView *fiveDetailsView; //五档明细



@property (weak, nonatomic) IBOutlet UIView *fourBtnView; //没有五档和明细按钮
@property (weak, nonatomic) IBOutlet UIView *fourBtomView; //下方指示条view
@property (weak, nonatomic) IBOutlet UIView *lineGraphView; //日k



@end


@implementation CMChartTableViewCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    // Initialization code
    
    //*****  为了测试先注销   ******//
    _tradeDetail = [CMTradeDetailView initByNibForClassName];
    [_fiveDetailsView addSubview:_tradeDetail];
   [self setUp];
    [self showHubTacit];
//    关闭定时器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTimer) name:@"closeWebSocket" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isRequest:) name:@"isFirstTime" object:nil];
}
- (void)isRequest:(NSNotification *)sender {
    
    NSDictionary *infDict = sender.userInfo;
    _earlyMorning = infDict[@"earlyMorning"];
    //开启定时器请求数据
    [self openTimer];
}
#pragma mark - sixView的方法
//六个按钮的方法
- (IBAction)timeSharingBtnClick:(UIButton *)sender {
    NSInteger btnTage = sender.tag;
    switch (btnTage) {
        case 500://分时
            [self timeSharing];
            break;
        case 501://日K
            [self dayKChart];
            break;
        case 502: //周K
            [self weekKChart];
            break;
        case 503: //月K
            [self monthKChart];
            break;
        case 504: //五档
            [self fiveSpeeButton];
            break;
        case 505: //明细
            [self detailButton];
            break;
        default:
            break;
    }
}
//分时按钮
- (void)timeSharing {
    _fourBtnView.hidden = YES;
    [self scrollRectToViseIndex:0];
}
//日k
- (void)dayKChart {
    //下边view的显示
//    _sixBtnView.hidden = YES;
    _fourBtnView.hidden = NO;
    [self sixBtomViewSenderIndex:1];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2101];
    
}
//周K
- (void)weekKChart {
    _fourBtnView.hidden = NO;
    [self sixBtomViewSenderIndex:2];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2102];
}
//月K
- (void)monthKChart {
    _fourBtnView.hidden = NO;
    [self sixBtomViewSenderIndex:3];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2103];
}
//五档
- (void)fiveSpeeButton {
    _fiveSpeedBtn.backgroundColor = [UIColor cmtabBarGreyColor];
    _detailsBtn.backgroundColor = [UIColor cmBlockColor];
    //发送五档的通知
    [_tradeDetail fiveSpeedBtnClick];
    
}
//明细
- (void)detailButton {
    _fiveSpeedBtn.backgroundColor = [UIColor cmBlockColor];
    _detailsBtn.backgroundColor = [UIColor cmtabBarGreyColor];
    [_tradeDetail detailBtnClick];
    //发送明细的通知
//#warning 这个地方崩溃。找方法代替下
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"detailButton" object:self];
}
- (void)sixBtomViewSenderIndex:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
        _fourBtomView.frame = CGRectMake(CMScreen_width()/4*index, 38, CMScreen_width()/4, 2);
    }];
}

#pragma mark - fourView的方法
//五个按钮的方法
- (IBAction)fourTimeSharingBtnClick:(UIButton *)sender {
    NSInteger btnTage = sender.tag;
    switch (btnTage) {
        case 400://分时
            [self fourTimeSharing];
            break;
        case 401://日K
            [self fourDayKChart];
            break;
        case 402: //周K
            [self fourWeekKChart];
            break;
        case 403: //月K
            [self fourMonthKChart];
            break;
        default:
            break;
    }
    
}
//分时
- (void)fourTimeSharing {
    _fourBtnView.hidden = YES;
    [self scrollRectToViseIndex:0];
}
//日K
- (void)fourDayKChart {
    
    [self sixBtomViewSenderIndex:1];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2101];
}
//周K
- (void)fourWeekKChart {
    [self sixBtomViewSenderIndex:2];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2102];
}
//月K
- (void)fourMonthKChart {
     [self sixBtomViewSenderIndex:3];
    [self scrollRectToViseIndex:1];
    [self initLineViewBtnTag:2103];
}
- (void)scrollRectToViseIndex:(NSInteger)index {
    CGRect visibleRect = CGRectMake(CGRectGetWidth(_curScrollView.frame) * index , 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [_curScrollView scrollRectToVisible:visibleRect animated:NO];
    
}
//k线图
- (void)initLineViewBtnTag:(NSInteger)tag {
    
    [_lineGraphView addSubview:self.lineView];
    
    switch (tag) {
        case 2101:
            self.lineView.req_type = @"d";
            self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineDayURL,_code];
            break;
        case 2102:
            self.lineView.req_type = @"w";
            self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineWeekURL,_code];
            break;
        default:
            self.lineView.req_type = @"m";
            self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineMonthURL,_code];
            break;
    }
    
    [self.lineView start];
    [self.lineView update];
}


#pragma mark - 没有改变之前的方法
//开启一个定时器
- (void)openTimer {
    //开启一个定时器
    _timer = [[CMTimer alloc] initTimerInterval:10];
    __weak typeof(self) weakSelef = self;
    _timer.timerMinblock = ^() {
       [weakSelef requestMinuteMarket];
    };
}

- (void)closeTimer {
    [_timer close];
    //关闭后要将timer置为空
    _timer = nil;
}


- (void)setCode:(NSString *)code {
    _code = code;
    _tradeDetail.code = code;
    //[self requestMinuteMarket];
}

- (void)requestMinuteMarket {
    [CMRequestAPI cm_marketTransferMinutePcode:_code deteTime:@"" success:^(NSArray *timeArr) {
        [self hideHubTacit];
        [self renderChart:timeArr];
    } fail:^(NSError *error) {
        MyLog(@"分时行情请求失败");
    }];
}


- (void)setUp {
    self.fenshiChart = [[EverChart alloc] initWithFrame:CGRectMake(-20, 0, CMScreen_width() - (CMScreen_width()/6*2)+50, 218)];
    [self.timeShareChart addSubview:_fenshiChart];
    //划线
    [self initFenShiChart];
    
    
    
}
//初始化分视图
-(void)initFenShiChart {
    NSMutableArray *padding = [NSMutableArray arrayWithObjects:@"0",@"0",@"20",@"5", nil];
    [self.fenshiChart setPadding:padding];//设置内边距
    NSMutableArray *secs = [[NSMutableArray alloc] init];
    [secs addObject:@"2"];//设置上下两部分的比例
    [secs addObject:@"1"];
    
    [self.fenshiChart addSections:2 withRatios:secs];
    [[[self.fenshiChart sections] objectAtIndex:0] addYAxis:0];
    [[[self.fenshiChart sections] objectAtIndex:1] addYAxis:0];
    
    [self.fenshiChart getYAxis:0 withIndex:0].tickInterval = 4;//设置虚线数量
    [self.fenshiChart getYAxis:1 withIndex:0].tickInterval = 2;
    
    NSMutableArray *series = [[NSMutableArray alloc] init];
    
    NSMutableArray *secOne = [[NSMutableArray alloc] init];
    NSMutableArray *secTwo = [[NSMutableArray alloc] init];
    
    //均价
    NSMutableDictionary *serie = [[NSMutableDictionary alloc] init];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    [serie setObject:kFenShiAvgNameLine forKey:@"name"]; //用于标记线段名称
    [serie setObject:@"" forKey:@"label"]; //当选中时，Label 要显示的名称
    //[serie setObject:data forKey:@"data"]; //均线数据 （当获取到实时数据后，就是对此字段赋值；然后实时刷新UI）
    [serie setObject:kFenShiLine forKey:@"type"]; //标记当前绘图类型
    [serie setObject:@"0" forKey:@"yAxisType"]; //标记当前Y轴类型
    [serie setObject:@"0" forKey:@"section"]; //标记当前所属部分
    [serie setObject:kFenShiAvgColor forKey:@"color"]; //均价线段的颜色
    [series addObject:serie];
    [secOne addObject:serie];
    
    
    //实时价
    serie = [[NSMutableDictionary alloc] init];
    data = [[NSMutableArray alloc] init];
    [serie setObject:kFenShiNowNameLine forKey:@"name"];
    [serie setObject:@"" forKey:@"label"];
    [serie setObject:data forKey:@"data"];
    [serie setObject:kFenShiLine forKey:@"type"];
    [serie setObject:@"1" forKey:@"yAxisType"];
    [serie setObject:@"0" forKey:@"section"];
    [serie setObject:kFenShiNowColor forKey:@"color"];
    [series addObject:serie];
    [secOne addObject:serie];
    
    
    //VOL
    serie = [[NSMutableDictionary alloc] init];
    data = [[NSMutableArray alloc] init];
    [serie setObject:kFenShiVolNameColumn forKey:@"name"];
    [serie setObject:@"" forKey:@"label"];
    [serie setObject:data forKey:@"data"];
    [serie setObject:kFenShiColumn forKey:@"type"];
    [serie setObject:@"1" forKey:@"section"];
    [serie setObject:@"0" forKey:@"decimal"]; //保留几位小数
    [series addObject:serie];
    [secTwo addObject:serie];
    
    [self.fenshiChart setSeries:series];
    
    [[[self.fenshiChart sections] objectAtIndex:0] setSeries:secOne];
    [[[self.fenshiChart sections] objectAtIndex:1] setSeries:secTwo];
    
    
    
    
}

/**
 *  配置数据源，生成分时图
 *
 *  @param responseObject 数据参数
 */

- (void)renderChart:(NSArray *)responseObject {
    [self.fenshiChart reset];//重置图版
    [self.fenshiChart clearData];//清空划线数据
    [self.fenshiChart clearCategory];//清空下边的数据
    
    NSMutableArray *data1 =[[NSMutableArray alloc] init];
    NSMutableArray *data2 =[[NSMutableArray alloc] init];
    NSMutableArray *data3 =[[NSMutableArray alloc] init];
    
    NSMutableArray *category =[[NSMutableArray alloc] init];
    
//    NSArray *listArray = responseObject[@"newList"];
//    NSArray *closeYesterday = responseObject[@"yesterdayEndPri"];//昨日收盘价
    NSString *closeYesterday = _earlyMorning;
    for(int i = 0;i<responseObject.count;i++){
        
        NSArray *dicArr = responseObject[i];
        [category addObject:dicArr[0]]; //当前时间
        
//        NSString *jun
        NSArray *item1 = @[dicArr[7],closeYesterday]; //均价
        NSArray *item2 = @[dicArr[1],closeYesterday]; //实时价格  没给。我就写了一个成交价格
        NSString *volume;
        if (i==0) {
           volume  = [NSString stringWithFormat:@"%d",1]; //成交量
        } else if (i == 1) {
            volume  = [NSString stringWithFormat:@"%d",2]; //成交量
        } else {
            volume  = [NSString stringWithFormat:@"%d",[dicArr[5] intValue]];
        }
        
        NSArray *item3 = @[volume,dicArr[1],closeYesterday];
        
        [data1 addObject:item1];
        [data2 addObject:item2];
        [data3 addObject:item3];
        
    }
    
    //上面构造数据的方法，可以按照需求更改；数据源构建完毕后，赋值到分时图上
    [self.fenshiChart appendToData:data1 forName:kFenShiAvgNameLine];
    [self.fenshiChart appendToData:data2 forName:kFenShiNowNameLine];
    [self.fenshiChart appendToData:data3 forName:kFenShiVolNameColumn];
    
    //当被选中时，要显示的数据or文字
    [self.fenshiChart appendToCategory:category forName:kFenShiAvgNameLine];
    [self.fenshiChart appendToCategory:category forName:kFenShiNowNameLine];
    
    //重绘图表
    [self.fenshiChart setNeedsDisplay];
}

#pragma mark - btnClick
- (IBAction)changeBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _btomView.frame = CGRectMake(CGRectGetMinX(sender.frame), CGRectGetHeight(sender.frame), CGRectGetWidth(sender.frame), 2);
    }];
    NSInteger index = sender.tag;
    CGRect visibleRect;
    switch (index) {
        case 2100:
            visibleRect = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            break;
        default:
        {
            visibleRect = CGRectMake(CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            [_lineGraphView addSubview:self.lineView];
            
            switch (index) {
                case 2101:
                    self.lineView.req_type = @"d";
                    self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineDayURL,_code];
                    break;
                case 2102:
                    self.lineView.req_type = @"w";
                    self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineWeekURL,_code];
                    break;
                default:
                    self.lineView.req_type = @"m";
                    self.lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineMonthURL,_code];
                    break;
            }
            
            [self.lineView start];
            [self.lineView update];
        }
            break;
    }
    [_scrollView scrollRectToVisible:visibleRect animated:YES];
    
}

- (CMLineView *)lineView {
    if (!_lineView) {
        _lineView = [[CMLineView alloc] init];
        if (iPhone5) {
            _lineView.frame = CGRectMake(-10, 0, CMScreen_width(), 218);
        } else {
            _lineView.frame = CGRectMake(-40, 0, CMScreen_width(), 218);
        }
       
        //_lineView.req_type = @"d";//传入数值是什么时间的k
        //_lineView.req_freq = [NSString stringWithFormat:@"%@%@",kMProductKlineDayURL,_code];//默认日k
        _lineView.kLineWidth = 5;
        _lineView.kLinePadding = 0.5;
        
    }
    return _lineView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end





























