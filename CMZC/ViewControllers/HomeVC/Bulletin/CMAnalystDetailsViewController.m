//
//  CMAnalystDetailsViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//
#define kAnimatoinDurtion 0.4

#import "CMAnalystDetailsViewController.h"
#import "CMAnalystDetailsView.h"
#import "TitleView.h"
#import "CMAnalystAnswerView.h"
#import "CMAnalystPointView.h"
#import "CMPointDetailsViewController.h"

@interface CMAnalystDetailsViewController ()<TitleViewDelegate,UITextFieldDelegate> {
    BOOL _publishOrAnswer;   //发布分析师
}

@property (weak, nonatomic) IBOutlet CMAnalystPointView *pointView;//观点详情
@property (weak, nonatomic) IBOutlet CMAnalystDetailsView *analystDetailsView; //头view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *analystHeightLayout;//高度
@property (weak, nonatomic) IBOutlet UIView *btmView;//下边的view
//titleView
@property (weak, nonatomic) IBOutlet TitleView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *curScrollView;//scroll
@property (weak, nonatomic) IBOutlet CMAnalystAnswerView *answerView;//回答
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;//标题头
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTitleLayoutConstraint; //高度
@property (weak, nonatomic) IBOutlet UITextField *inputBoxTextField;//回复输入框
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btmViewLayoutConstraint;//btmView
@property (weak, nonatomic) IBOutlet UIView *bgView;//用于点击
@property (weak, nonatomic) IBOutlet UIButton *replyBtn; //回复按钮


@property (nonatomic,assign) NSInteger topicId; //w问题id

@end

@implementation CMAnalystDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //动态改变titview的高度
    self.title = @"分析师详情";
    
    [self setAnalysthViewHeigthLayout];
    //titleView
    [self loadTitleView];
    
    
    [self showShirkOrExpand];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //赋值页面id
    _answerView.analystId = _analyst.analystId;
    _pointView.analystId = _analyst.analystId;
}
//团出键盘
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    _btmViewLayoutConstraint.constant = height;
    _bgView.hidden = NO;
    [self showShirk]; //当键盘弹出来的时候，让titleview上移
    
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    _bgView.hidden = YES;
    _btmViewLayoutConstraint.constant = 0.0f;
    [self showExpand];//下落
}

#pragma mark - TitleViewDelegate
- (void)clickTitleViewAtIndex:(NSInteger)index andTab:(UIButton *)tab {
    if (index == 0) {
        _btmView.hidden = NO;
    } else {
        _btmView.hidden = YES;
    }
    
    CGRect rect = CGRectMake(index *CGRectGetWidth(_curScrollView.frame), 0, CGRectGetWidth(_curScrollView.frame), CGRectGetHeight(_curScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_curScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //_btmViewLayoutConstraint.constant = 256.0f;
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark - btn click
//回复分析师
- (IBAction)replyBtnClick:(UIButton *)sender {
    
    if (!CMIsLogin()) {
        //位登录。显示登录
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        [_inputBoxTextField  resignFirstResponder];
        [self showDefaultProgressHUD];
        if (_publishOrAnswer) {
            //回复发布话题
            [self answerReply];
        } else {
            [self publishTopic];
        }
        _inputBoxTextField.text = @"";
    }
}
//回复
- (void)answerReply {
    [CMRequestAPI cm_homeFetchAnswerReplyTopicId:_topicId content:_inputBoxTextField.text success:^(NSArray *replyArr) {
        [self hiddenProgressHUD];
        [_replyBtn setTitle:@"提问" forState:UIControlStateNormal];
        _answerView.replyArr = replyArr;
        _publishOrAnswer = NO;
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}
//发布话题
- (void)publishTopic {
    [CMRequestAPI cm_homePublishCreateAnalystId:_analyst.analystId content:_inputBoxTextField.text success:^(BOOL isWin) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:@"发布成功" hiddenDelayTime:2];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
    }];
}

#pragma mark - getStr
- (void)loadTitleView {
    //回答
    UIButton *sortNewButton = [UIButton cm_customBtnTitle:@"回答"];
    //观点
    UIButton *sortHotButton = [UIButton cm_customBtnTitle:@"观点"];
    [self.titleView addTabWithoutSeparator:sortNewButton];
    [self.titleView addTabWithoutSeparator:sortHotButton];
    self.titleView.delegate = self;
}

//titleViewDelegate
- (void)setAnalysthViewHeigthLayout {
    
    _analystDetailsView.analyst = _analyst;
    
    _analystDetailsView.analystBlock = ^(BOOL isPot,CGFloat height){
        if (isPot) {
            [UIView animateWithDuration:kAnimatoinDurtion animations:^{
                _analystHeightLayout.constant = [UIScreen mainScreen].bounds.size.height-65;
                _btmView.hidden = YES;//由于约束问题。当analystview全屏的时候。btmview会把他挡住一部分，只好隐藏吊
                _analystDetailsView.titleViewHeightLayoutConstraint.constant = 225+height;
            }];
        } else {
            [UIView animateWithDuration:kAnimatoinDurtion animations:^{
                _analystHeightLayout.constant = 225.0f;
                _btmView.hidden = NO;
                _analystDetailsView.titleViewHeightLayoutConstraint.constant = 225;
            }];
        }
    };
}
#pragma mark - 上拉下滑
- (void)showShirkOrExpand {
    __weak typeof(self) weakSelef = self;
    
    //回答
    _answerView.block = ^(CMAnalystAnswerType type) {
        if (type == CMAnalystAnswerBlockNew) {
            [weakSelef expand];
            NSLog(@"下拉");
        } else {
            [weakSelef showShirk];
            NSLog(@"上啦");
            //_answerView.isAnimating = NO;
        }
    };
    
    //点击回复的时候的按钮
    _answerView.topicBlock = ^(NSInteger index) {
      //传过来一个topicId 回答
        if (!CMIsLogin()) {
            //位登录。显示登录
            UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
            [self presentViewController:nav animated:YES completion:nil];
        } else {
            [_inputBoxTextField becomeFirstResponder];
            _topicId = index;
            _publishOrAnswer = YES;
            [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        }
    };
    
    //详情
    _pointView.block = ^(CMAnalystPointType type) {
        if (type == CMAnalystPointTypeNew) {
            [weakSelef expand];
        } else {
            [weakSelef showShirk];
            NSLog(@"上啦");
        }
        
    };
    
    //跳转到观点详情页
    
    _pointView.pointBlock = ^(CMAnalystPoint *index) {
        CMPointDetailsViewController *detailsVC = (CMPointDetailsViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMPointDetailsViewController"];
        detailsVC.analyst = _analyst;
        detailsVC.point = index;
        [weakSelef.navigationController pushViewController:detailsVC animated:YES];
    };
    
}

//上滑
- (void)showShirk {
    [UIView animateWithDuration:kAnimatoinDurtion animations:^{
        [self shirk];
    }];
}
- (void)shirk {
    //__weak typeof(self) weakSelef = self;
    [CMCommonTool executeRunloop:^{
        _answerView.isAnimating = NO;
        _pointView.isAnimating = NO;
        _topLayoutConstraint.constant = -225;
        _topTitleLayoutConstraint.constant = 0.0f;
    } afterDelay:kAnimatoinDurtion];
    
}
//下拉
- (void)showExpand {
    [UIView animateWithDuration:kAnimatoinDurtion animations:^{
        [self expand];
    }];
    
}

- (void)expand {
    [CMCommonTool executeRunloop:^{
        _answerView.isAnimating = NO;
        _pointView.isAnimating = NO;
        _topLayoutConstraint.constant = 0.0f;
        _topTitleLayoutConstraint.constant = 225.0f;
    } afterDelay:kAnimatoinDurtion];
    
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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




















