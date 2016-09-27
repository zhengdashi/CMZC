//
//  CMLoginViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
// 13713720834

#define kUserName @"15989437117"
#define kPassword @"cui12345678"
//#define kUserName @"17600000034"
//#define kPassword @"w123456"

#import "CMLoginViewController.h"
#import "AppDelegate.h"
#import "CMAccount.h"



@interface CMLoginViewController ()<UITextFieldDelegate> {
   
}
@property (weak, nonatomic) IBOutlet CMTextField *accountNumberTF;//账号
@property (weak, nonatomic) IBOutlet CMTextField *passwordTF;//密码
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeViewTopLayout;//view的top

@end

@implementation CMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *accountName = GetDataFromNSUserDefaults(@"accountName");
    if (accountName.length > 0) {
        _accountNumberTF.text = accountName;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)getBackBtnItemClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)logonButClick:(UIButton *)sender {
    [self.view endEditing:YES];
    //存储当前账号
   // SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
    // [self showMainViewController];
    _homeViewTopLayout.constant = 0.0f;
    //线判断数据的有效性
    if ([self checkDataValidity]) {
        [self showDefaultProgressHUD];
        [CMRequestAPI cm_loginTransRegisterClientId:@"CC67712F-4614-40CF-824E-10D784C2A3D7" clientSecret:@"c0aa7577b892ff2ff4ee0109f2932321" userName:_accountNumberTF.text password:_passwordTF.text success:^(CMAccount *account) {
            DeleteDataFromNSUserDefaults(@"accountName");
            SaveDataToNSUserDefaults(_accountNumberTF.text, @"accountName");
            //网络请求
            [self hiddenAllProgressHUD];
            //存储当前账号
            //SaveDataToNSUserDefaults(_accountNumberTF.text, kAccountNumberKey);
            account.userName = _accountNumberTF.text;
            account.password = _passwordTF.text;
            [[CMAccountTool sharedCMAccountTool] addAccount:account];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginWin" object:self];
            //存储以下当前时间
            SaveDataToNSUserDefaults([NSDate date], kVerifyStarDateKey);
            [self showMainViewController];
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:@"账户名或者密码错误" hiddenDelayTime:2];
        }];
    }
}
- (void)showMainViewController {
    AppDelegate *app = [AppDelegate shareDelegate];
    if ([app.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        app.window.rootViewController = app.viewController;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UITextFieldDelegate
//将要开始输入
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (iPhone5) {
        if (_homeViewTopLayout.constant == -100) {
            return;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _homeViewTopLayout.constant += -50;
        }];
    }
    
}

//将要结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}


#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _homeViewTopLayout.constant = 0.0f;
    
    [self.view endEditing:YES];
    
}

#pragma mark - self set

//请求前，检查数据的有效性
- (BOOL)checkDataValidity {
    if (_accountNumberTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"账号不能为空"];
        return NO;
    } else if (_passwordTF.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"密码不能为空"];
        return NO;
    } else {
        return YES;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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

























