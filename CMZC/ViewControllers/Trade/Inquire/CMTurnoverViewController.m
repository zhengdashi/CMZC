//
//  CMTurnoverViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTurnoverViewController.h"
#import "CMExchangeDetailsViewController.h"
#import "CMHistoryTradeView.h"
#import "CMDayTradeView.h"
#import "TitleView.h"

#import "CMTurnoverList.h"

@interface CMTurnoverViewController ()<TitleViewDelegate,CMDayTradeViewDelegate,CMHistoryTradeViewDelegate>
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (weak, nonatomic) IBOutlet CMDayTradeView *dayTradeView;
@property (weak, nonatomic) IBOutlet CMHistoryTradeView *historyTradeView;//history

@end

@implementation CMTurnoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化titview
    [self loadTitleView];
    _dayTradeView.delegate = self;
    _historyTradeView.delegate = self;
}


#pragma mark -  TitleViewDelegate
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab {
    CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - CMDayTradeViewDelegate && CMHistoryTradeViewDelegate
//当日查询
- (void)cm_dayTradeViewIndex:(CMTurnoverList *)turnover {
    CMExchangeDetailsViewController *exchangeDetailsVC = (CMExchangeDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMExchangeDetailsViewController"];
    exchangeDetailsVC.turnover = turnover;
    [self.navigationController pushViewController:exchangeDetailsVC animated:YES];
}
//历史查询
- (void)cm_historyTradeViewIndex:(CMTurnoverList *)turnover {
    CMExchangeDetailsViewController *exchangeDetailsVC = (CMExchangeDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMExchangeDetailsViewController"];
    exchangeDetailsVC.turnover = turnover;
    [self.navigationController pushViewController:exchangeDetailsVC animated:YES];
}


#pragma mark -
- (void)loadTitleView {
    //媒体报道
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"当日查询"];
    //公告
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"历史查询"];
    [self.titleView addTabWithoutSeparator:sortNewButton];
    [self.titleView addTabWithoutSeparator:sortHotButton];
    self.titleView.delegate = self;
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
