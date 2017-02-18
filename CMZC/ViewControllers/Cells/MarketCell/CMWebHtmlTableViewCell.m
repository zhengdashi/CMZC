//
//  CMWebHtmlTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMWebHtmlTableViewCell.h"


@interface CMWebHtmlTableViewCell ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *curWebView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end


@implementation CMWebHtmlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor cmBlockColor];
    self.curWebView.delegate = self;
    self.curWebView.scrollView.delegate = self;
    self.curWebView.backgroundColor = [UIColor cmBlockColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _bgView.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.y);
    if (self.curWebView.scrollView.contentOffset.y ==0) {
        self.block();
    }
}



/**
 传数据

 @param htmlString 链接
 */
- (void)setHtmlString:(NSString *)htmlString {
   // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]];
    //4.查看请求头
    [self.curWebView loadRequest:request];
}


@end
