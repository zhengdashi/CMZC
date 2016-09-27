//
//  CMTrustInquireViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/11.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMTrustInquireViewController.h"
#import "CMDayEntrustView.h"
#import "CMExchangeDetailsViewController.h"
#import "CMHistoryEntrustView.h"
#import "CMTrustDetailsViewController.h"


@interface CMTrustInquireViewController ()<TitleViewDelegate>
@property (weak, nonatomic) IBOutlet TitleView *titleView;//titleView
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (weak, nonatomic) IBOutlet CMDayEntrustView *dayEntrustView;//当日委托
@property (weak, nonatomic) IBOutlet CMHistoryEntrustView *historyEntrustView;//历史委托

@end

@implementation CMTrustInquireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTitleView];
    //当日查询
    _dayEntrustView.dayEntrBlock = ^(CMTradeDayAuthorize *trade) {
        CMTrustDetailsViewController *exchangeDetailsVC = (CMTrustDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTrustDetailsViewController"];
        exchangeDetailsVC.tradeDay = trade;
        [self.navigationController pushViewController:exchangeDetailsVC animated:YES];
    };
    _historyEntrustView.historyEntrustBlock = ^(CMTradeDayAuthorize *trade) {
        CMTrustDetailsViewController *exchangeDetailsVC = (CMTrustDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMTrustDetailsViewController"];
        exchangeDetailsVC.tradeDay = trade;
        [self.navigationController pushViewController:exchangeDetailsVC animated:YES];
    };
    
}

#pragma mark -  TitleViewDelegate
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab {
    CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
}
#pragma mark -
- (void)loadTitleView {
    //媒体报道
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"当日委托"];
    //公告
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"历史委托"];
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
