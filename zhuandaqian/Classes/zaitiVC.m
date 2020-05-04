#import "zaitiVC.h"

#import <WebKit/WebKit.h>
#define isIPhonex (CGSizeEqualToSize([UIScreen mainScreen].bounds.size,CGSizeMake(375, 812)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)))
#define phoneNavTabbar      ((isIPhonex)?44:20)
#define phonetabbar        ((isIPhonex)?49:20)
@interface zaitiVC ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *ww_wk;
@end


@implementation zaitiVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = self.title;
    self.view.backgroundColor = [UIColor whiteColor];
    _ww_wk =[[WKWebView alloc]initWithFrame:CGRectMake(0, phoneNavTabbar, self.view.frame.size.width, self.view.frame.size.height - phonetabbar)];
    _ww_wk.UIDelegate = self;
    _ww_wk.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.data1]];
    [self.ww_wk loadRequest:request];
    [self.view addSubview:self.ww_wk];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if ([[navigationAction.request.URL.absoluteString substringToIndex:3] isEqualToString:[NSString stringWithFormat:@"%@%@%@",@"i",@"t",@"m"]] || [[navigationAction.request.URL.absoluteString substringToIndex:5] isEqualToString:[NSString stringWithFormat:@"%@%@%@%@%@",@"i",@"t",@"u",@"n",@"e"]]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:navigationAction.request.URL.absoluteString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:navigationAction.request.URL.absoluteString]];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    [SVProgressHUD setMinimumDismissTimeInterval:3];
}

//加载完成进行隐藏
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
     [SVProgressHUD dismiss];
}

@end
