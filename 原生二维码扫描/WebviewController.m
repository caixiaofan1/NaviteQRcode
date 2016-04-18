//
//  WebviewController.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/22.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "WebviewController.h"

@interface WebviewController ()

@end

@implementation WebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:_webURL];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    

    
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
