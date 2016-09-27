//
//  CMBusinessNewsView.m
//  CMZC
//
//  Created by 财猫 on 16/3/17.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBusinessNewsView.h"

@interface CMBusinessNewsView ()

@property (strong, nonatomic) UIWebView *webView;


@end


@implementation CMBusinessNewsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CMBusinessNewsView *cmMedia = [[NSBundle mainBundle] loadNibNamed:@"CMBusinessNewsView" owner:self options:nil].firstObject;
        [self addSubview:cmMedia];
        cmMedia.translatesAutoresizingMaskIntoConstraints = NO;
        [self viewLayoutAllEdgesOfSubview:cmMedia];
        [self addSubview:self.webView];
        
    }
    return self;
}
- (void)setWebStr:(NSString *)webStr {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webStr]];
    
    [self.webView loadRequest:request];
    
    [self.webView loadHTMLString:webStr baseURL:nil];
}

- (UIWebView *)webView {
    if (!_webView) {
         _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CMScreen_width(), CGRectGetHeight(self.frame))];
    }
    return _webView;
}


@end





























