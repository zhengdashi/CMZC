//
//  CMMoneyViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMoneyViewController.h"
#import "CMTabBarViewController.h"


@interface CMMoneyViewController ()<UIScrollViewDelegate>

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,assign) CGFloat imageHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;
@property (weak, nonatomic) IBOutlet UIView *btoomView;

@end

@implementation CMMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.title = _titName;
    _curScrollView.delegate = self;
    self.title = _titleStr;
    _titleImageView.image = [UIImage imageNamed:_imageName];
    _imageHeightLayoutConstraint.constant = _imageHeight;
    
}

- (void)cm_moneyViewTitleName:(NSString *)title bgImageViewName:(NSString *)name imageHeight:(CGFloat)height {
    _titleStr = title;
    _imageHeight = height;
    _imageName = name;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_imageName isEqualToString:@"new_guide_serve"]) {
        CGFloat contentOf_y = scrollView.contentOffset.y;
        if (contentOf_y > 2000) {
            _btoomView.hidden = NO;
        } else {
            _btoomView.hidden = YES;
        }
    }
    
}
//开启众筹
- (IBAction)openClick:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    CMTabBarViewController *tab = (CMTabBarViewController *)window.rootViewController;
    tab.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
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
