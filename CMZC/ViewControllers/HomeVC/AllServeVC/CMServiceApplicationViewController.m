//
//  CMServiceApplicationViewController.m
//  CMZC
//
//  Created by 郑浩然 on 16/12/27.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMServiceApplicationViewController.h"
#import "CMFilletButton.h"
#import "CMSubmittedWinView.h"


@interface CMServiceApplicationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *projectNameText; //项目名称
@property (weak, nonatomic) IBOutlet UITextField *realNameText; //真实姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText; //联系电话

@end

@implementation CMServiceApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)completeBtnClick:(CMFilletButton *)sender {
    [self.view endEditing:YES];
    if ([self checkDataValidity]) {
        [CMRequestAPI cm_serviceApplicationProjectName:self.projectNameText.text realName:self.realNameText.text contactPhone:self.phoneNumberText.text success:^(BOOL isSuccess) {
            if (isSuccess) {
                UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
                CMSubmittedWinView *submitted = [[NSBundle mainBundle] loadNibNamed:@"CMSubmittedWinView" owner:nil options:nil].firstObject;
                submitted.center = window.center;
                submitted.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
                [window addSubview:submitted];
                
                submitted.block = ^(){
                    [self.navigationController popViewControllerAnimated:YES];
                };
            }
            
        } fail:^(NSError *error) {
            [self showAutoHiddenHUDWithMessage:error.message];
        }];
    }
}
//这侧之前验证数据的有效性
- (BOOL)checkDataValidity {
    if (_projectNameText.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请填写项目名称"];
        return NO;
    } else if (_realNameText.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请填写真是姓名"];
        return NO;
    }
    else if (_phoneNumberText.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入手机号"];
        return NO;
    } else if (!_phoneNumberText.text.checkPhoneNumInput) {
        [self showAutoHiddenHUDWithMessage:@"请输入正确的手机号"];
        return NO;
    } else {
        return YES;
    }
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
