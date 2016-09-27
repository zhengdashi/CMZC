//
//  CMHistoryTradeView.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHistoryTradeView.h"
#import "CMDayTradeTableViewCell.h"
#import "CMTurnoverList.h"
#import "CLMNotDataView.h"


@interface CMHistoryTradeView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *historyDataArr;

@end


@implementation CMHistoryTradeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMHistoryTradeView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMHistoryTradeView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        
    }
    return self;
}
- (void)awakeFromNib {
    _curTableView.tableFooterView = [[UIView alloc] init];
    [self addRequestDataMeans];
    [_curTableView beginHeaderRefreshing];
    
}

#pragma mark - 数据请求
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
        NSInteger page = _historyDataArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_tradeInquireFetchHistoryDealOnePage:page success:^(NSArray *dataArr, BOOL isPage) {
        //结束刷新
        _curTableView.hidden = NO;
        [_curTableView endRefresh];
        kCurTableView_foot//根据返回回来的数据，判断footview的区别
        if (page == 1) {
            [self.historyDataArr removeAllObjects];
        }
        if (dataArr.count == 0) {
            [self notDataView];
            [_curTableView hideFooter];
        }
        [self.historyDataArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        //结束刷新
        [_curTableView endRefresh];
        [self showHubView:self
               messageStr:error.message
                     time:2];
    }];
    
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _historyDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CMDayTradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMRevokeTableViewCell"];
    if (!cell) {
        cell = [CMDayTradeTableViewCell cell];
    }
    [cell cm_dayTradeTurnoverList:_historyDataArr[indexPath.row]
                   tradeTableType:DayTradeTableTypeHistory];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMTurnoverList *turnover = _historyDataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cm_historyTradeViewIndex:)]) {
        [self.delegate cm_historyTradeViewIndex:turnover];
    }
    
}

#pragma mark - set get
- (NSMutableArray *)historyDataArr {
    if (!_historyDataArr) {
        _historyDataArr = [NSMutableArray array];
    }
    return _historyDataArr;
}
//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 200)];
    [dataView imageViewImageName:@"" markedWordsStr:@"历史暂无暂无成交" optionImageStr:@""];
    //dataView.delegate = self;
    if (![dataView superview]) {
        [self addSubview:dataView];
    }
    
    return dataView;
}
@end


































