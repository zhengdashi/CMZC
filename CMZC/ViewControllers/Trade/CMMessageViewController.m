//
//  CMMessageViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/25.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMMessageViewController.h"
#import "CMMessageTableViewCell.h"


@interface CMMessageViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSArray     *_dataArr;
    
}

@property (weak, nonatomic) IBOutlet UITableView *curTableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation CMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = GetDataFromNSUserDefaults(@"alertArr");
    if (_dataArr.count == 0) {
        _bgView.hidden = NO;
    } else {
        _bgView.hidden = YES;
    }
    _curTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [_dataArr[indexPath.row] getHeightIncomingWidth:CMScreen_width() -66-18 incomingFont:14];
    
    return 70-14+height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"CMMessageTableViewCell" forIndexPath:indexPath];
    messageCell.titleNameStr = _dataArr[indexPath.row];
    return messageCell;
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




























