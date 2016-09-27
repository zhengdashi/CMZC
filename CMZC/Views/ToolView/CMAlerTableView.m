//
//  CMAlerTableView.m
//  CMZC
//
//  Created by 财猫 on 16/4/8.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMAlerTableView.h"
#import "CMBankBlockList.h"
#import "CMAlerViewTableViewCell.h"



@interface CMAlerTableView ()<UITableViewDataSource,UITableViewDelegate> {
    
}

@property (strong, nonatomic) UIView *myTopView;
@property (strong, nonatomic) NSArray *listDataArr;
@property (nonatomic,copy) NSMutableArray *selectArr;
@property (strong, nonatomic) UITableView *tableView;

@end


@implementation CMAlerTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame dataListClass:(NSArray *)dataClass delegate:(id)dlgt {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = dlgt;
        _listDataArr = dataClass;
        self.backgroundColor = [UIColor cmBlackerColor];
        self.alpha = 0.8;
        _myTopView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, CMScreen_width()-40, 200)];
        //CGRectMake(20, 100, kScreen_width-40, 200)
        _tableView = [[UITableView alloc] initWithFrame:_myTopView.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_myTopView addSubview:_tableView];
        //SaveDataToNSUserDefaults(@"1", @"select");
    }
    return self;
}
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return _listDataArr.count;
    return _listDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMAlerViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CMAlerViewTableViewCell"];
    if (!cell) {
        cell = [CMAlerViewTableViewCell cell];
    }
    if ([self.selectArr[0] integerValue] == indexPath.row) {
        cell.selectImage.hidden = NO;
    } else {
        cell.selectImage.hidden = YES;
    }
    
    CMBankBlockList *bank = _listDataArr[indexPath.row];
    
    if (self.type == CMAlerTableViewStylebankCard) {
        [cell cm_alerViewTableViewNameStr:bank.banktype
                                numberStr:bank.number
                                    style:CMAlerViewTableStylebankCard];
    } else {
        [cell cm_alerViewTableViewNameStr:bank.amount
                                numberStr:bank.validitydate
                                    style:CMAlerViewTableStyleCoupon];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.selectArr[0] integerValue] == indexPath.row) {
        [self.selectArr removeAllObjects];
    } else {
        [self.selectArr replaceObjectAtIndex:0 withObject:CMStringWithFormat(indexPath.row)];
    }
    [_tableView reloadData];
    CMBankBlockList *bank = _listDataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cm_cmAlerViewCellTitle:)]) {
        [self.delegate cm_cmAlerViewCellTitle:bank];
    }
    [self removeFromSuperview];
    [_myTopView removeFromSuperview];
}
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    [window addSubview:_myTopView];
    [window bringSubviewToFront:_myTopView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
    [self removeFromSuperview];
    [_myTopView removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(cm_cmAlerViewCellTitle:)]) {
        [self.delegate cm_cmAlerViewCellTitle:nil];
    }
    
}

- (NSMutableArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
        [_selectArr addObject:@"0"];
    }
    return _selectArr;
}


@end
























