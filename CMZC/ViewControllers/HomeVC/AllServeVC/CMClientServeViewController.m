//
//  CMClientServeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMClientServeViewController.h"

@interface CMClientServeViewController ()

@end

@implementation CMClientServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"客户服务";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (IBAction)upPhoneBtnClick:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4009993972"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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
