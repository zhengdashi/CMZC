//
//  CMAlerView.m
//  CMZC
//
//  Created by 财猫 on 16/4/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kLabFont_Size 14

#import "CMAlerView.h"

@interface CMAlerView ()

@property (strong, nonatomic) UIView *contView;

@property (nonatomic,copy) NSString *title;

@end

@implementation CMAlerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame titleName:(NSString *)title certain:(NSString *)certain delegate:(id)delegateVC tradeTool:(CMTradeToolModes *)trade{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cmBlackerColor];
        self.alpha = 0.5f;
        self.delegate = delegateVC;
        
        [self topContentViewTitle:title certain:certain tradeTool:trade];
    }
    return self;
}

- (void)topContentViewTitle:(NSString *)title
                    certain:(NSString *)certain
                  tradeTool:(CMTradeToolModes *)tradeTool
{
    
    _contView = [[UIView alloc] initWithFrame:CGRectMake(25, 160, CMScreen_width()-50, 210)];
    _contView.backgroundColor = [UIColor whiteColor];
    _contView.layer.cornerRadius = 5.0f;
    _contView.layer.masksToBounds = YES;
    //标头
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.center = CGPointMake(CGRectGetWidth(_contView.frame)/2, 20);
    titleLab.bounds = CGRectMake(0, 0, 150, 20);
    titleLab.textColor = [UIColor cmSomberColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = title;
    //x号按钮
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setImage:[UIImage imageNamed:@"exit_trade"] forState:UIControlStateNormal];
    quitBtn.frame = CGRectMake(CGRectGetMaxX(_contView.frame)-70, CGRectGetMinY(titleLab.frame)-5, 30, 30);
    [quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //分割线
    UIView *fgxView = [[UIView alloc] init];
    fgxView.center = CGPointMake(CGRectGetWidth(_contView.frame)/2, CGRectGetMaxY(titleLab.frame)+10);
    fgxView.bounds = CGRectMake(0, 0, CGRectGetWidth(_contView.frame) - 40, 1);
    fgxView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //代码名称
    UILabel *codeLab = [[UILabel alloc] init];
    codeLab.frame = CGRectMake(28, CGRectGetMaxY(fgxView.frame) + 15 , 35, 18);
    codeLab.textColor = [UIColor cmTacitlyFontColor];
    codeLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    codeLab.text = @"代码:";
    //代码
    UILabel *codeNameLab = [[UILabel alloc] init];
    codeNameLab.frame = CGRectMake(CGRectGetMaxX(codeLab.frame)+2, CGRectGetMinY(codeLab.frame), 100, 18);
    codeNameLab.textColor = [UIColor cmTacitlyOneColor];
    codeNameLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    codeNameLab.text = tradeTool.code;
    //名字
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.frame = CGRectMake(CGRectGetMinX(codeLab.frame), CGRectGetMaxY(codeLab.frame) + 10 , 35, 18);
    nameLab.textColor = [UIColor cmTacitlyFontColor];
    nameLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    nameLab.text = @"名称:";
    //名称
    UILabel *designationLab = [[UILabel alloc] init];
    designationLab.frame = CGRectMake(CGRectGetMaxX(nameLab.frame)+2, CGRectGetMinY(nameLab.frame), 200, 18);
    designationLab.textColor = [UIColor cmTacitlyOneColor];
    designationLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    designationLab.text = tradeTool.name;
    //价格
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.frame = CGRectMake(CGRectGetMinX(codeLab.frame), CGRectGetMaxY(nameLab.frame) + 10 , 35, 18);
    priceLab.textColor = [UIColor cmTacitlyFontColor];
    priceLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    priceLab.text = @"价格:";
    //价格详情
    UILabel *detailPriceLab = [[UILabel alloc] init];
    detailPriceLab.frame = CGRectMake(CGRectGetMaxX(priceLab.frame)+2, CGRectGetMinY(priceLab.frame), 200, 18);
    detailPriceLab.textColor = [UIColor cmTacitlyOneColor];
    detailPriceLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    detailPriceLab.text = tradeTool.price;
    //数量
    UILabel *numberLab = [[UILabel alloc] init];
    numberLab.frame = CGRectMake(CGRectGetMinX(codeLab.frame), CGRectGetMaxY(priceLab.frame) + 10 , 35, 18);
    numberLab.textColor = [UIColor cmTacitlyFontColor];
    numberLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    numberLab.text = @"数量:";
    //个性数量
    UILabel *detailNumberLab = [[UILabel alloc] init];
    detailNumberLab.frame = CGRectMake(CGRectGetMaxX(numberLab.frame)+2, CGRectGetMinY(numberLab.frame), 200, 18);
    detailNumberLab.textColor = [UIColor cmTacitlyOneColor];
    detailNumberLab.font = [UIFont systemFontOfSize:kLabFont_Size];
    detailNumberLab.text = tradeTool.number;
    //分割线
    UIView *fgxView1 = [[UIView alloc] init];
    fgxView1.center = CGPointMake(CGRectGetWidth(_contView.frame)/2, CGRectGetMaxY(numberLab.frame)+15);
    fgxView1.bounds = CGRectMake(0, 0, CGRectGetWidth(_contView.frame) - 40, 1);
    fgxView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //取消
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(fgxView1.frame)+5, CGRectGetWidth(_contView.frame)/2, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor cmTacitlyFontColor] forState:UIControlStateNormal];
    cancelBtn.tag = 0;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //确定
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    certainBtn.frame = CGRectMake(CGRectGetWidth(_contView.frame)/2, CGRectGetMaxY(fgxView1.frame)+5, CGRectGetWidth(_contView.frame)/2, 30);
    [certainBtn setTitle:certain forState:UIControlStateNormal];
    [certainBtn setTitleColor:[UIColor cmThemeOrange] forState:UIControlStateNormal];
    certainBtn.tag = 1;
    [certainBtn addTarget:self action:@selector(certainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_contView addSubview:titleLab];
    [_contView addSubview:quitBtn];
    [_contView addSubview:fgxView];
    [_contView addSubview:codeLab];
    [_contView addSubview:codeNameLab];
    [_contView addSubview:nameLab];
    [_contView addSubview:designationLab];
    [_contView addSubview:priceLab];
    [_contView addSubview:detailPriceLab];
    [_contView addSubview:numberLab];
    [_contView addSubview:detailNumberLab];
    [_contView addSubview:fgxView1];
    [_contView addSubview:cancelBtn];
    [_contView addSubview:certainBtn];
}
- (void)quitBtnClick {
    [self removeFrom];
}
//取消 这两个方法可以写一个。但是我不想这么写。
- (void)cancelBtnClick:(UIButton *)cacelBtn {
    
    [self selfDelegateBtnTag:cacelBtn.tag];
    [self removeFrom];
}
//确定
- (void)certainBtnClick:(UIButton *)caselBtn {
    [self selfDelegateBtnTag:caselBtn.tag];
    [self removeFrom];
}
- (void)selfDelegateBtnTag:(NSInteger)btnTag {
    if ([self.delegate respondsToSelector:@selector(cm_cmalerView:willDismissWithButtonIndex:)]) {
        [self.delegate cm_cmalerView:self willDismissWithButtonIndex:btnTag];
    }
    //[self removeFrom];
}


- (void)show {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    [window addSubview:_contView];
    [window bringSubviewToFront:_contView];
}
- (void)removeFrom {
    [_contView removeFromSuperview];
    [self removeFromSuperview];
    
}

@end
