//
//  CMInstallViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/5.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMInstallViewController.h"
#import "CMSettingsView.h"
#import "CMAboutViewController.h"
#import "CMSortwareShareViewController.h"

#import "CMStatementViewController.h"



@interface CMInstallViewController ()<UITableViewDelegate,UITableViewDataSource,CMSettingsViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *curTableView;

@property (strong, nonatomic) CMSettingsView *settingsView;

@end

@implementation CMInstallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    _settingsView = [CMSettingsView initByNibForClassName];
    _settingsView.delegate = self;
    _curTableView.tableFooterView = _settingsView;
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self dataSourceArr][indexPath.row];
    cell.textLabel.textColor = [UIColor cmSomberColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //设置
    
    switch (indexPath.row) {
        case 0:
        {
            CMAboutViewController *aboutVC = [[CMAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 1:
        {
            CMSortwareShareViewController *shareVC = (CMSortwareShareViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMSortwareShareView"];
            
            [self.navigationController pushViewController:shareVC animated:YES];
            
        }
            
            break;
        case 2:
        {
            //负责声明
            CMStatementViewController *statementVC = (CMStatementViewController *)[[UIStoryboard mainStoryboard] viewControllerWithId:@"CMStatementViewController"];
            statementVC.baserType = CMBaseViewDistinctionTypeStatement;
            statementVC.title = @"免责声明";
            [self.navigationController pushViewController:statementVC animated:YES];
        }
            break;
//        case 3:
//        {//版本更新
//            [self upAppVersion];
//            
//            
//        }
//            break;
        default:
            break;
    }
    
}
//检测更新版本
- (void)upAppVersion {
    //NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
   // NSString *versionKey = [NSString stringWithFormat:@"%@",localVersion];
    [CMRequestAPI cm_homeFetchPromoAppVersionSuccess:^(CMAppVersion *version) {
        
    } fail:^(NSError *error) {
        
    }];
    
    
}


#pragma mark - CMSettingsViewDelegate
//退出
- (void)cm_settingsViewDelegate:(CMSettingsView *)settings {
   
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"你确定退出账号吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
         [[CMAccountTool sharedCMAccountTool] removeAccount];
    }
    
}
#pragma mark setGet
//cell data
- (NSArray *)dataSourceArr {
    return @[@"关于",
             @"软件分享",
             @"免责声明",
             ];
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
