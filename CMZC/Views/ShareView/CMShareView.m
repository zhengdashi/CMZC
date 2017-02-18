//
//  CMShareView.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/10.
//  Copyright © 2017年 郑浩然. All rights reserved.
//
#define kCMShareTitle @"新经板-只赚不赔的“原始股"


#import "CMShareView.h"
#import "CMSortwareShareViewController.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"


@implementation CMShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//qq
- (IBAction)qqShareBtnClick:(id)sender {
    [UMSocialData defaultData].extConfig.qqData.title = _titleConten;
    [UMSocialData defaultData].extConfig.qqData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQQ]];
    [self removeFromSuperview];
}
//qq空间
- (IBAction)qzoneBtnClick:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.qzoneData.title = _titleConten;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToQzone]];
    [self removeFromSuperview];
}
//微信
- (IBAction)wechatBtnClick:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _titleConten;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatSession]];
    [self removeFromSuperview];
}
//朋友圈
- (IBAction)wechatTimeBtnClick:(id)sender {
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _titleConten;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.contentUrl;
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToWechatTimeline]];
    [self removeFromSuperview];
}
//微博
- (IBAction)sinaBtnClick:(UIButton *)sender {
    [self umsocialDataServicPostSNSWithTypes:@[UMShareToSina]];
    [self removeFromSuperview];
}
//取消
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}
//分享内容
- (void)umsocialDataServicPostSNSWithTypes:(NSArray *)typeArr {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:typeArr
                                                        content:self.contentStr
                                                          image:[UIImage imageNamed:@"share_image"]
                                                       location:nil
                                                    urlResource:nil
                                            presentedController:nil
                                                     completion:^(UMSocialResponseEntity *response){
                                                         //                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                         //                                                    NSLog(@"分享成功！");
                                                         //                                                }
                                                     }];
}

- (void)remove {
    [self removeFromSuperview];
}




@end




























