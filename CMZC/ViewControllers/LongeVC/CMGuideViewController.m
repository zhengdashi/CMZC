//
//  CMGuideViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/30.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMGuideViewController.h"
#import "AppDelegate.h"


@interface CMGuideViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView; //滑动是图
@property (weak, nonatomic) IBOutlet UIButton *goIntoBtn; //进入

@end

@implementation CMGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curScrollView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x/CMScreen_width();
    if (page == 3) {
        _goIntoBtn.hidden = NO;
    } else {
        _goIntoBtn.hidden = YES;
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    
    AppDelegate *app = [AppDelegate shareDelegate];
    app.window.rootViewController = app.viewController;
    
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
