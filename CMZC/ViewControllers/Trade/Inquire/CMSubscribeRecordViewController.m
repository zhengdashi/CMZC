//
//  CMSubscribeRecordViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeRecordViewController.h"
#import "CMRecordTableViewCell.h"


@interface CMSubscribeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation CMSubscribeRecordViewController

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
        
        
    }];
    
    
}
//数据请求
- (void)requestListWithPageNo:(NSInteger)page {
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMRecordTableViewCell *recordCell = [tableView dequeueReusableCellWithIdentifier:@"CMRecordTableViewCell" forIndexPath:indexPath];
    
    recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return recordCell;
}


#pragma mark -
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
