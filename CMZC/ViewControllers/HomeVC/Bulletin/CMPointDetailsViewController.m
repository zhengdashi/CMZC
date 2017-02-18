//
//  CMPointDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/23.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMPointDetailsViewController.h"
#import "CMRoundImage.h"


@interface CMPointDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *contLab;
@property (weak, nonatomic) IBOutlet CMRoundImage *titleImage; //titleImage
@property (weak, nonatomic) IBOutlet UILabel *nameLab; //名字
@property (weak, nonatomic) IBOutlet UILabel *jieshaoLab; //介绍

@end

@implementation CMPointDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userName.text = _point.title;
    _dateLab.text = _point.created;
    _contLab.text = _point.content;
    
    [_titleImage sd_setImageWithURL:[NSURL URLWithString:_analyst.avatar] placeholderImage:kCMDefault_imageName];
    _nameLab.text = _analyst.name;
    _jieshaoLab.text = _analyst.shortdescription;
}
//返回
- (IBAction)popViewContentBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
