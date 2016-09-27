//
//  CMTrustDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTrustDetailsViewController.h"
#import "CMTrustTableViewCell.h"
#import "CMExchangeInquire.h"//详情页moder

@interface CMTrustDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation CMTrustDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMTrustTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMTrustTableViewCell" forIndexPath:indexPath];
    [cell cm_tradeDetailsTitleName:[CMExchangeInquire cm_exchangeTitNameIndex:indexPath.row trustType:CMExchangeTypeTrust]
                       detailsName:[CMExchangeInquire cm_exchangeTradeDayIndex:indexPath.row tradeDay:_tradeDay]
                             index:indexPath.row];
    return cell;
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
