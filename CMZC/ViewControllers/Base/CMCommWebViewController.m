//
//  CMCommWebViewController.m
//  CMZC
//
//  Created by 财猫 on 16/3/26.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#define kCMExternalLinksURL @"http://mz.58cm.com/GrantAccess?targetUrl="

#import "CMCommWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"


@interface CMCommWebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate> {
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic)NSString *currentURL;
@property (strong,nonatomic)NSString *currentTitle;
@property (nonatomic,copy) NSString *nextURL;


@end

@implementation CMCommWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CMAccountTool sharedCMAccountTool].currentAccount.userName.length >0) {
        [[CMTokenTimer sharedCMTokenTimer] cm_cmtokenTimerRefreshSuccess:^{
            [self loadWebViewData];
        } fail:^(NSError *error) {
            UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
            [self presentViewController:nav animated:YES completion:nil];
        }];
    } else {
        [self loadWebViewData];
    }
    
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [leftBarBtn setImage:[UIImage imageNamed:@"nav_back_left"] forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
   
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 30, 40);
    [rightBarBtn setImage:[UIImage imageNamed:@"refresh_line_thren"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

- (void)leftBarBtnClick {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


- (void)loadWebViewData
{
    NSString *external =[NSString stringWithFormat:@"%@%@",kCMExternalLinksURL,_urlStr];
    NSString *name = GetDataFromNSUserDefaults(@"name");
    NSString *value = GetDataFromNSUserDefaults(@"value");
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:external]];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *cookieValue = [NSString stringWithFormat:@"%@=%@",name,value];
    [mutableRequest addValue:cookieValue forHTTPHeaderField:@"cookie"];
    request = [mutableRequest copy];
    //4.查看请求头
    [_webView loadRequest:request];
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
   
}
- (void)loadCookies{
    NSString *name = GetDataFromNSUserDefaults(@"name");
    NSString *value = GetDataFromNSUserDefaults(@"value");
    
    NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
    [cookieDict setObject:name forKey:NSHTTPCookieName];
    [cookieDict setObject:value forKey:NSHTTPCookieValue];
    NSDictionary *prop1 = [NSDictionary dictionaryWithObjectsAndKeys:
                           name,NSHTTPCookieName,
                           value,NSHTTPCookieValue,
                           @"/",NSHTTPCookiePath,
                           [NSURL URLWithString:kCMBase_URL],NSHTTPCookieOriginURL,
                           [NSDate dateWithTimeIntervalSinceNow:60],NSHTTPCookieExpires,
                           nil];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:prop1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
}
- (void)backBtnClick
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)refreshWebView
{
    [self loadWebViewData];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // 获取当前页面的title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.currentURL = webView.request.URL.absoluteString;
    
}

#pragma mark - webDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //包含登录页面
    if ([self.nextURL containsString:CMStringWithPickFormat(kCMMZWeb_url,@"Login")]) {
        //跳转到登录
        [webView stopLoading];
        UINavigationController *nav = [UIStoryboard loginStoryboard].instantiateInitialViewController;
        [self presentViewController:nav animated:YES completion:nil];
    }
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.nextURL = request.URL.absoluteString;
    NSLog(@"----%@",request.URL.absoluteString);
    return YES;
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
