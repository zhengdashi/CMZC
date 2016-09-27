//
//  CMRevokeCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMRevokeCollectionViewCell.h"
#import "CMRevokeTableViewCell.h"
#import "CLMNotDataView.h"
#import "CMRemoveTableViewCell.h"
#import "CMAlerView.h"
#import "CMMayRemove.h"

@interface CMRevokeCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate,CMAlerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIButton *revokeBut;//撤单按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *butViewBottomLayout;//view的下约束，控制它的隐藏状态
@property (nonatomic,assign) NSInteger codeNumber;
@property (strong, nonatomic) NSMutableArray *revokeDataArr;
@property (nonatomic,copy) CMTradeToolModes *toolModes;
@property (strong, nonatomic) CLMNotDataView *dataView;

@end



@implementation CMRevokeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _curTableView.delegate = self;
    _curTableView.dataSource = self;
    _curTableView.tableFooterView = [[UIView alloc] init];
    [self addRequestDataMeans];
    
}
#pragma mark - btn click

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
        NSInteger page = self.revokeDataArr.count /10+1;
        [self requestListWithPageNo:page];
    }];
}
- (void)cm_revokeCollectionRequest {
    if (self.revokeDataArr.count == 0) {
        [_curTableView beginHeaderRefreshing];
    }
}

//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    
    [CMRequestAPI cm_tradeinquireFetchRemoveListPage:page success:^(NSArray *removeArr, BOOL isPage) {
        [_curTableView endRefresh];
        kCurTableView_foot
        if (page == 1) {
            [self.revokeDataArr removeAllObjects];
        }
        //dataArr = nil;
        if (removeArr.count>0) {
            _curTableView.hidden = NO;
            [self.dataView dismiss];
        } else {
            [self addSubview:self.dataView];
        }
        [self.revokeDataArr addObjectsFromArray:removeArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
    
}


//撤单按钮的方法
- (IBAction)revokeBtnClick:(UIButton *)sender {
     _butViewBottomLayout.constant = -40;
    CMAlerView *aler = [[CMAlerView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height()) titleName:@"撤单" certain:@"撤单" delegate:self tradeTool:_toolModes];
    [aler show];
    
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //这里没有数据 需要来数据了在做
    return self.revokeDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMRemoveTableViewCell *revokeCell = [tableView dequeueReusableCellWithIdentifier:@"CMRemoveTableViewCell"];
    if (!revokeCell) {
        revokeCell = [CMRemoveTableViewCell cell];
    }
    revokeCell.remove = self.revokeDataArr[indexPath.row];
    return revokeCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //这里需要做判断，判断是否可以撤单，因为现在么有数据，线就这样展示效果。等又数据了再改
    CMMayRemove *authorize = self.revokeDataArr[indexPath.row];
    _codeNumber = [authorize.orderNum integerValue];
    _toolModes = [[CMTradeToolModes alloc] init];
    _toolModes.code = authorize.pCode;
    _toolModes.name = authorize.pName;
    _toolModes.price = authorize.orderPrice;
    _toolModes.number = CMStringWithFormat([authorize.orderVolume integerValue]-[authorize.volume integerValue]);
    
//    CMAlerView *aler = [[CMAlerView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height()) titleName:@"撤单" certain:@"撤单" delegate:self tradeTool:toolModes];
//    [aler show];
    
    
    _codeNumber = [authorize.orderNum integerValue];
    if (_butViewBottomLayout.constant ==0) {
        [UIView animateWithDuration:1 animations:^{
            _butViewBottomLayout.constant = -40;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _butViewBottomLayout.constant = 0;
        }];
    }
    
}
- (void)cm_cmalerView:(CMAlerView *)alerView willDismissWithButtonIndex:(NSInteger)btnIndex {
    if (btnIndex == 1) {
        [CMRequestAPI cm_tradeinquireFetchRemoveOrderNumber:_codeNumber success:^(BOOL isWin) {
            if (isWin) {
                [self showHubView:self messageStr:@"撤单成功" time:2];
                [_curTableView beginHeaderRefreshing];
            } else {
                [self showHubView:self messageStr:@"撤单失败" time:2];
            }
        } fail:^(NSError *error) {
            [self showHubView:self messageStr:error.message time:2];
        }];
    }
    
}

- (CLMNotDataView *)dataView {
    if (!_dataView) {
        _dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 50, CMScreen_width(), 300)];
        [_dataView imageViewImageName:@"chedan_trade" markedWordsStr:@"暂无单可撤" optionImageStr:@""];
    }
    return _dataView;
}

//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 300)];
    [dataView imageViewImageName:@"chedan_trade" markedWordsStr:@"暂无单可撤" optionImageStr:@""];
    //dataView.delegate = self;
    return dataView;
}
#pragma mark - set get
- (NSMutableArray *)revokeDataArr {
    if (!_revokeDataArr) {
        _revokeDataArr = [NSMutableArray array];
    }
    return _revokeDataArr;
}


@end

















