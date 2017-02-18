//
//  CMTopicReplyViewController.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/11.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMTopicReplyViewController.h"
#import "CMReplyTableViewCell.h"

@interface CMTopicReplyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation CMTopicReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        NSInteger page = self.dataArr.count / 5+1;
        [self requestListWithPageNo:page];
    }];
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    [self showDefaultProgressHUD];
    
    [CMRequestAPI cm_marketFetchReplyTopicid:self.topicId pageIndex:page success:^(NSArray *topicArr) {
        [self hiddenProgressHUD];
        [self.dataArr addObjectsFromArray:topicArr];
        if (topicArr.count >= 5) {
            [_curTableView resetNoMoreData];
        } else {
            [_curTableView noMoreData];
        }
        [_curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
    }];
}

#pragma mark - tableDele
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMReplyTableViewCell *replyCell = [tableView dequeueReusableCellWithIdentifier:@"CMReplyTableViewCell"];
    if (!replyCell) {
        replyCell = [[NSBundle mainBundle] loadNibNamed:@"CMReplyTableViewCell" owner:nil options:nil].firstObject;
    }
    replyCell.topicReplies = self.dataArr[indexPath.row];
    return replyCell;
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
