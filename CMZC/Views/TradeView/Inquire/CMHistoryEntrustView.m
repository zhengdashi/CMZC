//
//  CMHistoryEntrustView.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHistoryEntrustView.h"
#import "CMRevokeTableViewCell.h"
#import "CMTradeDayAuthorize.h"
#import "CLMNotDataView.h"


@interface CMHistoryEntrustView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) NSMutableArray *historyDataArr;

@end

@implementation CMHistoryEntrustView

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
        CMHistoryEntrustView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMHistoryEntrustView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
      //  [self addRequestDataMeans];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    _curTableView.delegate = self;
    [self addRequestDataMeans];
    [_curTableView beginHeaderRefreshing];
}

//请求数据
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    _curTableView.hidden = YES;
    //显示菊花    //添加下拉刷新
    [_curTableView addHeaderWithFinishBlock:^{
        [self requestListWithPageNo:1];
    }];
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = _historyDataArr.count / 10 +1;
        [self requestListWithPageNo:page];
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    //还是没有数据。哎
    [CMRequestAPI cm_tradeInquireFetchHistoryTrusetOnPage:page success:^(NSArray *dataArr, BOOL isPage) {
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
        _curTableView.hidden = NO;
        //结束刷新
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _historyDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMRevokeTableViewCell *revokeCell = [tableView dequeueReusableCellWithIdentifier:@"CMRevokeTableViewCell"];
    if (!revokeCell) {
        revokeCell = [CMRevokeTableViewCell cell];
    }
    revokeCell.authorize = _historyDataArr[indexPath.row];
    return revokeCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMTradeDayAuthorize *tradeDay = _historyDataArr[indexPath.row];
    self.historyEntrustBlock(tradeDay);
    
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
    [dataView imageViewImageName:@"nil" markedWordsStr:@"历史暂无委托" optionImageStr:@""];
    //dataView.delegate = self;
    if (![dataView superview]) {
        [self addSubview:dataView];
    }
    
    return dataView;
}

@end



















