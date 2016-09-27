//
//  CMCarryDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/18.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kVerifyStarDatePassWordKey @"kVerifyStar"

#import "CMCarryDetailsViewController.h"
#import "CMPickCardTableViewCell.h"
#import "CMAlerTableView.h"
#import "CMFilletButton.h"
#import "CMCarryDetailsTableViewCell.h"
#import "CMCarryNowViewController.h"
#import "CMCommWebViewController.h"




@interface CMCarryDetailsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contViewHeightLayout;
@property (weak, nonatomic) IBOutlet UITextField *depositTextField;//提现金额
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;//头view
@property (weak, nonatomic) IBOutlet UIView *bgView;  //bg view
@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;//获取验证码
@property (weak, nonatomic) IBOutlet UIScrollView *curScurollView;//
@property (weak, nonatomic) IBOutlet UIView *contView;
@property (weak, nonatomic) IBOutlet UITextField *passwTextField;//交易密码
@property (weak, nonatomic) IBOutlet UILabel *discountLab;//折扣卷
@property (weak, nonatomic) IBOutlet UIImageView *approveImage; //认证

@property (strong, nonatomic) NSArray *couponDataArr; //优惠券
@property (weak, nonatomic) IBOutlet UILabel *bankLab; //银行卡lab
@property (weak, nonatomic) IBOutlet UILabel *availableLab; //该卡课题金额
@property (weak, nonatomic) IBOutlet UIView *titleView; //titleView

@property (weak, nonatomic) IBOutlet UILabel *realNameLab; //真实姓名
@property (weak, nonatomic) IBOutlet UILabel *usableLab; //可用金额
@property (weak, nonatomic) IBOutlet UILabel *arriveLab; //实际到账
@property (weak, nonatomic) IBOutlet UILabel *costLab; //提现费用

@property (nonatomic,assign) NSInteger couponid;//优惠券id
@property (nonatomic,assign) NSInteger amount; //折扣金额

@property (weak, nonatomic) IBOutlet UIButton *notAvailableBtn; //暂无可用优惠券
@property (strong, nonatomic)CMBankBlockList *blockList;
 //选卡view
//显卡table
@property (weak, nonatomic) IBOutlet UITableView *curTableView; //选择银行卡tab
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint; //选择高度
@property (nonatomic,copy) NSArray *blackArr; //选卡数组
@property (strong, nonatomic) NSMutableArray *blackMutableArr; //选项卡数组。
@property (strong, nonatomic) NSMutableArray *rollMutableArr; //优惠券数组
@property (weak, nonatomic) IBOutlet UIView *contentBView;
@property (weak, nonatomic) IBOutlet CMFilletButton *gainNumberBtn; //验证码
@property (strong, nonatomic) NSTimer *verifyPhoneTimer;
@property (weak, nonatomic) IBOutlet UILabel *amountAvailable; //可用金额




@end

@implementation CMCarryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (iPhone5) {
         _contViewHeightLayout.constant = 50;
    }
    if (self.proviceName != nil) {
        _blockList = self.bankBlockList;
        [self initTitleView];
    } else {
        //获取折扣卷
        [self requestCouponlist];
        //银行卡列表请求
        [self addRequestDataMeans];
    }
    
    
    //titleView
    //[self initTitleView];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.carryType == CMCarryDetailsViewTypeneed) {
        NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in vcs) {
            if ([vc isKindOfClass:[self class]]) {
                [vcs removeObject:vc];
                break;
            }
        }
        self.navigationController.viewControllers = vcs;
    }
    
}


#pragma mark - btn
- (IBAction)problemBtnClick:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"什么是该卡可提金额?" message:@"因手机支付要求通卡进出，故要求用户使用网站绑定的银行卡提现时，首先快捷支付卡，可提走全部金额。普通卡只能提走部分金额。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [aler show];
    
}
//选卡
- (IBAction)chooseBtnClick:(UIButton *)sender {
    //[self animateTableHeightLayoutConstraint:CMScreen_height() - 149]；
    
    [self carryDetailsBgViewAlpha:0.8 tableViewHeight:200];
    _stype = CMCaryDetailsStypeBlack;
    
}
//获取验证码
- (IBAction)fetchAuthCodeBtnClick:(CMFilletButton *)sender {
    SaveDataToNSUserDefaults([NSDate date], kVerifyStarDatePassWordKey);
    //判断定时器
    if (!self.verifyPhoneTimer || !self.verifyPhoneTimer.isValid) {
        [self openPhoneTimer];
    }
    [_verifyPhoneTimer fire];
    [CMRequestAPI cm_toolFetchShortMessagePhoneNumber:[[CMAccountTool sharedCMAccountTool].currentAccount.userName integerValue] success:^(BOOL isSucceed) {
        if (!isSucceed) {
            [self showHUDWithMessage:@"验证码获取失败" hiddenDelayTime:2];
        }
        
    } fail:^(NSError *error) {
        MyLog(@"获取验证码失败");
    }];
}
#pragma mark - 定时器 倒计时 获取验证码
//获得倒计时时间
- (NSInteger)getSurplusPhoneTime {
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDatePassWordKey)timeIntervalSince1970];
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSInteger timeInterval = nowTimeInterval - lastTimeInterval;
    NSInteger surplus = kMaxVerifyTime - timeInterval;
    return surplus;
}
//手机计数器
- (void)updatePhoneTimer:(NSTimer *)timer {
    NSInteger surplus = [self getSurplusPhoneTime];
    if (surplus <= 0) {
        [timer invalidate];//注销定时器
        //删除所保存的key的数据
        DeleteDataFromNSUserDefaults(kVerifyStarDatePassWordKey);
        [_gainNumberBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        NSString *secodsString = [NSString stringWithFormat:@"%ld秒",(long)surplus];
        [_gainNumberBtn setTitle:secodsString forState:UIControlStateNormal];
    }
}
//开启一个定时器
- (void)openPhoneTimer {
    self.verifyPhoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePhoneTimer:) userInfo:nil repeats:YES];
}
//提交
- (IBAction)presentBtnClick:(UIButton *)sender {
    if ([self carryCheckDataValidity]) {
        [self showDefaultProgressHUD];
        [CMRequestAPI cm_tradeWithdrawTransferExtractBankcardId:_blockList.bankcardid couponId:_couponid amount:_depositTextField.text vercode:_authCodeTextField.text tradePassword:_passwTextField.text provincecode:_proviceName citycode:_cityName bankname:_bankName sccess:^(BOOL isWin) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:@"提现成功" hiddenDelayTime:2];
            [CMCommonTool executeRunloop:^{
                [self withdrawRequestWebCommentVC];
            } afterDelay:2];
            
            [CMCommonTool executeRunloop:^{
                [self.navigationController popoverPresentationController];
            } afterDelay:2];
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:error.domain hiddenDelayTime:2];
        }];
    }
}

//请求前，检查数据的有效性
- (BOOL)carryCheckDataValidity {
    if (_depositTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"提现金额不能为空"];
        return NO;
    } else if (_authCodeTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"验证码不能为空"];
        return NO;
    } else if (_passwTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"提现密码不能为空"];
        return NO;
    } else {
        return YES;
    }
}



//折扣卷
- (IBAction)discountBtnClick:(UIButton *)sender {
    _stype = CMCaryDetailsStyperoll;
    [self carryDetailsBgViewAlpha:0.8 tableViewHeight:200];
}

//请求折扣卷的数据
- (void)requestCouponlist {
    [CMRequestAPI cm_tradeWithdrawFetchCouponlistListType:2 success:^(NSArray *listArr) {
        if (listArr.count > 0) {
            _discountLab.text = @"有可用优惠券";
            _notAvailableBtn.enabled = YES;
        } else {
            _notAvailableBtn.enabled = NO;
        }
        _couponDataArr = listArr;
    } fail:^(NSError *error) {
        MyLog(@"获取优惠券失败");
    }];
}
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    [self showDefaultProgressHUD];
    [CMRequestAPI cm_tradeWithdrawFetchBankBlockListSuccess:^(NSArray *bankBlockArr) {
        [self hiddenProgressHUD];
        [self titleViewBlockListArr:bankBlockArr];
        //[self initTitleView];
        _blackArr = bankBlockArr; //选卡数组
        
    } fail:^(NSError *error) {
        MyLog(@"银行卡列表请求错误");
    }];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (_depositTextField == textField) {
        _topLayoutConstraint.constant = iPhone5?-50:0.0;
    } else if (_passwTextField == textField) {
        _topLayoutConstraint.constant=  iPhone5? -256:-60;
    } else if (_authCodeTextField == textField) {
        _topLayoutConstraint.constant=  iPhone5? -256:-60;
    }
    _bgView.hidden = NO;
   // [self.view bringSubviewToFront:_bgView];
   
}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_depositTextField == textField) {
        CGFloat money = [textField.text floatValue];
        CMBankBlockList *bank =_blockList;
        CGFloat balance = [bank.balance floatValue];
        if (money < 50) {
            [self showHUDWithMessage:@"提现金额不得小于50元" hiddenDelayTime:2];
            _depositTextField.text = @"";
            return;
        }
        if (money > balance ) {
            [self showHUDWithMessage:@"提现金额不得大于可提金额" hiddenDelayTime:2];
            _depositTextField.text = @"";
            _amountAvailable.hidden = NO;
            return;
        } else {
            _amountAvailable.hidden = YES;
            if (money > 50000) {
                [self showHUDWithMessage:@"单笔最多提现5万" hiddenDelayTime:2];
                return;
            } else {
                if (_depositTextField.text.length >0) {
                    CGFloat deposit = [_depositTextField.text floatValue];
                    CGFloat fund = money * 0.003;
                    if (_amount>0) {
                        if (_amount>0) {
                            fund = fund - _amount;
                            if (fund<0) {
                                fund = 0;
                            }
                        }
                    }
                    if (fund<3) {
                        _costLab.text = CMStringWithFormat(3);
                        _arriveLab.text = [NSString stringWithFormat:@"%.2f",money - 3];
                    } else {
                        if (fund>100) {
                            _costLab.text = @"100";
                            CGFloat arive = deposit - 100;
                            _arriveLab.text = [NSString stringWithFormat:@"%.2f",arive];//实际到账
                        } else {
                            _costLab.text = [NSString stringWithFormat:@"%.2f",fund];
                            CGFloat arive = deposit - fund;
                            _arriveLab.text = [NSString stringWithFormat:@"%.2f",arive];//实际到账
                        }
                    }
                }
            }
        }
    }
}
#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _topLayoutConstraint.constant = 0.0f;
    _bgView.hidden = YES;
   // _bgView.alpha = 0;
    _tableHeightConstraint.constant = 0.0f;
}
#pragma mark set get
- (void)animateTableHeightLayoutConstraint:(CGFloat)hegiht {
    [UIView animateWithDuration:0.3 animations:^{
        
    }];
}
- (NSArray *)couponDataArr {
    if (!_couponDataArr) {
        _couponDataArr = [NSArray array];
    }
    return _couponDataArr;
}

- (void)initTitleView {
    _titleView.hidden = NO;
    _contentBView.hidden = NO;
    //CMBankBlockList *bank = _bankArr.firstObject;
    NSMutableString *bankStr = [NSMutableString stringWithFormat:@"%@",_blockList.number];;
    [bankStr replaceCharactersInRange:NSMakeRange(5, 7) withString:@"********"];
    _bankLab.text = [NSString stringWithFormat:@"%@(%@)",_blockList.banktype,bankStr];
    _availableLab.text = [NSString stringWithFormat:@"该卡可提金额%@",_blockList.balance];
    //真实姓名
    _realNameLab.text = self.nameStr;
    //可用金额
    _usableLab.text = _blockList.balance;
    
    if (!_blockList.authentication) {
        _approveImage.hidden = YES;
    } else {
        _approveImage.hidden = NO;
    }
    
    
}
- (void)cmAlerViewCellTitle:(CMBankBlockList *)title {
    if (title !=nil) {
        _discountLab.text = title.amount;
        _couponid = title.couponid;
        _amount = [title.amount integerValue];
    } else {
        _amount = 0;
    }
    CGFloat money = [_depositTextField.text floatValue];
    CGFloat deposit = [_depositTextField.text floatValue];
    CGFloat fund = money * 0.003;
    if (_amount>0) {
        fund = fund - _amount;
        if (fund<0) {
            fund = 0;
        }
    }
    if (fund<3) {
        if (fund == 0) {
            _costLab.text = CMStringWithFormat(0);
            _arriveLab.text = [NSString stringWithFormat:@"%.2f",money - 0];
        } else {
            _costLab.text = CMStringWithFormat(3);
            _arriveLab.text = [NSString stringWithFormat:@"%.2f",money - 3];
        }
    } else {
        if (fund>100) {
            _costLab.text = @"100";
            CGFloat arive = deposit - 100;
            _arriveLab.text = [NSString stringWithFormat:@"%.2f",arive];//实际到账
        } else {
            _costLab.text = [NSString stringWithFormat:@"%.2f",fund];
            CGFloat arive = deposit - fund;
            _arriveLab.text = [NSString stringWithFormat:@"%.2f",arive];//实际到账
        }
    }

    
}

- (void)titleViewBlockListArr:(NSArray *)bankBlock {
    CMBankBlockList *bank = bankBlock.firstObject;
    //判断是否缺少银行卡信息
//#warning 这个地方先取消 为了测试下。 莺歌是 不等于 ！前边加个
    if (!bank.lackofinfo) { //不缺少
        self.carryType = CMCarryDetailsViewTypeRight; //不需要填写
        _blockList = bank;
        [self initTitleView];
    } else { //缺少
        self.carryType = CMCarryDetailsViewTypeneed; //需要填写
        CMCarryNowViewController *carryNowVC = (CMCarryNowViewController *)[[UIStoryboard mainStoryboard]viewControllerWithId:@"CMCarryNowViewController"];
        [self.navigationController pushViewController:carryNowVC animated:NO];
    }
}


#pragma mark - UITableViewDelegate&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_stype == CMCaryDetailsStypeBlack) {
        return _blackArr.count;
    } else {
        return _couponDataArr.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _stype==CMCaryDetailsStypeBlack?0:35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCarryDetailsTableViewCell *carryDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"CMCarryDetailsTableViewCell" forIndexPath:indexPath];
    
    if (_stype == CMCaryDetailsStypeBlack) {
        [carryDetailsCell cm_alerViewTableViewNameStr:_blackArr[indexPath.row]
                                                style:CMCarryDetailsTableViewStylebankCard];
        if ([self.blackMutableArr.lastObject integerValue] == indexPath.row) {
            carryDetailsCell.isSelect = NO;
        } else {
            carryDetailsCell.isSelect = YES;
        }
    } else {
        if ([self.rollMutableArr.lastObject integerValue] == indexPath.row) {
            carryDetailsCell.isSelect = NO;
        } else {
            carryDetailsCell.isSelect = YES;
        }
        [carryDetailsCell cm_alerViewTableViewNameStr:_couponDataArr[indexPath.row]
                                                style:CMCarryDetailsTableViewStyleCoupon];
    }
    return carryDetailsCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, CMScreen_width(), 35);
    [button setTitle:@"不适用优惠券" forState:UIControlStateNormal];
    
    return button;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMBankBlockList *bankBlockList = _blackArr[indexPath.row];
    _blockList = bankBlockList;
    _bgView.hidden = YES;
    _bgView.alpha = 0;
    _tableHeightConstraint.constant = 0.0f;
    if (_stype == CMCaryDetailsStypeBlack) { //银行卡
        [self.blackMutableArr replaceObjectAtIndex:0 withObject:CMStringWithFormat(indexPath.row)];
        [self initTitleView];
    } else { //优惠券
        [self.rollMutableArr replaceObjectAtIndex:0 withObject:CMStringWithFormat(indexPath.row)];
        [self cmAlerViewCellTitle:bankBlockList];
    }
}
- (IBAction)withdrawBtnClick:(id)sender {
    [self withdrawRequestWebCommentVC];
}

- (void)withdrawRequestWebCommentVC {
    CMCommWebViewController *webVC = (CMCommWebViewController *)[CMCommWebViewController initByStoryboard];
    NSString *webUrl =  CMStringWithPickFormat(kCMMZWeb_url,@"Account/WithdrawRecords");
    //[NSString stringWithFormat:@"http://mz.58cm.com/Account/WithdrawRecords"];
    webVC.urlStr = webUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 改变背景的透明度，颜色，和选卡的tab的高度
- (void)carryDetailsBgViewAlpha:(CGFloat)alpha tableViewHeight:(CGFloat)height {
    _bgView.backgroundColor = [UIColor cmBlackerColor];
    _bgView.hidden = NO;
    _bgView.alpha = alpha;
    _tableHeightConstraint.constant = height;
    [_curTableView reloadData];
}

#pragma mark - setGet
- (NSMutableArray *)blackMutableArr {
    if (!_blackMutableArr) {
        _blackMutableArr = [NSMutableArray array];
        [_blackMutableArr addObject:@"0"];
    }
    
    return _blackMutableArr;
}

- (NSMutableArray *)rollMutableArr {
    if (!_rollMutableArr) {
        _rollMutableArr = [NSMutableArray array];
    }
    return _rollMutableArr;
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
