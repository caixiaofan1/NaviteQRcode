//
//  ViewController.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/22.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "ViewController.h"
#import "QRViewController.h"
#import "CreateQRcodeView.h"
#import "LongTapController.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 100, 50);
    btn.backgroundColor = [UIColor grayColor];
    btn.tag = 1001;
    [btn setTitle:@"二维码扫描" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushQR:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *CreatCodebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CreatCodebtn.frame = CGRectMake(150, 100, 100, 50);
    CreatCodebtn.backgroundColor = [UIColor grayColor];
    [CreatCodebtn setTitle:@"二维码生成" forState:UIControlStateNormal];
    CreatCodebtn.tag = 1002;
    [CreatCodebtn addTarget:self action:@selector(pushQR:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CreatCodebtn];

    UIButton *longTapCodebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    longTapCodebtn.frame = CGRectMake(10, 160, 100, 50);
    longTapCodebtn.backgroundColor = [UIColor grayColor];
    [longTapCodebtn setTitle:@"长按扫描图片二维码" forState:UIControlStateNormal];
    longTapCodebtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    longTapCodebtn.tag = 1003;
    [longTapCodebtn addTarget:self action:@selector(pushQR:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:longTapCodebtn];

}


- (void)pushQR:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1001:
        {
            QRViewController *QR = [[QRViewController alloc]init];
            [self.navigationController pushViewController:QR animated:YES];

        }
            break;
        case 1002:
        {
            CreateQRcodeView *QR = [[CreateQRcodeView alloc]init];
            [self.navigationController pushViewController:QR animated:YES];

        }
            break;
        case 1003:
        {
            LongTapController *QR = [[LongTapController alloc]init];
            [self.navigationController pushViewController:QR animated:YES];
            
        }
            break;

        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
