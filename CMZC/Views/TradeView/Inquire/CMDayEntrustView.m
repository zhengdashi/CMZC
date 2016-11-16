//
//  CMDayEntrustView.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMDayEntrustView.h"
#import "CMRevokeTableViewCell.h"
#import "CMTradeDayAuthorize.h"
#import "CLMNotDataView.h"


@interface CMDayEntrustView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *dataListArr;

@end

@implementation CMDayEntrustView

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
        CMDayEntrustView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMDayEntrustView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        
    }
    return self;
}

//请求数据
- (void)awakeFromNib {
    [super awakeFromNib];
    _curTableView.tableFooterView = [[UIView alloc] init];
    [self addRequestDataMeans];
   
    
}

#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    _curTableView.hidden = YES;
    //显示菊花
    [self requestListWithPageNo:1];
    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = self.dataListArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    //刷新令牌
    [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
        [CMRequestAPI cm_tradeInquireFetchDayTrusetOnPage:page success:^(NSArray *dataArr, BOOL isPage) {
            //结束刷新
            _curTableView.hidden = NO;
            [_curTableView endRefresh];
            kCurTableView_foot//根据返回回来的数据，判断footview的区别
            if (page == 1) {
                [self.dataListArr removeAllObjects];
            }
            if (dataArr.count == 0) {
                [self notDataView];
                [_curTableView hideFooter];
            }
            [self.dataListArr addObjectsFromArray:dataArr];
            [_curTableView reloadData];
        } fail:^(NSError *error) {
            _curTableView.hidden = NO;
            //结束刷新
            [_curTableView endRefresh];
            [self showHubView:self
                   messageStr:error.message
                         time:2];
        }];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:@"请检查网络" time:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMRevokeTableViewCell *revokeCell = [tableView dequeueReusableCellWithIdentifier:@"CMRevokeTableViewCell"];
    if (!revokeCell) {
        revokeCell = [CMRevokeTableViewCell cell];
    }
    revokeCell.authorize = _dataListArr[indexPath.row];
    return revokeCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMTradeDayAuthorize *tradeDay = _dataListArr[indexPath.row];
    self.dayEntrBlock(tradeDay);
    
}

#pragma mark - set get
- (NSMutableArray *)dataListArr {
    if (!_dataListArr) {
        _dataListArr = [NSMutableArray array];
    }
    return _dataListArr;
}
//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 200)];
    [dataView imageViewImageName:@"" markedWordsStr:@"今日暂无委托" optionImageStr:@""];
    //dataView.delegate = self;
    if (![dataView superview]) {
        [self addSubview:dataView];
    }
    
    return dataView;
}

@end



















