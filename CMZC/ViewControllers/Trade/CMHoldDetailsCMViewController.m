//
//  CMHoldDetailsCMViewController.m
//  CMZC
//
//  Created by 财猫 on 16/6/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMHoldDetailsCMViewController.h"
#import "CMHoldTableViewCell.h"
#import "CMExchangeInquire.h"
#import "CMHoldInquire.h"
#import "CMProductDetailsViewController.h"
#import "CMTradeSonInterfaceController.h"


@interface CMHoldDetailsCMViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UILabel *numberLab;
@property (strong, nonatomic) UILabel *titleLab;


@end

@implementation CMHoldDetailsCMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleView addSubview:self.titleLab];
    [self.titleView addSubview:self.numberLab];
    self.navigationItem.titleView = self.titleView;
    self.titleLab.text = _inquire.pName;
    self.numberLab.text = _inquire.pCode;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMHoldTableViewCell *holdCell = [tableView dequeueReusableCellWithIdentifier:@"CMHoldTableViewCell"];
    
    [holdCell titleName:[CMExchangeInquire cm_holdDetailsTileNameIndex:indexPath.row]
              introduce:[CMExchangeInquire cm_holdDetailsTileNameIndex:indexPath.row holdDetails:self.inquire]];
    if (indexPath.row == 4) {
        holdCell.jumpImage.hidden = NO;
    } else {
        holdCell.jumpImage.hidden = YES;
    }
    
    return holdCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4) {
        CMProductDetailsViewController *productDetailsVC = (CMProductDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMProductDetailsViewController"];
        productDetailsVC.codeName = self.inquire.pCode;
        productDetailsVC.titleName = self.inquire.pName;
        [self.navigationController pushViewController:productDetailsVC animated:YES];
        
        
    }
}

#pragma mark - btnClick
//闪电买入
- (IBAction)buyingBtnClick:(UIButton *)sender {
    [self pushTradeSonInterVCItemIndex:0 codeName:self.inquire.pCode];
}
//卖出
- (IBAction)saleBtnClick:(UIButton *)sender {
    [self pushTradeSonInterVCItemIndex:1 codeName:self.inquire.pCode];
}
- (void)pushTradeSonInterVCItemIndex:(NSInteger)index codeName:(NSString *)code{
    CMTradeSonInterfaceController *tradeSonVC = (CMTradeSonInterfaceController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTradeSonInterfaceController"];
    tradeSonVC.itemIndex = index;
    tradeSonVC.codeStr = code;
    [self.navigationController pushViewController:tradeSonVC animated:YES];
    
    
}

#pragma mark - set Get
- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    }
    return _titleView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 15)];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = [UIColor cmFontWiteColor];
        
        _titleLab.text = @"开始前钱了llllll";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 200, 15)];
        _numberLab.font = [UIFont systemFontOfSize:10];
        _numberLab.textColor = [UIColor cmFontWiteColor];
        //numberLab.text = @"12345679";
        _numberLab.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLab;
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
