//
//  CMSubscribeDetailsViewController.m
//  CMZC
//
//  Created by 郑浩然 on 16/9/29.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMSubscribeDetailsViewController.h"
#import "CMSubscribeDetailsView.h"
#import "CMIntroduceDetailsCell.h"
#import "CMReferencesTableViewCell.h" //产品介绍
#import "CMProductDetails.h"


@interface CMSubscribeDetailsViewController () <UITableViewDelegate,UITableViewDataSource,CMIntroduceDetailsCellDelegate> {
    NSInteger _indexCellHegith; //产品介绍cell的高度
    NSInteger _scrollViewIndex; //标示偏移量
}
@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (strong, nonatomic) CMSubscribeDetailsView *subscribeView; //设置view
@property (strong, nonatomic) CMProductDetails *productDetails;

@end

@implementation CMSubscribeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _indexCellHegith = 1000;
    _subscribeView = [[NSBundle mainBundle] loadNibNamed:@"CMSubscribeDetailsView" owner:nil options:nil].firstObject;
    _subscribeView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 440);
    self.curTableView.tableHeaderView = _subscribeView;
    UIView *view = self.curTableView.tableHeaderView;
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 440);
    self.curTableView.tableHeaderView = view;
    
    [self requestDataList];
    
}
- (void)requestDataList {
    [self showDefaultProgressHUD];
    [CMRequestAPI cm_applyFetchProductDetailsListProductId:self.productId success:^(CMProductDetails *listArr) {
        [self hiddenProgressHUD];
        _subscribeView.product = listArr;
        _productDetails = listArr;
        [self.curTableView reloadData];
    } fail:^(NSError *error) {
        [self hiddenProgressHUD];
        [self showHUDWithMessage:error.message hiddenDelayTime:2];
        
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 260;
    } else if (indexPath.section == 1) {
        return _indexCellHegith;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CMIntroduceDetailsCell *introduceCell = [tableView dequeueReusableCellWithIdentifier:@"CMIntroduceDetailsCell" forIndexPath:indexPath];
        introduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        introduceCell.delegate = self;
        return introduceCell;
    } else if (indexPath.section == 1) {
        CMReferencesTableViewCell *referencesCell = [tableView dequeueReusableCellWithIdentifier:@"CMReferencesTableViewCell" forIndexPath:indexPath];
        referencesCell.scrollViewContentIndex = _scrollViewIndex;
        referencesCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return referencesCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"123456";
        return cell;
    }
    
}



#pragma mark - CMIntroduceDetailsCellDelegate
- (void)cm_toggleDisplayContentIndex:(NSInteger)index {
    if (index == 0) {
        _indexCellHegith = 1000;
    } else {
        _indexCellHegith = 300;
    }
    _scrollViewIndex = index;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    
    [_curTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
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































