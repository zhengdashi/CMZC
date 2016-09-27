//
//  CMHelpCoreViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHelpCoreViewController.h"
#import "CMCrowdFundingViewController.h"
#import "CMStatementViewController.h"
#import "CMMoneyViewController.h"


@interface CMHelpCoreViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_helpDataArr;//titleArr
    
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation CMHelpCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助中心";
    //由于是静态页面。所以写了个亿plist文件用来存放数据
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"many.plist" ofType:nil];
    _helpDataArr = [[NSArray alloc] initWithContentsOfFile:pathFile];
    
    _curTableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _helpDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *helpCell = [tableView dequeueReusableCellWithIdentifier:@"helpCell"];
    if (!helpCell) {
        helpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"helpCell"];
    }
    
    
    helpCell.textLabel.textColor = [UIColor cmSomberColor];
    helpCell.textLabel.font = [UIFont systemFontOfSize:15];
    helpCell.textLabel.text = [_helpDataArr[indexPath.row] objectForKey:@"titleName"];
    return helpCell;
}
//定义个view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerViewTitName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_curTableView.frame), 40)];
    
    headerViewTitName.text = @"   常见问题";
    headerViewTitName.backgroundColor = [UIColor cmNineColor];
    headerViewTitName.tintColor = [UIColor cmTacitlyFontColor];
    headerViewTitName.font = [UIFont systemFontOfSize:13];
    return headerViewTitName;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //交易规则详解
    if (indexPath.row == 4) {
        //负责声明
        CMStatementViewController *statementVC = (CMStatementViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMStatementViewController"];
        statementVC.baserType = CMBaseViewDistinctionTypeDetails;
        statementVC.title = @"新手交易指南";
        [self.navigationController pushViewController:statementVC animated:YES];
        //安全保障
    } else if (indexPath.row == 5) {
        CMMoneyViewController *newGuideVC = (CMMoneyViewController *)[CMMoneyViewController initByStoryboard];
        
        [newGuideVC cm_moneyViewTitleName:@"安全保障"
                          bgImageViewName:@"insurance_serve_home"
                              imageHeight:2900.0f-400];
        [self.navigationController pushViewController:newGuideVC animated:YES];
    } else {
        CMCrowdFundingViewController *crowdFundingVC = [[CMCrowdFundingViewController alloc] init];
        crowdFundingVC.countArr = [_helpDataArr[indexPath.row] objectForKey:@"countArr"];
        crowdFundingVC.titleStr = [_helpDataArr[indexPath.row] objectForKey:@"titleName"];
        [self.navigationController pushViewController:crowdFundingVC animated:YES];
    }
    
}


#pragma mark -
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
