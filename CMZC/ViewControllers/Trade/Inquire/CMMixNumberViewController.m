//
//  CMMixNumberViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMixNumberViewController.h"
#import "CMWinning.h"


@interface CMMixNumberViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLab; //日期
@property (weak, nonatomic) IBOutlet UILabel *numberLab; //配号数量
@property (weak, nonatomic) IBOutlet UILabel *shakeLab; //摇号
@property (weak, nonatomic) IBOutlet UILabel *winLab; //中奖
@property (weak, nonatomic) IBOutlet UILabel *originLab; //起始
@property (weak, nonatomic) IBOutlet UILabel *newlyLab; //新增lab


@end

@implementation CMMixNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dateLab.text = self.win.jptime;
    _numberLab.text = self.win.numCount;
    _shakeLab.text = self.win.phtime;
    _winLab.text = self.win.zqNum;
    if (_win.zqList != nil) {
        NSArray *listArr = [_win.zqList componentsSeparatedByString:@","];
        _originLab.text = listArr[0];
        NSString *newlyStr = nil;
        for (NSInteger i = 1; i<listArr.count; i++) {
            newlyStr = [newlyStr stringByAppendingPathComponent:listArr[i]];
        }
        _newlyLab.text = newlyStr;
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
