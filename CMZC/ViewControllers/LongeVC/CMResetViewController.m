//
//  CMResetViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kVerifyMobilePhoneWordKey @"kVerifyMobilePhoneWordKey"

#define kVerifyStarDatePhoneWordKey @"kVerifyStarDatePhoneWordKey"


#import "CMResetViewController.h"
#import "CMTimer.h"
#import "CMFilletButton.h"

@interface CMResetViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CMTextField *phoneNumberTF;//手机号码

@property (weak, nonatomic) IBOutlet CMTextField *testingNumberTF;//验证码

@property (weak, nonatomic) IBOutlet CMTextField *newlyPasswordTF;//新密码

@property (weak, nonatomic) IBOutlet CMTextField *affirmPasswordTF;//确认密码

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *minViewTopLayout;//主view的topLayout
@property (weak, nonatomic) IBOutlet CMFilletButton *obtainTestingNumberBtn;

//@property (weak, nonatomic) IBOutlet UIButton *obtainTestingNumberBtn;//获取验证码

@property (strong, nonatomic) NSTimer *verifyPhoneTimer;//开启一个用手机注册获得验证码时间的定时器

@property (strong, nonatomic) CMTimer *timer;

@end

@implementation CMResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newlyPasswordTF.delegate = self;
    //得到倒计时时间。当离开当前页面还能获得。
    NSInteger surplus = [self getSurplusPhoneTime];
    //_obtainTestingNumberBtn.enabled = NO;
    if (surplus > 0) {
        self.phoneNumberTF.enabled = NO;
       // self.obtainTestingNumberBtn.enabled = NO;
        //当程序回来时。显示
        _phoneNumberTF.text = GetDataFromNSUserDefaults(kVerifyMobilePhoneWordKey);
        //开启一个定时器
        [self openPhoneTimer];
        [_verifyPhoneTimer fire];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码
- (IBAction)verificationCodeBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _minViewTopLayout.constant = 0.0f;
    //验证手机格式
    if ([self verifyThePhoneNumberFormat]) {
        self.phoneNumberTF.enabled = NO;
        //self.obtainTestingNumberBtn.enabled = NO;
        //存储数据
        SaveDataToNSUserDefaults(_phoneNumberTF.text, kVerifyMobilePhoneWordKey);
        SaveDataToNSUserDefaults([NSDate date], kVerifyStarDatePhoneWordKey);
        //判断定时器
        if (!self.verifyPhoneTimer || !self.verifyPhoneTimer.isValid) {
            [self openPhoneTimer];
        }
        [_verifyPhoneTimer fire];
        [CMRequestAPI cm_toolFetchShortMessagePhoneNumber:[_phoneNumberTF.text integerValue] success:^(BOOL isSucceed) {
            
        } fail:^(NSError *error) {
            
        }];
    }
}

//点击完成按钮的方法
- (IBAction)finishButClick:(id)sender {
    [self.view endEditing:YES];
    _minViewTopLayout.constant = 0.0f;
    
    //显示一个默认加载框
    [self showDefaultProgressHUD];
    if ([self checkDataValidity]) {
        [CMRequestAPI cm_loginTransferResetPhoneNumber:[_phoneNumberTF.text integerValue] phoneVercode:[_testingNumberTF.text integerValue] password:_newlyPasswordTF.text confimPassword:_affirmPasswordTF.text  success:^(BOOL isSucceed) {
            [self hiddenProgressHUD];
            [_verifyPhoneTimer invalidate];//注销定时器
            //删除所保存的key的数据
            DeleteDataFromNSUserDefaults(kVerifyMobilePhoneWordKey);
            DeleteDataFromNSUserDefaults(kVerifyStarDatePhoneWordKey);
            [self showHUDWithMessage:@"重置成功" hiddenDelayTime:2];
            _phoneNumberTF.text = @"";
            _testingNumberTF.text = @"";
            _newlyPasswordTF.text = @"";
            _affirmPasswordTF.text = @"";
            [CMCommonTool executeRunloop:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelay:2];
            
            
            
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
    }
}

//验证数据的有效性
- (BOOL)checkDataValidity {
    if (_phoneNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入手机号"];
        return NO;
    } else if (_testingNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入验证码"];
        return NO;
    } else if (_newlyPasswordTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入密码"];
        return NO;
    } else if (_affirmPasswordTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入确认密码"];
        return NO;
    } else if (![_affirmPasswordTF.text isEqualToString:_newlyPasswordTF.text]) {
        [self showAutoHiddenHUDWithMessage:@"两次密码必须一致"];
        return NO;
    } else {
        return YES;
    }
    

}

#pragma mark - UITextFieldDelegate
//将要开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (iPhone5) {
        if (_minViewTopLayout.constant == -50) {
            return;
        }
        [UIView animateWithDuration:1 animations:^{
            _minViewTopLayout.constant += -50;
        }];
    }
}
//正在输入的
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.testingNumberTF) {
        if (str.length >= 11) {
            //_obtainTestingNumberBtn.enabled = YES;
        }else {
           // _obtainTestingNumberBtn.enabled = NO;
        }
    }
    return YES;
}
//结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _newlyPasswordTF) {
        if (![textField.text judgePassWordLegal:textField.text]) {
            textField.text = @"";
            [self showHUDWithMessage:@"必须字母开头，6-18位字母和数字组成" hiddenDelayTime:2];
            return;
        }
    }
}
#pragma mark - 获取倒计时时间
//获得倒计时时间
- (NSInteger)getSurplusPhoneTime {
    NSInteger lastTimeInterval = (NSInteger)[GetDataFromNSUserDefaults(kVerifyStarDatePhoneWordKey)timeIntervalSince1970];
    NSInteger nowTimeInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSInteger timeInterval = nowTimeInterval - lastTimeInterval;
    NSInteger surplus = kMaxVerifyTime - timeInterval;
    return surplus;
}
//手机计数器
- (void)updatePhoneTimer:(NSTimer *)timer {
    NSInteger surplus = [self getSurplusPhoneTime];
    if (surplus <= 0) {
       // self.phoneNumberTF.enabled = YES;
        //self.obtainTestingNumberBtn.enabled = YES;
        [timer invalidate];//注销定时器
        //删除所保存的key的数据
        
        DeleteDataFromNSUserDefaults(kVerifyMobilePhoneWordKey);
        DeleteDataFromNSUserDefaults(kVerifyStarDatePhoneWordKey);
        self.phoneNumberTF.enabled = YES;
        [_obtainTestingNumberBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        NSString *secodsString = [NSString stringWithFormat:@"%ld秒",(long)surplus];
        [_obtainTestingNumberBtn setTitle:secodsString forState:UIControlStateNormal];
    }
}
//开启一个定时器
- (void)openPhoneTimer {
    self.verifyPhoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePhoneTimer:) userInfo:nil repeats:YES];
}
//获取验证码前，验证手机号码格式
- (BOOL)verifyThePhoneNumberFormat {
    if (_phoneNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入手机号"];
        return NO;
    } else if (!_phoneNumberTF.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"请输入正确的手机号"];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _minViewTopLayout.constant = 0.0f;
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
