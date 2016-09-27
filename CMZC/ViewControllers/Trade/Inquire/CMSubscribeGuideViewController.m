//
//  CMSubscribeGuideViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/12.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeGuideViewController.h"
#import "CMSubscribeGuideTableViewCell.h"


@interface CMSubscribeGuideViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_titleArr;
    NSArray *_detailsArr;
}

@end

@implementation CMSubscribeGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //组织数据源
    [self organizeTheDataSource];
    
    
    
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *details = _detailsArr[indexPath.row];
    CGFloat height = [details getHeightIncomingWidth:CMScreen_width() - 164 incomingFont:13];
    
    return height + 28;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMSubscribeGuideTableViewCell *subscribeCell = [tableView dequeueReusableCellWithIdentifier:@"CMSubscribeGuideTableViewCell" forIndexPath:indexPath];
    [subscribeCell cm_subscribeGuideTitleName:_titleArr[indexPath.row]
                                   detailsStr:_detailsArr[indexPath.row]];
    return subscribeCell;
}

#pragma mark - 
//组织数据源
- (void)organizeTheDataSource {
     _titleArr = @[@"对象",@"人数",@"申购期限",@"起投额",@"状态",@"成交",@"申购成功条件",@"冻结、解冻",@"份额持有",@"撤单"];
    _detailsArr = @[@"投资人需有风险把控能力",@"投资人数不超过200人",@"7天",@"每份100元，计200份（最少购买2万元）",@"申购中、申购结束、买入卖出",@"投资人在充值足够申购款后进行申购，申购提交后，申购款将被冻结，同时新经版交易系统按照最小申购单位自动生成连续的配号；\n（1）摇号、公布中签结果：新经版根据配号情况进行摇号抽签，并公布中签结果，中签时电子交易合同成立并生效，对未中签部分的申购款予以解冻，返还到其新经版账户；\n2）当总申购量正好达到新经版开放申购量时，则提交申购的投资人的中签率为100%",@"（1）必须在预设的筹资时间内达到目标金额才算成功。\n（2）如果在指定期限内未筹资到目标金额则产品筹资失败，那么已获资金全部退还投资人。\n（3）在筹资期限内，投资人可申请撤单，不收取手续费",@"（1）提交申购后，资金将会被冻结，如在申购期满后申购成功，则资金会进入3个月的封闭期，可在二级市场进行买入卖出\n（2）产品到期后，还本付息到其新经版账户中\n（3）若未获得申购资格，或申购结束后未筹资到目标金额，则资金解冻到投资人新经版账户中",@"申购成功后，投资将获得对应的份额，产品到期后可还本付息",@"在申购期满前，可申请撤单，撤单后资金返还到其账户中"];
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
