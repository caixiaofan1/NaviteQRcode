//
//  WebviewController.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/22.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "WebviewController.h"
#import <WebKit/WebKit.h>
@interface WebviewController ()
{
    WKWebView *webView;
    UIBarButtonItem *item1;
    UIBarButtonItem *item2;
    
}

@property (nonatomic,strong) UIProgressView *progressview;
@end

@implementation WebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //由于uiwebview使用会导致内存泄露   现在用wkwebview。
    //需要添加WebKit
    self.view.backgroundColor = [UIColor whiteColor];
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]]];
    webView.allowsBackForwardNavigationGestures =YES;
    [self.view addSubview:webView];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:NULL];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:NULL];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0, [UIScreen mainScreen].bounds.size.height-40, [UIScreen mainScreen].bounds.size.width, 40)];
    //创建barbuttonitem
    item1 = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(pageGo:)];
    [item1
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           systemFontOfSize:30], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [item1 setTintColor:[UIColor colorWithWhite:0.8 alpha:1]];
    item1.width = 60;
    //创建barbuttonitem
    item2 = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(pageNext:)];
    [item2 setTitleTextAttributes:[NSDictionary
                                   dictionaryWithObjectsAndKeys:[UIFont
                                                                 systemFontOfSize:30], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [item2 setTintColor:[UIColor colorWithWhite:0.8 alpha:1]];
    item2.width = 60;
    [toolbar setItems:[NSArray arrayWithObjects:item1,item2, nil] animated:YES];
    
    //把toolbar添加到view上
    [self.view addSubview:toolbar];
    
    //    在导航栏中设置进度条
    self.progressview = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressview.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 3);
    [self.progressview setTrackTintColor:[UIColor clearColor]];
    [self.progressview setTintColor:[UIColor blueColor]];
    [self.view addSubview:self.progressview];
    
}


//toorbar监听  当可以返回或者可以前往时   改变按钮的状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"canGoBack"] && [[change objectForKey:@"new"] integerValue] == 1) {
        [item1 setTintColor:[UIColor grayColor]];
    }
    if ([keyPath isEqualToString:@"canGoBack"] && [[change objectForKey:@"new"] integerValue] == 0) {
        [item1 setTintColor:[UIColor colorWithWhite:0.8 alpha:1]];
    }
    if ([keyPath isEqualToString:@"canGoForward"] && [[change objectForKey:@"new"] integerValue] == 1) {
        [item2 setTintColor:[UIColor grayColor]];
    }
    if ([keyPath isEqualToString:@"canGoForward"] && [[change objectForKey:@"new"] integerValue] == 0) {
        [item2 setTintColor:[UIColor colorWithWhite:0.8 alpha:1]];
    }
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        NSLog(@"%f",[[change objectForKey:@"new"] floatValue]);
        self.progressview.progress = [[change objectForKey:@"new"] floatValue];
        if ([[change objectForKey:@"new"] floatValue] == 1) {
            self.progressview.progress = 0;
        }
    }
    
    //    [item2 setTintColor:[UIColor grayColor]];
    
}


- (void)pageGo:(UIBarButtonItem *)item
{
    if ([webView canGoBack]) {
        [webView goBack];
        
    }
    
    
}
- (void)pageNext:(UIBarButtonItem *)item
{
    if ([webView canGoForward]) {
        [webView goForward];
    }
    
}
- (void)dealloc{
    NSLog(@"释放webview");
    [webView removeObserver:self forKeyPath:@"canGoBack"];
    [webView removeObserver:self forKeyPath:@"canGoForward"];
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
