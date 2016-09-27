//
//  CMCrowdFundingViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCrowdFundingViewController.h"

@interface CMCrowdFundingViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_crowdHeaderTitDataArr;//表数据
    
    BOOL _selectionSelect[20];
    
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@end

@implementation CMCrowdFundingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _titleStr;
    //_crowdHeaderTitDataArr = @[@"什么是新经版?",@"新经版的运营模式是什么?",@"新经版上的项目来源?",@"在新经版申购是否受法律保护?"];
    _curTableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _countArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *titName = [_countArr[indexPath.section] objectForKey:@"countStr"];
    CGFloat height = [titName getHeightIncomingWidth:CMScreen_width() - 30 incomingFont:13];
    return height + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_selectionSelect[section]) {
        return 1;
    } else {
        return  0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *titl = [[UILabel alloc] init];
        titl.numberOfLines = 0;
        titl.font = [UIFont systemFontOfSize:13];
        titl.textColor = [UIColor cmTacitlyFontColor];
        titl.tag = 1202;
        [cell addSubview:titl];
    }
    UILabel *titlLab = (UILabel *)[cell viewWithTag:1202];
    NSString *titName = [_countArr[indexPath.section] objectForKey:@"countStr"];
    CGFloat height = [titName getHeightIncomingWidth:CMScreen_width() - 30 incomingFont:13];
    titlLab.frame = CGRectMake(15, 10, CMScreen_width() - 30, height);
    titlLab.text = titName;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    //分割线
    UIView *fgxView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(_curTableView.frame), 1)];
    fgxView.backgroundColor = [UIColor cmDividerColor];
    //标题lab
    UILabel *headerTitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(_curTableView.frame), 40)];
    headerTitLab.text = [_countArr[section] objectForKey:@"titName"];
    //选中but
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(0, 0, CGRectGetWidth(_curTableView.frame), 40);
    headerBtn.tag = section;
    [headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    
    
    [headerView addSubview:headerTitLab];
    [headerView addSubview:fgxView];
    [headerView addSubview:headerBtn];
    return headerView;
}

- (void)headerBtnClick:(UIButton *)sender {
    _selectionSelect[sender.tag] =! _selectionSelect[sender.tag];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag];
    [_curTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];
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


































