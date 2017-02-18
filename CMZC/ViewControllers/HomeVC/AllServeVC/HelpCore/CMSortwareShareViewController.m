//
//  CMSortwareShareViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/24.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kCMShareTitle @"新经板-只赚不赔的“原始股"
#define kShare_url @"http://m.xinjingban.com/About/APPClient"

#import "CMSortwareShareViewController.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"

@interface CMSortwareShareViewController ()

@end

@implementation CMSortwareShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//qq分享
- (IBAction)qqShareBtnClick:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.qqData.title = kCMShareTitle;
    [UMSocialData defaultData].extConfig.qqData.url = kShare_url;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQQ]];
    
}
//qq空间
- (IBAction)qzoneBtnClick:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.qzoneData.title = kCMShareTitle;
    [UMSocialData defaultData].extConfig.qzoneData.url = kShare_url;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQzone]];
}
//微信
- (IBAction)wechatBtnClick:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.wechatSessionData.title = kCMShareTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = kShare_url;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatSession]];
}
//微信朋友圈
- (IBAction)wechatTimeBtnClick:(id)sender {
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = kCMShareTitle;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = kShare_url;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatTimeline]];
}
//新浪微博
- (IBAction)sinaBtnClick:(id)sender {
    //[UMSocialData defaultData].extConfig.sinaData.title = kCMShareTitle;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToSina]];
}
//分享内容
- (void)umsocialDataServicPostSNSWithTypes:(NSArray *)typeArr {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:typeArr
                                                        content:@"新经板是一家为优质新经济项目提供众筹服务，保底8%的年收益，唯一一家实现自由退出的互联网众筹交易平台"
                                                          image:[UIImage imageNamed:@"title_log_acc"]
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:self
                                                     completion:^(UMSocialResponseEntity *response){
                                                         //                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                         //                                                    NSLog(@"分享成功！");
                                                         //                                                }
                                                     }];
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
