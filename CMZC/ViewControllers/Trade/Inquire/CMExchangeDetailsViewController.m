//
//  CMExchangeDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMExchangeDetailsViewController.h"
#import "CMTradeDetailsTableViewCell.h"
#import "CMExchangeInquire.h"//详情页moder

@interface CMExchangeDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation CMExchangeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark -UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //需要传入一个数据。来确定它的选择类型。
    
    CMTradeDetailsTableViewCell *tradeDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"CMTradeDetailsTableViewCell" forIndexPath:indexPath];
    tradeDetailsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tradeDetailsCell cm_tradeDetailsTitleName:[CMExchangeInquire cm_exchangeTitNameIndex:indexPath.row trustType:CMExchangeTypeTurnover]
                                   detailsName:[CMExchangeInquire cm_exchangeTurnoverIndex:indexPath.row turnover:_turnover]];
    
    return tradeDetailsCell;
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
