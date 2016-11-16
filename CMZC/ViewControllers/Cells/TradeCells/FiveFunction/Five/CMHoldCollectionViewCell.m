//
//  CMHoldCollectionViewCell.m
//  CMZC
//
//  Created by 财猫 on 16/3/10.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHoldCollectionViewCell.h"
#import "CMMyHoldTableViewCell.h"
#import "CMHoldDetailsTableViewCell.h"
#import "CLMNotDataView.h"
#import "CMCommWebViewController.h"


@interface CMHoldCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,CMMyHoldTableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) NSMutableArray *holdDataArr;

@end


@implementation CMHoldCollectionViewCell

- (void)awakeFromNib {
     [super awakeFromNib];
    
    _curTableView.delegate = self;
    _curTableView.dataSource = self;
    _curTableView.tableFooterView = [[UIView alloc] init];
    
    [self addRequestDataMeans];
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
    //添加上提加载
    [_curTableView addFooterWithFinishBlock:^{
        NSInteger page = _holdDataArr.count / 2 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
    [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
        [CMRequestAPI cm_tradeInquireFetchHoldProductOnPage:page success:^(NSArray *dataArra, BOOL isPage) {
            [_curTableView endRefresh];
            kCurTableView_foot
            if (page == 1) {
                [self.holdDataArr removeAllObjects];
            }
            [self.holdDataArr addObjectsFromArray:dataArra];
            [_curTableView reloadData];
            
        } fail:^(NSError *error) {
            [_curTableView endRefresh];
            [self showHubView:self messageStr:error.message time:2];
        }];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:@"请检查网络" time:2];
    }];
    
    [CMRequestAPI cm_tradeFetchAccountionfSuccess:^(CMAccountinfo *account) {
        _tinfo = account;
        [_curTableView beginUpdates];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [_curTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        [_curTableView endUpdates];
    } fail:^(NSError *error) {
        MyLog(@"持有信息请求失败");
    }];
    
    
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.holdDataArr.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 246;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CMMyHoldTableViewCell *holdCell = [tableView dequeueReusableCellWithIdentifier:@"CMMyHoldTableViewCell"];
        if (!holdCell) {
            holdCell = [CMMyHoldTableViewCell cell];
        }
        holdCell.delegate = self;
        holdCell.tinfo = _tinfo;
        holdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return holdCell;
    } else {
        CMHoldDetailsTableViewCell *holdDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"CMHoldDetailsTableViewCell"];
        if (!holdDetailsCell) {
            holdDetailsCell = [CMHoldDetailsTableViewCell cell];
        }
        holdDetailsCell.hold = self.holdDataArr[indexPath.row-1];
        return holdDetailsCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CMHoldInquire *inquire = self.holdDataArr[indexPath.row-1];
        if ([self.delegate respondsToSelector:@selector(cm_holdCollectionViewInquire:)]) {
            [self.delegate cm_holdCollectionViewInquire:inquire];
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.holdDataArr.count ==0) {
        [_curTableView hideFooter];
        return [self notDataView];
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return view;
    }
}

//没有数据的view
- (UIView *)notDataView {
    CLMNotDataView *dataView = [[CLMNotDataView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), 300)];
    [dataView imageViewImageName:@"chiyou_trade" markedWordsStr:@"当前持有为空" optionImageStr:@""];
    //dataView.delegate = self;
    return dataView;
}
#pragma mark - CMMyHoldTableViewDelegate
- (void)cm_holdTableView:(CMMyHoldTableViewCell *)holdCell {
    self.block();
}


#pragma set get
- (NSMutableArray *)holdDataArr {
    if (!_holdDataArr) {
        _holdDataArr = [NSMutableArray array];
    }
    return _holdDataArr;
}

@end
