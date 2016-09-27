//
//  CMCarryNowViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/18.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCarryNowViewController.h"
#import "CMAlerTableView.h"
#import "CMBankBlockList.h"
#import "CMCarryDetailsViewController.h"
#import "CMProvinceList.h"



@interface CMCarryNowViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CMAlerTableViewDelegate> {
    NSArray *stateArr,*_cityArr;
    NSInteger   index;
    NSString *_proviceIndex;//身份
    NSString *_cityIndex; //城市
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *saveLab;//省lab  Z002ZKFKMXB
@property (weak, nonatomic) IBOutlet UILabel *cityLab;//城市
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightLayout;
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UILabel *bankLab; //银行卡lab
@property (weak, nonatomic) IBOutlet UILabel *availableLab; //该卡课题金额
@property (weak, nonatomic) IBOutlet UITextField *subbranchText;

@property (weak, nonatomic) IBOutlet UIView *titleView; //titleView
@property (weak, nonatomic) IBOutlet UIView *functionView;

@property (strong, nonatomic) CMBankBlockList *block;

@property (strong, nonatomic) NSArray *backDataArr; //银行卡数组

@end

@implementation CMCarryNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_liftBarBtnItem.
    _titleView.hidden = YES;
    _functionView.hidden = YES;
    
    [self addRequestDataMeans];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //多空尽在掌握
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    [self showDefaultProgressHUD];
    [CMRequestAPI cm_tradeWithdrawFetchBankBlockListSuccess:^(NSArray *bankBlockArr) {
        _titleView.hidden = NO;
        _functionView.hidden = NO;
        [self hiddenAllProgressHUD];
        self.backDataArr = bankBlockArr;
        [self refreshBankBlockListArr:bankBlockArr];
    } fail:^(NSError *error) {
        MyLog(@"银行卡列表请求错误");
    }];
}
- (void)refreshBankBlockListArr:(NSArray *)bankBlock {
    CMBankBlockList *bank = bankBlock.firstObject;
    _block = bank;
    NSMutableString *bankStr = [NSMutableString stringWithFormat:@"%@",bank.number];;
    [bankStr replaceCharactersInRange:NSMakeRange(5, 7) withString:@"********"];
    _bankLab.text = [NSString stringWithFormat:@"%@(%@)",bank.banktype,bankStr];
    _availableLab.text = [NSString stringWithFormat:@"该卡可提金额%@",bank.balance];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.type) {
        case CMCarryNowTypeSave://省
            return stateArr.count;
            break;
        case CMCarryNowTypeCity:
            return _cityArr.count;
            break;
        default:
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!tableCell) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (self.type == CMCarryNowTypeSave) {
        CMProvinceList *province = stateArr[indexPath.row];
         tableCell.textLabel.text = province.name;
    } else {
        CMProvinceList *province = _cityArr[indexPath.row];
        tableCell.textLabel.text = province.name;
    }
    return tableCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (self.type) {
        case CMCarryNowTypeSave:
        {
            CMProvinceList *province = stateArr[indexPath.row];
            
            _proviceIndex = province.code;
            _saveLab.text = province.name;
        }
            break;
        case CMCarryNowTypeCity:
        {
            CMProvinceList *province = _cityArr[indexPath.row];
            _cityIndex = province.code;
            _cityLab.text = province.name;
        }
            break;
        default:
            break;
    }
    [self bgViewHidden:YES alphe:1 bgColor:[UIColor clearColor]];
    [UIView animateWithDuration:2 animations:^{
        _tableViewHeightLayout.constant = 0.0f;
    }];
}



#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _bgView.hidden = NO;//因为结束输入的时候点击view 上边都是btn 事件相应连会在这个地方段吊。所以，放一个view上来
    if (iPhone5) {
        _titleViewTopLayoutConstraint.constant = - 40;//因为4上边会当着输入框所以。让整体上衣40
    }
    
}

#pragma mark - btn click
//点击省
- (IBAction)saveBtnClick:(UIButton *)sender {
    /*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
    stateArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    */
    [CMRequestAPI cm_tradeFetchProvinceListSuccess:^(NSArray *provinceArr) {
        stateArr = provinceArr;
        [self bgViewHidden:NO alphe:0.5 bgColor:[UIColor cmBackgroundGrey]];
        [UIView animateWithDuration:1 animations:^{
            _tableViewHeightLayout.constant = self.view.height - 180;
        }];
        self.type = CMCarryNowTypeSave;
        [_curTableView reloadData];

    } fail:^(NSError *error) {
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}
//点击市
- (IBAction)cityBtnClick:(UIButton *)sender {
    if (stateArr.count == 0) {
        [self showAutoHiddenHUDWithMessage:@"请先选择城市"];
        return;
    }
    
    [CMRequestAPI cm_tradeFetchCityListProvincecode:_proviceIndex success:^(NSArray *cityArr) {
        _cityArr = cityArr;
        [self bgViewHidden:NO alphe:0.5 bgColor:[UIColor cmBackgroundGrey]];
        [UIView animateWithDuration:2 animations:^{
            _tableViewHeightLayout.constant = self.view.height - 230;
        }];
        self.type = CMCarryNowTypeCity;
        [_curTableView reloadData];
        
    } fail:^(NSError *error) {
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}
//下一步
- (IBAction)nextStepBtnClick:(UIButton *)sender {
    if (_saveLab.text.length > 0 && _cityLab.text.length > 0 && _subbranchText.text.length >0) {
        CMCarryDetailsViewController *carryDetailsVC = (CMCarryDetailsViewController *)[CMCarryDetailsViewController initByStoryboard];
        carryDetailsVC.nameStr = self.realNameStr;
        carryDetailsVC.bankBlockList = _block;
        carryDetailsVC.proviceName = _proviceIndex;
        carryDetailsVC.cityName = _proviceIndex;
        
        [self.navigationController pushViewController:carryDetailsVC animated:YES];
    } else {
        [self showHUDWithMessage:@"请完善信息" hiddenDelayTime:2];
    }
}
//切换银行卡按钮
- (IBAction)switchBankCardBtnClick:(UIButton *)sender {
    if (self.backDataArr.count > 0) {
        [self hiddenProgressHUD];
        CMAlerTableView *aerlView = [[CMAlerTableView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CMScreen_height()) dataListClass:self.backDataArr delegate:self];
        aerlView.type = CMAlerTableViewStylebankCard;
        [aerlView show];
    } else { 
        [self showDefaultProgressHUD];
    }
}
//返回的数据
- (void)cm_cmAlerViewCellTitle:(CMBankBlockList *)title {
    if (title !=nil) {
        NSMutableString *bankStr = [NSMutableString stringWithFormat:@"%@",title.number];;
        [bankStr replaceCharactersInRange:NSMakeRange(5, 7) withString:@"********"];
        _bankLab.text = [NSString stringWithFormat:@"%@(%@)",title.banktype,bankStr];
        _availableLab.text = [NSString stringWithFormat:@"该卡可提金额%@",title.balance];
        _block = title;
    }
    
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _tableViewHeightLayout.constant = 0.0f;
    
    [self bgViewHidden:YES alphe:0 bgColor:[UIColor clearColor]];
    _titleViewTopLayoutConstraint.constant = 0.0;
    
}
//因为要点击。要有背景灰色。所以，学一个方法
- (void)bgViewHidden:(BOOL)hid alphe:(CGFloat)alp bgColor:(UIColor *)color{
    _bgView.hidden = hid;
    _bgView.alpha = alp;
    _bgView.backgroundColor = color;
}

#pragma mark - set get
- (NSArray *)backDataArr {
    if (!_backDataArr) {
        _backDataArr = [NSMutableArray array];
    }
    return _backDataArr;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    CMCarryDetailsViewController *detailsVC = (CMCarryDetailsViewController *)segue.destinationViewController;
//    
//    detailsVC.bankArr = self.backDataArr;
}


@end















