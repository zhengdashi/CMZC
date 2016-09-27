//
//  CMNoticeViewController.m
//  CMZC
//
//  Created by 财猫 on 16/4/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMNoticeViewController.h"

@interface CMNoticeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab; //标题
@property (weak, nonatomic) IBOutlet UILabel *dateLab; //日期
@property (weak, nonatomic) IBOutlet UILabel *detailsLab; //公告

@end

@implementation CMNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleNameLab.text = _noticeModel.title;
    _dateLab.text = _noticeModel.created;
    _detailsLab.text = _noticeModel.descri;
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
