//
//  CMStatementViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/7.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMStatementViewController.h"

@interface CMStatementViewController ()
@property (nonatomic,copy) NSString *_explainStr;

@property (weak, nonatomic) IBOutlet UILabel *explainLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeigthLayout;

@end

@implementation CMStatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *titleStr = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"brief" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
//    brief
    switch (_baserType) {
        case CMBaseViewDistinctionTypeStatement://声明
        {
            titleStr = @"本声明包含网络使用及风险提示的有关条款。凡浏览本网站及相关网页的用户，均表示接受以下条款。\n一、新经板对本网站中所示的任何商标、公司标志及服务标志拥有所有权。未经本公司的书面批准，任何人不得使用。本网站所刊登的资料受版权保护。未经本公司书面同意，该资料任何部分均不得修改、复制、储存于检索系统、传送、抄袭、分发，或用于任何商业或公开用途。\n二、 新经板只在法律允许的国家中提供本网站所述的产品及服务，所发布的资料无意提供给受法律发布限制的国家的人士或居民使用。本网站提供的产品与服务在法律不允许的国家不构成向任何人士要约邀请，购买投资产品或其他产品服务的邀请。\n（1）本网站为用户提供专业的投资服务，需要对客户资质进行评估，并非所有的客户都可以获得所有产品和服务。您是否符合享受产品和服务的条件，应该自觉在新经板通过风险测试，最终的解释权归本网站。我们保留对该网站包含的信息和资料及其显示的条款、条件和说明变更的权利。\n（2）产品在运作过程中可能面临各种风险，既包括市场风险，也包括产品自身的管理风险、技术风险和合规风险等。包括巨额赎回风险可能导致无法及时赎回持有的产品份额。\n（3）用户应当认真阅读相关交易文书文件，了解产品的风险收益特征，并根据自身的投资目的、投资期限、投资经验、资产状况等判断产品是否和投资人的风险承受能力相适应。\n（4）用户应当充分了解新经板产品运作和储蓄方式的区别，新经板产品固定收益是引导用户进行简单投资的方式，但不是替代储蓄的等效理财方式。\n（5）任何在本网站出现的信息包括但不限于评论、预测、图表、指标、理论、直接的或暗示的指示均只作为参考，您须对任何自主决定的行为负责。\n（6）本网站提供的有关评论、投资分析报告、预测文章信息等仅供参考。本网站所提供之公司资料等信息，力求但不保证数据的准确性，如有错漏，请以国家指定机构的公示信息为准。本网站不对因本网资料全部或部分内容产生的或因依赖该资料而引致的任何损失承担任何责任。\n 三、鉴于新经板已经最大限度地采取了有效措施保护用户的资料和交易活动的安全。尽管如此，本着对用户负责的态度，新经板在此郑重提示用户，除其他交易方式共同具有的风险以外，新经板交易仍然存在下列风险，该风险包括但不限于：\n（1）互联网是全球公共网络，并不受任何一个机构所控制。数据在互联网上传输的途径不是完全确定的，可能会受到非法干扰或侵入。\n（2）在互联网上传输的数据有可能被某些未经许可的个人、团体或机构通过某种渠道获得或篡改。\n（3）互联网上的数据传输可能因通信繁忙出现延迟，或因其他原因出现中断、停顿或数据不完全、数据错误等情况，从而使交易出现错误、延迟、中断或停顿。\n（4）因地震、火灾、台风及其他各种不可抗力因素引起的停电、网络系统故障、电脑故障等原因可能造成投资人的经济损失。\n（5）互联网上发布的各种信息（包括但不限于分析、预测性的参考资料）可能出现错误并误导用户。\n（6）用户的网上交易身份可能会被泄露或仿冒。\n（7）用户使用的计算机可能因存在性能缺陷、质量问题、计算机病毒、硬件故障及其他原因，而对投资者的交易时间或交易数据产生影响，给投资者造成损失。\n（8）由于用户的计算机应用操作能力或互联网知识的缺乏或对有关信息的错误理解，可能对用户的交易时间或交易数据造成影响，因此给用户造成损失。\n（9）因用户自身的疏忽造成账号或密码泄露，可能会给用户造成损失。\n（10）因黑客攻击、电子病毒等非新经板原因造成用户交易密码等重要信息泄露或遗失，由此给用户造成损失的。\n（11）其他可能导致用户损失的风险或事项。\n上述风险所导致的损失或责任，均应由用户自行承担，用户一经使用新经板或发生交易，即视为用户已经完全了解并理解网上交易的风险，并且能够承担网上交易可能带来的风险或损失。尽管如此，本着对客户负责的态度，新经板承诺将采取先进的网络产品和技术措施，最大限度地保护用户资料和交易活动的安全。\n四、凡通过本网站与其他网站的链接，而获得其所提供的网上资料及内容，您需要自己进行辨别及判断，我们不承担任何责任。本公司不为于本网站使用的任何第三方软件的准确性、安全性、功能或性能作任何声明或保证。\n 五、本站某些部分或网页可能包括单独条款和条件，作为对本条款和条件的补充，如果有任何冲突，该等附加条款和条件将对相关部分或网页适用。\n 提醒：您进入本app，即表示您同意遵守上述条款。谢谢选择新经板。";
        }
            break;
        case CMBaseViewDistinctionTypeDetails: //详情
        {
            titleStr = dict[@"rule"];
        }
            break;
        default:
            break;
    }
    CGFloat height = [titleStr getHeightIncomingWidth:CMScreen_width() - 20 incomingFont:13];
    if (height > CMScreen_height()) {
        height = height - CMScreen_height()+30;
    }
    _viewHeigthLayout.constant = height;
    
    _explainLab.text = titleStr;
    
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
