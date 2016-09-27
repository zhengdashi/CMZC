//
//  CMCommentViewController.m
//  CMZC
//
//  Created by 财猫 on 16/6/14.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMCommentViewController.h"
#import "CMProductComment.h"


@interface CMCommentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation CMCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleNameLab.text = _product.title;
    _timeLab.text = _product.created;
    _contentLab.text = [NSString stringWithFormat:@"   %@",_product.content];
    
    
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
