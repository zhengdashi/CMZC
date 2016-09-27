//
//  CMMyBankCardViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/23.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMyBankCardViewController.h"
#import "CMBankBlockList.h"


@interface CMMyBankCardViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titNameLab;//银行lab
@property (weak, nonatomic) IBOutlet UILabel *takeLab;//取现次数
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLab;//卡号lab
@property (weak, nonatomic) IBOutlet UILabel *boundLab;//绑定时间

@property (strong, nonatomic) NSMutableArray *bankBlockArr;

@end

@implementation CMMyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRequestDataMeans];
}
#pragma mark - 数据请求
//添加上啦加载下拉刷新
- (void)addRequestDataMeans {
    [CMRequestAPI cm_tradeWithdrawFetchBankBlockListSuccess:^(NSArray *bankBlockArr) {
        [self.bankBlockArr removeAllObjects];
        [self.bankBlockArr addObjectsFromArray:bankBlockArr];
        [self bankBlockArr:bankBlockArr];
    } fail:^(NSError *error) {
        MyLog(@"请求银行卡失败");
    }];
}
- (void)bankBlockArr:(NSArray *)blockArr {
    if (blockArr.count >0) {
        CMBankBlockList *blockList = blockArr.firstObject;
        NSMutableString *bankStr = [NSMutableString stringWithFormat:@"%@",blockList.number];;
        [bankStr replaceCharactersInRange:NSMakeRange(5, 11) withString:@"************"];
        _titNameLab.text = blockList.banktype;
        _cardNumberLab.text = bankStr;
    }
    
}

//解绑btn
- (IBAction)unbindBtnClick:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"确定解绑该银行卡?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
}


- (IBAction)topUpBtnClick:(id)sender {
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"解绑银行卡");
    }
}

- (NSMutableArray *)bankBlockArr {
    if (!_bankBlockArr) {
        _bankBlockArr = [NSMutableArray array];
    }
    return _bankBlockArr;
}

#pragma mark -
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
