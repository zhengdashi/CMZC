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
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMSubmittedWinView *submitted = [[NSBundle mainBundle] loadNibNamed:@"CMSubmittedWinView" owner:nil options:nil].firstObject;
    submitted.center = window.center;
    submitted.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
    [window addSubview:submitted];
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
