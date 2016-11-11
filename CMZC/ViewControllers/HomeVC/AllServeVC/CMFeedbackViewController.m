//
//  CMFeedbackViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMFeedbackViewController.h"
#import "JSQMessagesComposerTextView.h"


@interface CMFeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;//填写意见
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//填写名字
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;//联系方式
@property (weak, nonatomic) IBOutlet UILabel *importStringNumberLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    _textView.placeHolder = @"请再此留下您的宝贵意见";
    _nameTextField.delegate = self;
    _emailTextField.delegate = self;
    
}
//提交意见
- (IBAction)referBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    _titleViewTopLayoutConstraint.constant = 69;
    if ([self checkDataValidity]) {
        //网络请求提交意见
        [self showDefaultProgressHUD];
        [CMRequestAPI cm_homeFetchFeedbackAppName:@"新经板" userName:_nameTextField.text phoneNumber:_emailTextField.text content:_textView.text success:^(BOOL isSucceed) {
            [self hiddenProgressHUD];
            
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"意见受理成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
            
        } fail:^(NSError *error) {
            [self hiddenProgressHUD];
            [self showHUDWithMessage:error.message hiddenDelayTime:2];
        }];
        
        
    }
    
    
}
- (BOOL)checkDataValidity {
    if (_textView.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入填写意见"];
        return NO;
    } else if (_nameTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入您的姓名"];
        return NO;
    } else if (_emailTextField.text.isBlankString) {
        [self showAutoHiddenHUDWithMessage:@"请输入联系方式"];
        return NO;
    } else {
        return YES;
    }
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (iPhone5) {
        if (textField == _nameTextField) {
            _titleViewTopLayoutConstraint.constant = 0;
        } else if (textField == _emailTextField) {
            _bgView.hidden = NO;
            if (_titleViewTopLayoutConstraint.constant !=0) {
                _titleViewTopLayoutConstraint.constant = -40;
            } else {
                _titleViewTopLayoutConstraint.constant = -40;
            }
        }
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _bgView.hidden = YES;
    _titleViewTopLayoutConstraint.constant = 69;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
     _titleViewTopLayoutConstraint.constant = 69;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (str.length >=1000) {
        return NO;
    } else {
        NSInteger number = 1000 - str.length;
        _importStringNumberLab.text = [NSString stringWithFormat:@"你还可以输入%ld个字",(long)number];
        return YES;
    }
    
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


























