//
//  CMAnalystPointView.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnalystPointView.h"
#import "CMPointTableViewCell.h"
#import "CMAnalystPoint.h"
#import "NSString+CMExtensions.h"


@interface CMAnalystPointView ()<UITableViewDataSource,UITableViewDelegate> {
    CGRect  _selfOriginalRect;
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *pointDataArr;

@end


@implementation CMAnalystPointView

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
        CMAnalystPointView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMAnalystPointView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        [_curTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)setAnalystId:(NSInteger)analystId {
    _analystId = analystId;
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
        NSInteger page = _pointDataArr.count / 10 + 1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_homeFetchAnswerPointAnalystId:_analystId pcode:0  pageIndex:page success:^(NSArray *pointArr, BOOL isPage) {
        [_curTableView endRefresh];//结束刷新
       
        if (pointArr.count > 0) {
            _curTableView.hidden = NO;
        } else {
            [self showHubView:self messageStr:@"该分析师暂时没有观点" time:2];
        }
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.pointDataArr removeAllObjects];
        }
        [self.pointDataArr addObjectsFromArray:pointArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];//结束刷新
        [self showHubView:self messageStr:error.message time:2];
    }];
    
}


#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (_isAnimating) {
        return;
    }
    //用来判断上滑或者下拉
    CGPoint oldContentOffSet = [change[@"old"] CGPointValue];
    CGPoint newContentOffSet = [change[@"new"] CGPointValue];
    if (_curTableView.contentOffset.y <=0) {
        if (newContentOffSet.y == 0) {
            return;
        }
        [self showExpand];
    } else {
        if (oldContentOffSet.y > 0 && newContentOffSet.y > 0 ) {
            return;
        }
        [self showShrink];
    }
}

- (void)showExpand {
    if (!CGRectEqualToRect(self.frame, _selfOriginalRect)) {
        _isAnimating = YES;
        self.block(CMAnalystPointTypeNew);
    }
}
- (void)showShrink {
    self.block(CMAnalystPointTypeOld);
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pointDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 98;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMPointTableViewCell *pointCell = [tableView dequeueReusableCellWithIdentifier:@"CMPointTableViewCell"];
    if (!pointCell) {
        pointCell = [CMPointTableViewCell initByNibForClassName];
    }
    
    pointCell.point = self.pointDataArr[indexPath.row];
    return pointCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMAnalystPoint *point = self.pointDataArr[indexPath.row];
    self.pointBlock(point);
}
#pragma mark - setGet
- (NSMutableArray *)pointDataArr {
    if (!_pointDataArr) {
        _pointDataArr = [NSMutableArray array];
    }
    return _pointDataArr;
}


@end


























