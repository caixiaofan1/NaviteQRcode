//
//  ViewController.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/22.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "ViewController.h"
#import "QRViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 100, 50);
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"二维码扫描" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushQR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
   
}


- (void)pushQR{
       QRViewController *QR = [[QRViewController alloc]init];
    [self.navigationController pushViewController:QR animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
