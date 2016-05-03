//
//  LongTapController.m
//  原生二维码扫描
//
//  Created by 蔡晓凡 on 16/5/3.
//  Copyright © 2016年 caixiaofan. All rights reserved.
//

#import "LongTapController.h"
#import "KMQRCode.h"
#import "WebviewController.h"
@interface LongTapController ()
{
    UIImageView *imageview;
}
@end

@implementation LongTapController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIImage *image = [UIImage imageNamed:@"2.png"];
    imageview = [[UIImageView alloc]initWithImage:image];
    imageview.frame = CGRectMake(10, 50,image.size.width,image.size.height);
    [self.view addSubview:imageview];
    imageview.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];

    [imageview addGestureRecognizer:longpress];

}


-(void)longPress:(UILongPressGestureRecognizer *)sender{
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([KMQRCode longTapImage:imageview.image]!=nil) {
            
            
            WebviewController *webView = [[WebviewController alloc]init];
            webView.webURL = [KMQRCode longTapImage:imageview.image];
            NSLog(@"%@",self.navigationController);
            [self.navigationController pushViewController:webView animated:YES];
            
            
        }

    }
    
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
