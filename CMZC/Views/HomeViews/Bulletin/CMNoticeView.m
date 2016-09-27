//
//  CMNoticeView.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNoticeView.h"
#import "CMMediaOrNoticeTableViewCell.h"
#import "CMNoticeView.h"


@interface CMNoticeView ()
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *noticDataArr;

@end


@implementation CMNoticeView

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
        CMNoticeView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMNoticeView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    
}

- (void)awakeFromNib {
    [self addRequestDataMeans];
}

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
        NSInteger page = _noticDataArr.count /10+1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_trendsFetchNoticeDataPage:page success:^(NSArray *dataArr,BOOL isPage) {
        //结束刷新
        [_curTableView endRefresh];
        kCurTableView_foot//根据返回回来的数据，判断footview的区别
        if (page == 1) {
            [self.noticDataArr removeAllObjects];
        }
        [self.noticDataArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _noticDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMediaOrNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMMediaOrNoticeTableViewCell"];
    if (!cell) {
        cell = [CMMediaOrNoticeTableViewCell initByNibForClassName];
    }
    cell.notice = _noticDataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出来webURL的链接
    if ([self.delegate respondsToSelector:@selector(cm_noticeViewSendNoticeModel:)]) {
        [self.delegate cm_noticeViewSendNoticeModel:_noticDataArr[indexPath.row]];//传入webURL
    }
    
}

#pragma mark - set get 
- (NSMutableArray *)noticDataArr {
    if (!_noticDataArr) {
        _noticDataArr = [NSMutableArray array];
    }
    return _noticDataArr;
}


@end

















