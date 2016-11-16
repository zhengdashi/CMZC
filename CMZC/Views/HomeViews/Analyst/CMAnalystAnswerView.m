//
//  CMAnalystAnswerView.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAnalystAnswerView.h"
#import "CMAnswerTableViewCell.h"
#import "CMAnswerHeaderView.h"
#import "CMAnalystAnswer.h"


@interface CMAnalystAnswerView ()<UITableViewDataSource,UITableViewDelegate,CMAnswerHeaderViewDelegate> {
   // BOOL _isAnimating;
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (nonatomic,assign) CGRect selfOriginalRect;
@property (strong, nonatomic) NSMutableArray *answerListArr;
@property (nonatomic,assign) NSInteger sectionIndex;
@end


@implementation CMAnalystAnswerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [_curTableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMAnalystAnswerView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMAnalystAnswerView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _selfOriginalRect = self.frame;
        //监听滑动表的的方法。
        [_curTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}
- (void)awakeFromNib {
     [super awakeFromNib];
    _curTableView.tableFooterView = [[UIView alloc] init];
    
}
#pragma mark - 数据请求

- (void)setAnalystId:(NSInteger)analystId {
    _analystId = analystId;
    [self addRequestDataMeans];
}

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
        NSInteger page = self.answerListArr.count / 10 + 1;
        //数组中没有数据。等有数据了。在弄
        [self requestListWithPageNo:page];
    }];
    
}


//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_homeFetchAnswerLsitAnalystId:_analystId pageIndex:page success:^(NSArray *analystArr, BOOL isPage) {
        [_curTableView endRefresh];//结束刷新
        if (analystArr.count > 0) {
            _curTableView.hidden = NO;
        } else {
            [self showHubView:self messageStr:@"该分析师暂时没有回答" time:2];
            
        }
        //区分显示教view
        kCurTableView_foot
        if (page == 1) {
            [self.answerListArr removeAllObjects];
        }
        [self.answerListArr addObjectsFromArray:analystArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];//结束刷新
        [self showHubView:self messageStr:error.message time:2];
    }];
    
}


#pragma mark- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    if (_isAnimating) {
        return;
    }
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
        self.block(CMAnalystAnswerBlockNew);
        
    }
}
- (void)showShrink {
    self.block(CMAnalystAnswerTypeOld);
    
}
#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _answerListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CMAnalystAnswer *analyst = _answerListArr[section];
    return analyst.repliseArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMAnalystAnswer *answer = _answerListArr[indexPath.section];
    CMAnalystViewpoint *point = answer.repliseArr[indexPath.row];
    CGFloat height = [point.content getHeightIncomingWidth:CMScreen_width() - 43 incomingFont:13];
    return height + 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CMAnalystAnswer *analyst = _answerListArr[section];
    
    return 70 + analyst.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMAnswerTableViewCell *answerCell = [tableView dequeueReusableCellWithIdentifier:@"CMAnswerTableViewCell"];
    if (!answerCell) {
        answerCell = [CMAnswerTableViewCell cell];
    }
    CMAnalystAnswer *point = _answerListArr[indexPath.section];
    answerCell.point = point.repliseArr[indexPath.row];
    return answerCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CMAnswerHeaderView *anserHeader = [CMAnswerHeaderView initByNibForClassName];
    anserHeader.delegate = self;
    anserHeader.analyst = _answerListArr[section];
    anserHeader.index = section;
    return anserHeader;
}
#pragma mark - CMAnswerHeaderViewDelegate
- (void)cm_answerHeaderViewTopicId:(NSInteger)topicId indexPath:(NSInteger)index{
    self.topicBlock(topicId);
    _sectionIndex = index;//36241
}


#pragma mark - set get
- (NSMutableArray *)answerListArr {
    if (!_answerListArr) {
        _answerListArr = [NSMutableArray array];
    }
    return _answerListArr;
}

//返回评论数据 刷新表格
- (void)setReplyArr:(NSArray *)replyArr {
    
    CMAnalystAnswer *analyst = _answerListArr[_sectionIndex];
    [analyst.repliseArr addObjectsFromArray:replyArr];
    //刷新区显示数据
    [_curTableView beginUpdates];
    [_curTableView reloadSections:[NSIndexSet indexSetWithIndex:_sectionIndex] withRowAnimation:UITableViewRowAnimationTop];
    [_curTableView endUpdates];
}

@end












