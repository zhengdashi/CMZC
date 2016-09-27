//
//  CMMediaNewsView.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMediaNewsView.h"
#import "CMMediaOrNoticeTableViewCell.h"
#import "CMMediaTableViewCell.h"

@interface CMMediaNewsView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *mediaDataArr;

@end


@implementation CMMediaNewsView

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
        CMMediaNewsView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMMediaNewsView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [self showHubTacit];
    [self addRequestDataMeans];
    
}

- (void)layoutIfNeeded {
    [self layoutIfNeeded];
    //数据请求
    
    
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
        NSInteger page = _mediaDataArr.count / 10 +1;
        [self requestListWithPageNo:page];
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [CMRequestAPI cm_trendsFetchMediaCoverDataPage:page pageSize:10 success:^(NSArray *dataArr,BOOL isPage) {
        [self hideHubTacit];
        [_curTableView endRefresh];
        kCurTableView_foot//根据返回回来的数据，判断footview的区别
        if (page == 1) {
            [self.mediaDataArr removeAllObjects];
        }
        if (dataArr.count >0) {
            //结束刷新
            _curTableView.hidden = NO;
        }
        [self.mediaDataArr addObjectsFromArray:dataArr];
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [_curTableView endRefresh];
        [self showHubView:self messageStr:error.message time:2];
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mediaDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMMediaTableViewCell"];
    if (!cell) {
        cell = [CMMediaTableViewCell initByNibForClassName];
    }
    //没数据先注销
    cell.mediaNews = self.mediaDataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMMediaNews *media = _mediaDataArr[indexPath.row];
    NSLog(@"..%@",media.link);
    //取出来webURL的链接
    if ([self.delegate respondsToSelector:@selector(cm_mediaNewsViewSendWebURL:)]) {
        [self.delegate cm_mediaNewsViewSendWebURL:media.link];//传入webURL
    }
    
}
#pragma mark - set get
- (NSMutableArray *)mediaDataArr {
    if (!_mediaDataArr) {
        _mediaDataArr = [NSMutableArray array];
    }
    return _mediaDataArr;
}

@end






























